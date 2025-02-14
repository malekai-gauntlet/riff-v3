import * as functions from 'firebase-functions';
import { defineSecret } from "firebase-functions/params";
import * as admin from 'firebase-admin';
import axios from 'axios';

// Initialize Firebase Admin if not already initialized
if (!admin.apps.length) {
  admin.initializeApp();
}

// Define the secret
const perplexityApiKey = defineSecret("PERPLEXITY_API_KEY");

interface RequestData {
  videoId: string;
  title: string;
  artist?: string;
}

interface Tutorial {
  channelName: string;
  title: string;
  url: string;
  viewCount: string;
}

interface Tab {
  difficulty: string;
  rating: string;
  title: string;
  type: string;
  url: string;
}

interface PerplexityResponse {
  tabs: Tab[];
  guitarproUrl: string | null;
  tutorials: Tutorial[];
}

export const gatherGuitarResources = functions.https.onCall(
  { 
    secrets: [perplexityApiKey]  // Explicitly declare secret usage
  },
  async (request: functions.https.CallableRequest<RequestData>) => {
    console.log('🚀 Function started with data:', JSON.stringify(request.data, null, 2));
    
    try {
      const { videoId, title, artist } = request.data;
      console.log('📝 Extracted data:', { videoId, title, artist });
      
      if (!videoId || !title) {
        console.error('❌ Missing required fields:', { videoId, title });
        throw new functions.https.HttpsError(
          'invalid-argument',
          'The function must be called with videoId and title.'
        );
      }

      // Construct the search query
      const searchQuery = artist ? `${title} by ${artist}` : title;
      console.log('🔍 Search query:', searchQuery);

      // Log the API key info (safely)
      const apiKey = perplexityApiKey.value();
      console.log('🔑 API Key check:', {
        exists: !!apiKey,
        length: apiKey?.length ?? 0,
        firstChar: apiKey ? apiKey[0] : 'none',
        lastChar: apiKey ? apiKey[apiKey.length - 1] : 'none',
        startsWithPplx: apiKey?.startsWith('pplx-') || false  // Add this check
      });

      console.log('📡 Making Perplexity API request with config:', {
        url: 'https://api.perplexity.ai/chat/completions',
        model: 'sonar-pro',
        hasAuthHeader: !!apiKey,
        authHeaderFormat: apiKey ? `Bearer ${apiKey.substring(0, 10)}...` : 'none'
      });
      let response;
      try {
        response = await axios.post(
          'https://api.perplexity.ai/chat/completions',
          {
            model: 'sonar-pro',
            messages: [
              {
                role: 'system',
                content: 'You are a guitar expert assistant. Search for and return guitar learning resources in JSON format. You must return EXACTLY ONE of each: 1. ONE best rated Guitar Pro tab on Ultimate Guitar (specifically look for .gp5, .gpx, or .gp files) - Sort by rating (4+ stars preferred) - Check number of reviews - Prioritize official or highly verified tabs 2. ONE best standard tab on Ultimate Guitar - Must have 4+ star rating - Consider number of reviews 3. ONE best YouTube tutorial - Consider views, likes, and teaching quality - Prefer comprehensive lessons from well-known teachers Return only direct URLs and relevant metadata. For Guitar Pro tabs, ensure you find the actual tab file, not just the preview page. You must return exactly one of each type - no more, no less.'
              },
              {
                role: 'user',
                content: `Find guitar learning resources for "${searchQuery}". Return in this exact JSON format, with exactly one item in each array: { "tabs": [{ "difficulty": "beginner|intermediate|advanced", "rating": "0.0/5", "title": "exact tab title", "type": "tab", "url": "ultimate-guitar-url" }], "guitarproUrl": "direct-guitar-pro-url", "tutorials": [{ "channelName": "YouTube channel name", "title": "exact video title", "url": "youtube-url", "viewCount": "view count with units (e.g., 211k views)" }] } Remember: Return exactly ONE tab, ONE Guitar Pro URL, and ONE tutorial.`
              }
            ],
            temperature: 0.2,
            top_p: 0.9,
            return_citations: true,
            search_domain_filter: ['perplexity.ai'],
            return_images: false,
            return_related_questions: false,
            search_recency_filter: 'month',
            top_k: 0,
            stream: false,
            presence_penalty: 0,
            frequency_penalty: 1
          },
          {
            headers: {
              'Authorization': 'Bearer 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',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          }
        );
        console.log('✅ Perplexity API response received:', {
          status: response.status,
          statusText: response.statusText,
          headers: response.headers,
          data: JSON.stringify(response.data, null, 2)
        });

        // Parse the response content
        const responseContent = response.data.choices[0].message.content;
        const resources: PerplexityResponse = JSON.parse(responseContent);

        // Update Firestore document
        const db = admin.firestore();
        await db.collection('videos').doc(videoId).update({
          // Add tutorials array with the found tutorial and its associated tabs
          tutorials: resources.tutorials.map((tutorial: Tutorial) => ({
            channelName: tutorial.channelName,
            title: tutorial.title,
            url: tutorial.url,
            viewCount: tutorial.viewCount,
            thumbnailUrl: '', // Will be populated later if needed
            youtubeId: tutorial.url.split('v=')[1] || '', // Extract YouTube ID from URL
            duration: '', // Will be populated later if needed
            isBestMatch: true, // Since we're only getting one best match
            tabs: resources.tabs // Nest tabs inside the tutorial
          })),
          // Add guitarproUrl if found
          guitarproUrl: resources.guitarproUrl || null,
          // Update timestamp
          updatedAt: admin.firestore.FieldValue.serverTimestamp()
        });

        return { 
          success: true,
          message: 'Resources gathered and stored successfully',
          response: resources
        };

      } catch (apiError: any) {
        console.error('❌ Perplexity API request failed:', {
          status: apiError.response?.status,
          statusText: apiError.response?.statusText,
          data: apiError.response?.data,
          headers: apiError.response?.headers,
          error: apiError.message,
          stack: apiError.stack,
          requestConfig: {
            url: apiError.config?.url,
            method: apiError.config?.method,
            hasData: !!apiError.config?.data,
            dataPreview: apiError.config?.data ? JSON.stringify(apiError.config.data).substring(0, 100) + '...' : null
          }
        });
        throw new functions.https.HttpsError(
          'internal',
          'Perplexity API request failed',
          apiError
        );
      }

    } catch (error: any) {
      console.error('❌ Error details:', {
        name: error.name,
        message: error.message,
        response: error.response?.data,
        stack: error.stack
      });

      if (axios.isAxiosError(error)) {
        console.error('📡 Axios error details:', {
          status: error.response?.status,
          statusText: error.response?.statusText,
          data: error.response?.data,
          headers: error.response?.headers
        });
      }

      throw new functions.https.HttpsError(
        'internal',
        'API call failed',
        error
      );
    }
  }
); 
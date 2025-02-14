import * as functions from 'firebase-functions';
import { defineSecret } from "firebase-functions/params";
import axios from 'axios';

// Define the secret
const perplexityApiKey = defineSecret("PERPLEXITY_API_KEY");

interface RequestData {
  videoId: string;
  title: string;
  artist?: string;
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
        lastChar: apiKey ? apiKey[apiKey.length - 1] : 'none'
      });

      console.log('📡 Making Perplexity API request...');
      let response;
      try {
        response = await axios.post(
          'https://api.perplexity.ai/chat/completions',
          {
            model: 'llama-3.1-sonar-huge-128k-online',
            messages: [
              {
                role: 'system',
                content: `You are a guitar expert assistant. Search for and return guitar learning resources in JSON format. Focus on finding:
                1. Best rated Guitar Pro tab on Ultimate Guitar (specifically look for .gp5, .gpx, or .gp files)
                   - Sort by rating (4+ stars preferred)
                   - Check number of reviews
                   - Prioritize official or highly verified tabs
                2. Best standard tab on Ultimate Guitar
                   - Must have 4+ star rating
                   - Consider number of reviews
                3. Most helpful YouTube tutorial (consider views, likes, and teaching quality)
                Return only direct URLs and relevant metadata. For Guitar Pro tabs, ensure you find the actual tab file, not just the preview page.`
              },
              {
                role: 'user',
                content: `Find guitar learning resources for "${searchQuery}". Return in this exact JSON format:
                {
                  "tabs": [{
                    "difficulty": "beginner|intermediate|advanced",
                    "rating": "0.0/5",
                    "title": "exact tab title",
                    "type": "tab",
                    "url": "ultimate-guitar-url"
                  }],
                  "guitarproUrl": "direct-guitar-pro-url",
                  "tutorials": [{
                    "channelName": "YouTube channel name",
                    "title": "exact video title",
                    "url": "youtube-url",
                    "viewCount": "view count with units (e.g., 211k views)"
                  }]
                }`
              }
            ],
            temperature: 0.5,
            max_tokens: 1000,
          },
          {
            headers: {
              'Authorization': `Bearer ${apiKey}`,
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

        return { 
          success: true,
          message: 'API call successful',
          response: response.data
        };

      } catch (apiError: any) {
        console.error('❌ Perplexity API request failed:', {
          status: apiError.response?.status,
          statusText: apiError.response?.statusText,
          data: apiError.response?.data,
          headers: apiError.response?.headers,
          error: apiError.message,
          stack: apiError.stack
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
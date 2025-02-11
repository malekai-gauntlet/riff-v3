# Ultimate Guitar Tab JSON Structure Analysis

## Overview
This document analyzes the JSON structure used by Ultimate Guitar for tab representation. Understanding this structure is crucial for generating compatible tab output from our AI system.

## Basic Tab JSON Structure
```json
{
  "tab_version": {
    "version": "1.0",
    "revision": 1
  },
  "song_info": {
    "title": "Song Title",
    "artist": "Artist Name",
    "tuning": ["E", "A", "D", "G", "B", "E"],
    "capo": 0,
    "difficulty": "intermediate"
  },
  "meta": {
    "tempo": 120,
    "time_signature": "4/4",
    "key": "C"
  },
  "content": {
    "measures": [
      {
        "index": 0,
        "time_signature": "4/4",
        "strings": [
          {
            "string": 1,
            "notes": [
              {
                "fret": 0,
                "duration": 1,
                "position": 0,
                "technique": null
              }
            ]
          }
        ]
      }
    ]
  }
}
```

## Field Descriptions

### Tab Version
- `version`: Schema version
- `revision`: Tab revision number

### Song Information
- `title`: Song name
- `artist`: Artist name
- `tuning`: Array of strings representing tuning from low to high
- `capo`: Capo position (0 if none)
- `difficulty`: Difficulty level

### Meta Information
- `tempo`: BPM (beats per minute)
- `time_signature`: Time signature (e.g., "4/4")
- `key`: Song key

### Content Structure
- `measures`: Array of measure objects
  - `index`: Measure number (0-based)
  - `time_signature`: Time signature for this measure
  - `strings`: Array of string objects
    - `string`: String number (1-6, 1 is highest E)
    - `notes`: Array of note objects
      - `fret`: Fret number (0 for open)
      - `duration`: Note duration in beats
      - `position`: Position within measure (0-based)
      - `technique`: Special technique (null if none)

## Example Single-Note Melody
```json
{
  "tab_version": {
    "version": "1.0",
    "revision": 1
  },
  "song_info": {
    "title": "Simple Melody",
    "artist": "AI Generated",
    "tuning": ["E", "A", "D", "G", "B", "E"],
    "capo": 0,
    "difficulty": "beginner"
  },
  "meta": {
    "tempo": 120,
    "time_signature": "4/4",
    "key": "C"
  },
  "content": {
    "measures": [
      {
        "index": 0,
        "time_signature": "4/4",
        "strings": [
          {
            "string": 1,
            "notes": [
              {
                "fret": 0,
                "duration": 1,
                "position": 0,
                "technique": null
              },
              {
                "fret": 1,
                "duration": 1,
                "position": 1,
                "technique": null
              }
            ]
          }
        ]
      }
    ]
  }
}
```

## Important Notes

### Duration Values
- 1: Quarter note
- 0.5: Eighth note
- 0.25: Sixteenth note
- 2: Half note
- 4: Whole note

### Position Values
- Based on beats in the measure
- 0 is start of measure
- Position + Duration should not exceed measure length

### String Numbers
- 1: High E
- 2: B
- 3: G
- 4: D
- 5: A
- 6: Low E

### Techniques (Future Implementation)
- "slide"
- "bend"
- "hammer-on"
- "pull-off"
- "vibrato"

## Implementation Guidelines

### For MVP
1. Focus on single-string melodies
2. Use simple durations (quarter and eighth notes)
3. Avoid complex techniques initially
4. Stick to standard tuning
5. Use 4/4 time signature

### Validation Rules
1. Check measure completeness
2. Verify note positions
3. Ensure valid fret numbers
4. Validate string numbers
5. Check duration totals

### Future Considerations
1. Multiple simultaneous notes (chords)
2. Alternative tunings
3. Complex time signatures
4. Advanced techniques
5. Multiple voices/parts 
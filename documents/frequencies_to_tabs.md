# Converting Frequencies to Guitar Tabs

## Overview
This document outlines the step-by-step process for converting audio frequency data into guitar tablature format for storage in Firestore.

## Steps

### 1. Frequency to Note Conversion
- [ ] Create a frequency-to-note mapping function
  - [ ] Define frequency ranges for each musical note (E2 to E6)
  - [ ] Handle harmonics and overtones
  - [ ] Account for slight frequency variations/tuning differences
  - [ ] Map frequencies to note names (e.g., 82Hz → E2)

### 2. Note to Guitar Position Mapping
- [ ] Create a note-to-fret position mapping
  - [ ] Define all possible positions for each note on the fretboard
  - [ ] Create logic to choose the most ergonomic position
  - [ ] Handle position transitions between notes
  - [ ] Consider string changes vs. position shifts

### 3. Timing and Measure Organization
- [ ] Process timing information
  - [ ] Convert note indices to rhythmic values
  - [ ] Handle null frequencies as rests
  - [ ] Group notes into measures (4/4 time)
  - [ ] Determine note durations (1/4, 1/8, etc.)

### 4. Tab Data Structure Creation
- [ ] Format data for Firestore
  - [ ] Create measure objects
  - [ ] Structure note objects with:
    ```typescript
    {
      string: number, // 1-6
      fret: number,   // 0-24
      duration: number // 1 = quarter note
    }
    ```
  - [ ] Group notes into measures
  - [ ] Add metadata (time signature, difficulty, etc.)

### 5. Optimization and Cleanup
- [ ] Implement tab optimization
  - [ ] Minimize hand position changes
  - [ ] Keep notes within reasonable positions
  - [ ] Handle special cases (bends, slides, etc.)
  - [ ] Clean up noise and artifacts

### 6. Testing and Validation
- [ ] Create test cases
  - [ ] Test with simple melodies
  - [ ] Test with complex passages
  - [ ] Validate measure grouping
  - [ ] Verify playability of generated tabs

## Technical Details

### Frequency Ranges for Guitar Strings (Standard Tuning)
- Low E (E2): 82.41 Hz
- A (A2): 110.00 Hz
- D (D3): 146.83 Hz
- G (G3): 196.00 Hz
- B (B3): 246.94 Hz
- High E (E4): 329.63 Hz

### Note Duration Values
- Whole note: 4
- Half note: 2
- Quarter note: 1
- Eighth note: 0.5
- Sixteenth note: 0.25

### Firestore Data Structure
```typescript
interface Tab {
  sections: {
    measures: {
      notes: {
        string: number,  // 1-6 (1 = high E)
        fret: number,    // 0-24
        duration: number // relative to quarter note
      }[]
    }[]
  }[]
}
```

## Progress Tracking
- [ ] Step 1 Complete
- [ ] Step 2 Complete
- [ ] Step 3 Complete
- [ ] Step 4 Complete
- [ ] Step 5 Complete
- [ ] Step 6 Complete

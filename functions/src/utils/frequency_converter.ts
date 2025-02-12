/**
 * Utility functions for converting frequencies to musical notes and guitar positions
 */

interface GuitarNote {
  frequency: number;
  string: number;  // 1-6 (6 is low E)
  fret: number;    // 0-20 (limiting to 20 frets as per chart)
}

// Define all possible notes on a guitar in standard tuning (frequencies from standard chart)
const GUITAR_NOTES: { [note: string]: GuitarNote[] } = {
  // Low E String (6th string)
  "E2": [{ frequency: 82, string: 6, fret: 0 }],
  "F2": [{ frequency: 87, string: 6, fret: 1 }],
  "F#2": [{ frequency: 92, string: 6, fret: 2 }],
  "G2": [{ frequency: 98, string: 6, fret: 3 }],
  "G#2": [{ frequency: 104, string: 6, fret: 4 }],
  "A2": [
    { frequency: 110, string: 5, fret: 0 },
    { frequency: 110, string: 6, fret: 5 }
  ],
  "A#2": [
    { frequency: 117, string: 5, fret: 1 },
    { frequency: 117, string: 6, fret: 6 }
  ],
  "B2": [
    { frequency: 123, string: 5, fret: 2 },
    { frequency: 123, string: 6, fret: 7 }
  ],
  "C3": [
    { frequency: 131, string: 5, fret: 3 },
    { frequency: 131, string: 6, fret: 8 }
  ],
  "C#3": [
    { frequency: 139, string: 5, fret: 4 },
    { frequency: 139, string: 6, fret: 9 }
  ],
  "D3": [
    { frequency: 147, string: 4, fret: 0 },
    { frequency: 147, string: 5, fret: 5 },
    { frequency: 147, string: 6, fret: 10 }
  ],
  "D#3": [
    { frequency: 156, string: 4, fret: 1 },
    { frequency: 156, string: 5, fret: 6 },
    { frequency: 156, string: 6, fret: 11 }
  ],
  "E3": [
    { frequency: 165, string: 4, fret: 2 },
    { frequency: 165, string: 5, fret: 7 },
    { frequency: 165, string: 6, fret: 12 }
  ],
  "F3": [
    { frequency: 175, string: 4, fret: 3 },
    { frequency: 175, string: 5, fret: 8 },
    { frequency: 175, string: 6, fret: 13 }
  ],
  "F#3": [
    { frequency: 185, string: 4, fret: 4 },
    { frequency: 185, string: 5, fret: 9 },
    { frequency: 185, string: 6, fret: 14 }
  ],
  "G3": [
    { frequency: 196, string: 3, fret: 0 },
    { frequency: 196, string: 4, fret: 5 },
    { frequency: 196, string: 5, fret: 10 },
    { frequency: 196, string: 6, fret: 15 }
  ],
  "G#3": [
    { frequency: 208, string: 3, fret: 1 },
    { frequency: 208, string: 4, fret: 6 },
    { frequency: 208, string: 5, fret: 11 },
    { frequency: 208, string: 6, fret: 16 }
  ],
  "A3": [
    { frequency: 220, string: 3, fret: 2 },
    { frequency: 220, string: 4, fret: 7 },
    { frequency: 220, string: 5, fret: 12 },
    { frequency: 220, string: 6, fret: 17 }
  ],
  "A#3": [
    { frequency: 233, string: 3, fret: 3 },
    { frequency: 233, string: 4, fret: 8 },
    { frequency: 233, string: 5, fret: 13 },
    { frequency: 233, string: 6, fret: 18 }
  ],
  "B3": [
    { frequency: 247, string: 2, fret: 0 },
    { frequency: 247, string: 3, fret: 4 },
    { frequency: 247, string: 4, fret: 9 },
    { frequency: 247, string: 5, fret: 14 },
    { frequency: 247, string: 6, fret: 19 }
  ],
  "C4": [
    { frequency: 262, string: 2, fret: 1 },
    { frequency: 262, string: 3, fret: 5 },
    { frequency: 262, string: 4, fret: 10 },
    { frequency: 262, string: 5, fret: 15 },
    { frequency: 262, string: 6, fret: 20 }
  ],
  "C#4": [
    { frequency: 277, string: 2, fret: 2 },
    { frequency: 277, string: 3, fret: 6 },
    { frequency: 277, string: 4, fret: 11 },
    { frequency: 277, string: 5, fret: 16 }
  ],
  "D4": [
    { frequency: 294, string: 2, fret: 3 },
    { frequency: 294, string: 3, fret: 7 },
    { frequency: 294, string: 4, fret: 12 },
    { frequency: 294, string: 5, fret: 17 }
  ],
  "D#4": [
    { frequency: 311, string: 2, fret: 4 },
    { frequency: 311, string: 3, fret: 8 },
    { frequency: 311, string: 4, fret: 13 },
    { frequency: 311, string: 5, fret: 18 }
  ],
  "E4": [
    { frequency: 330, string: 1, fret: 0 },
    { frequency: 330, string: 2, fret: 5 },
    { frequency: 330, string: 3, fret: 9 },
    { frequency: 330, string: 4, fret: 14 },
    { frequency: 330, string: 5, fret: 19 }
  ],
  "F4": [
    { frequency: 349, string: 1, fret: 1 },
    { frequency: 349, string: 2, fret: 6 },
    { frequency: 349, string: 3, fret: 10 },
    { frequency: 349, string: 4, fret: 15 }
  ],
  "F#4": [
    { frequency: 370, string: 1, fret: 2 },
    { frequency: 370, string: 2, fret: 7 },
    { frequency: 370, string: 3, fret: 11 },
    { frequency: 370, string: 4, fret: 16 }
  ],
  "G4": [
    { frequency: 392, string: 1, fret: 3 },
    { frequency: 392, string: 2, fret: 8 },
    { frequency: 392, string: 3, fret: 12 },
    { frequency: 392, string: 4, fret: 17 }
  ],
  "G#4": [
    { frequency: 415, string: 1, fret: 4 },
    { frequency: 415, string: 2, fret: 9 },
    { frequency: 415, string: 3, fret: 13 },
    { frequency: 415, string: 4, fret: 18 }
  ],
  "A4": [
    { frequency: 440, string: 1, fret: 5 },
    { frequency: 440, string: 2, fret: 10 },
    { frequency: 440, string: 3, fret: 14 }
  ],
  "A#4": [
    { frequency: 466, string: 1, fret: 6 },
    { frequency: 466, string: 2, fret: 11 },
    { frequency: 466, string: 3, fret: 15 }
  ],
  "B4": [
    { frequency: 494, string: 1, fret: 7 },
    { frequency: 494, string: 2, fret: 12 },
    { frequency: 494, string: 3, fret: 16 }
  ],
  "C5": [
    { frequency: 523, string: 1, fret: 8 },
    { frequency: 523, string: 2, fret: 13 }
  ],
  "C#5": [
    { frequency: 554, string: 1, fret: 9 },
    { frequency: 554, string: 2, fret: 14 }
  ],
  "D5": [
    { frequency: 587, string: 1, fret: 10 },
    { frequency: 587, string: 2, fret: 15 }
  ],
  "D#5": [
    { frequency: 622, string: 1, fret: 11 },
    { frequency: 622, string: 2, fret: 16 }
  ],
  "E5": [
    { frequency: 659, string: 1, fret: 12 },
    { frequency: 659, string: 2, fret: 17 }
  ],
  "F5": [
    { frequency: 698, string: 1, fret: 13 },
    { frequency: 698, string: 2, fret: 18 }
  ],
  "F#5": [
    { frequency: 740, string: 1, fret: 14 },
    { frequency: 740, string: 2, fret: 19 }
  ],
  "G5": [
    { frequency: 784, string: 1, fret: 15 },
    { frequency: 784, string: 2, fret: 20 }
  ],
  "G#5": [{ frequency: 831, string: 1, fret: 16 }],
  "A5": [{ frequency: 880, string: 1, fret: 17 }],
  "A#5": [{ frequency: 932, string: 1, fret: 18 }],
  "B5": [{ frequency: 988, string: 1, fret: 19 }],
  "C6": [{ frequency: 1047, string: 1, fret: 20 }]
};

/**
 * Determines if a frequency is within an acceptable range of a target frequency.
 * Uses a 3% tolerance range to account for slight tuning variations and frequency detection inaccuracies.
 * 
 * @param frequency - The detected frequency to check (in Hz)
 * @param targetFrequency - The target frequency to compare against (in Hz)
 * @returns boolean - true if frequency is within tolerance range of target
 * 
 * @example
 * // Check if 442Hz is close enough to A4 (440Hz)
 * const isValidA4 = isFrequencyInRange(442, 440); // true
 */
export function isFrequencyInRange(frequency: number, targetFrequency: number): boolean {
  const tolerance = 0.03; // 3% tolerance
  const lowerBound = targetFrequency * (1 - tolerance);
  const upperBound = targetFrequency * (1 + tolerance);
  return frequency >= lowerBound && frequency <= upperBound;
}

/**
 * Converts a frequency to the closest guitar note with string and fret position
 * @param frequency - The frequency to convert
 * @returns Object containing note name and positions, or null if no match found
 */
export function frequencyToNote(frequency: number): { 
  note: string;
  positions: { string: number; fret: number; }[];
} | null {
  // Handle null or invalid frequencies
  if (!frequency || frequency <= 0) {
    return null;
  }

  // Find the closest matching note
  let closestNote: string | null = null;
  let minDifference = Infinity;

  for (const [note, positions] of Object.entries(GUITAR_NOTES)) {
    const difference = Math.abs(frequency - positions[0].frequency);
    if (difference < minDifference) {
      minDifference = difference;
      closestNote = note;
    }
  }

  if (closestNote && GUITAR_NOTES[closestNote]) {
    return {
      note: closestNote,
      positions: GUITAR_NOTES[closestNote].map(pos => ({
        string: pos.string,
        fret: pos.fret,
      })),
    };
  }

  return null;
}

/**
 * Test function for frequency conversion
 * @param frequencies - Array of frequencies to test
 */
export function testFrequencyConversion(frequencies: number[]): void {
  console.log("Testing frequency conversion:");
  frequencies.forEach((freq, index) => {
    const result = frequencyToNote(freq);
    if (result) {
      console.log(`Index ${index}: ${freq}Hz -> ${result.note} (Positions: ${
        result.positions.map(p => `String ${p.string} Fret ${p.fret}`).join(", ")
      })`);
    }
  });
} 
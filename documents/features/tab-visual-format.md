# Tab Visual Format Specification

## Overview
This document outlines the visual formatting requirements for displaying guitar tabs in a style consistent with Ultimate Guitar's mobile interface.

## Basic Structure

```
[Section Name]

e|-------5-7-----7-|-8-----8-2-----2-|-0-
B|-----5-----5-----|-5-----5-3-------|-1-
G|---5---------5---|-5-----5-2-------|-0-
D|-7-------6-------|-5-----4---------|-2-
A|-----------------|-----------------|---
E|-----------------|-----------------|---
    Lyrics go here     More lyrics     etc
```

## Format Elements

### String Labels
- Six strings labeled from high to low: e|B|G|D|A|E
- Each string gets its own line
- String labels are left-aligned
- Vertical bar (|) separates label from tab content

### Timing and Spacing
- Dashes (-) represent timing/spacing
- Each dash typically represents an 8th or 16th note
- Number of dashes between notes indicates duration
- Consistent spacing for readability

### Measure Markers
- Vertical bars (|) separate measures
- Must align perfectly across all strings
- Double bars (||) can indicate section endings

### Fret Numbers
- Single or double digit numbers (0-24)
- Placed in the correct timing position
- No leading zeros
- Special characters for techniques (h,p,b,/) when needed

### Section Headers
- Enclosed in square brackets [Section Name]
- Common sections: [Intro], [Verse], [Chorus], [Bridge], [Solo]
- Clear spacing before and after headers

### Lyrics Integration
- Placed below the tab lines
- Aligned with corresponding notes above
- Indented to match tab spacing
- Optional chord names above lyrics

## Special Notations

### Techniques
```
Hammer-on:    2h4
Pull-off:     4p2
Bend:         7b9
Slide:        5/7
Vibrato:      7~
```

### Repeat Markers
```
|-------------------------|
First time: 1--|
Second time: 2--|
```

## Implementation Requirements

### Text Alignment
- Monospace font required for proper alignment
- All vertical elements must align perfectly
- Consistent character spacing

### Measure Formatting
- Each measure should have equal width when possible
- Maintain readability with appropriate spacing
- Handle varying measure lengths gracefully

### Mobile Display
- Horizontal scrolling for long measures
- Maintain vertical alignment during scroll
- Readable font size on mobile devices
- Support for pinch-to-zoom

### Section Organization
- Clear visual separation between sections
- Consistent indentation
- Optional collapsible sections

## Example Output

```
[Intro]

e|-------5-7-----7-|-8-----8-2-----2-|-0-
B|-----5-----5-----|-5-----5-3-------|-1-
G|---5---------5---|-5-----5-2-------|-0-
D|-7-------6-------|-5-----4---------|-2-
A|-----------------|-----------------|---
E|-----------------|-----------------|---

[Verse]

e|-------5-7-----7-|-8-----8-2-----|
B|-----5-----5-----|-5-----5-3-----|
G|---5---------5---|-5-----5-2-----|
D|-7-------6-------|-5-----4-------|
A|-----------------|---------------|
E|-----------------|---------------|
There's a lady who's sure all that glitters is gold

e|-------5-7-----7-|-8-----8-2-----|
B|-----5-----5-----|-5-----5-3-----|
G|---5---------5---|-5-----5-2-----|
D|-7-------6-------|-5-----4-------|
A|-----------------|---------------|
E|-----------------|---------------|
And she's buying a stairway to heaven
```

## Conversion Process

1. **From JSON to Visual**
   - Convert measure data to string lines
   - Calculate proper spacing
   - Add string labels
   - Insert measure markers
   - Add section headers
   - Align lyrics

2. **From Audio to Visual**
   - Detect notes and timing
   - Map to closest string/fret combination
   - Generate measure structure
   - Create visual representation
   - Add basic section markers

## Mobile UI Considerations

1. **Display Features**
   - Auto-scroll option
   - Zoom controls
   - Dark/Light mode
   - Font size adjustment
   - Landscape/Portrait support

2. **Interactive Elements**
   - Tap to play section
   - Scroll sync with audio
   - Section navigation
   - Quick jump to section

## Notes
- Focus on readability first
- Maintain consistent spacing
- Support both simple and complex tabs
- Consider mobile screen limitations
- Allow for user customization 
# Music Reading Trainer

A browser-based sight-reading trainer for musicians. Practice
identifying intervals on the staff in real keys, with audio playback
to reinforce what you see.

**Live app:** https://filmnoises.github.io/Music-Reading/

**Sister app:** [Ear Trainer](https://filmnoises.github.io/Ear-Training/) —
trains the same underlying skill (interval and chord recognition)
through audio alone. Use the two together as paired tools for the
same musicianship.

## What's in this release (v0.2.0)

All twelve intervals (minor 2nd through octave) across fourteen keys,
with full control over clef, direction, and interval type.

### Keys — circle of fifths

Keys are arranged in circle of fifths order. Each major key is paired
with its relative minor (same key signature):

| Major | Relative minor | Accidentals |
|-------|---------------|-------------|
| C major | A minor | none |
| G major | E minor | 1 sharp (F♯) |
| D major | B minor | 2 sharps |
| A major | F♯ minor | 3 sharps |
| E major | C♯ minor | 4 sharps |
| F major | D minor | 1 flat (B♭) |
| B♭ major | G minor | 2 flats |

### Clef

Treble, Bass, or **Both** (grand staff view — the layout pianists read
from). Audio always plays the treble-clef octave; the bass staff shows
the same interval one octave lower for visual reference.

### Note Reference

A collapsible panel shows every natural note on both staves with
letter-name labels — a visual guide for absolute beginners learning to
orient on the staff. Ledger-line notes are highlighted in gold.

### Activity modes

- **Learn** — interval and both notes are shown; the exercise plays
  automatically. Use Reveal Notes to confirm the note names and
  interval. Press Next for a new exercise.
- **Quiz** — the second note is hidden. Identify it by clicking the
  correct note name. Three attempts before the answer is revealed.

### Exercise controls

- **Direction** — Ascending, Descending, or Both.
- **Interval** — All, or lock to any single interval (m2 through P8).
- **Descending Perfect Intervals** — affects P4, P5, and octave only:
  - *Root Relative* — same note going up and down (C–G in both
    directions). The interval inverts but stays in key. Recommended
    for sight-singing and beginners.
  - *Exact Distance* — same number of semitones in both directions
    (C up to G, C down to F). Used for Circle of Fifths thinking.

## Future releases

- **v0.3.0** — D major / B minor (2 sharps)
- **v0.4.0** — F major / D minor (1 flat), opening the flat side
- Additional content levels: triads, seventh chords, scales

See [CHANGELOG.md](CHANGELOG.md) for full version history.

## Built on

- **[VexFlow](https://github.com/0xfe/vexflow)** by Mohit Muthanna —
  music notation rendering (MIT License)
- **[Tone.js](https://tonejs.github.io/)** by Yotam Mann — Web Audio
  framework (MIT License)
- **[Salamander Grand Piano V3](https://archive.org/details/SalamanderGrandPianoV3)**
  by Alexander Holm — piano samples (CC-BY 3.0)

## Accessibility

This is a sight-reading trainer — its purpose is developing visual
recognition of music notation. All interactive controls are fully
keyboard-navigable and screen-reader friendly. The staff itself is not
announced audibly, since doing so would defeat the purpose of the
visual quizzes.

If you can't read notation visually, the companion
[Ear Trainer](https://filmnoises.github.io/Ear-Training/) trains the
same underlying skills through audio alone.

## License

This app's code is released under the MIT License. See [LICENSE](LICENSE)
for details. Third-party libraries retain their own licenses (listed
in the Attribution section of the app).

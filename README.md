# Music Reading Trainer

A browser-based sight-reading trainer for musicians. Practice
identifying intervals on the staff in real keys, with audio playback
to reinforce what you see.

**Live app:** https://filmnoises.github.io/Music-Reading/

**Sister app:** [Ear Trainer](https://filmnoises.github.io/Ear-Training/) —
trains the same underlying skill (interval and chord recognition)
through audio alone. Use the two together as paired tools for the
same musicianship.

## What's in this release (v0.1.0)

Level 1: Intervals from minor 2nd through octave, in three keys:

- **C major** — no accidentals; the simplest starting point
- **G major** — one sharp (F♯)
- **E minor** — relative minor of G major, same key signature

Both **treble and bass clefs** are supported. Each exercise plays the
root note, the second note, then both together — mirroring how a
musician would practice an interval at an instrument.

Two activity modes:

- **Learn** — exercises are presented with the answer visible, for
  exploration and pattern recognition.
- **Quiz** — the second note is hidden; you identify it by clicking
  the correct note name. Three attempts before the answer is revealed.

## Future releases

New keys will be added one major/minor pair at a time, climbing the
circle of fifths. Each release adds one accidental's worth of new
material:

- **v0.2.0** (planned) — A minor (relative minor of C major, no accidentals)
- **v0.3.0** (planned) — F major + D minor (one flat)
- **v0.4.0** (planned) — D major + B minor (two sharps)
- ... and so on.

See [CHANGELOG.md](CHANGELOG.md) for full version history and the
`[Unreleased]` section for planned work.

## Built on

- **[VexFlow](https://github.com/0xfe/vexflow)** by Mohit Muthanna —
  music notation rendering (MIT License)
- **[Tone.js](https://tonejs.github.io/)** by Yotam Mann — Web Audio
  framework (MIT License)
- **[Salamander Grand Piano V3](https://archive.org/details/SalamanderGrandPianoV3)**
  by Alexander Holm — piano samples (CC-BY 3.0)

## Accessibility

This is a sight-reading trainer — its purpose is developing visual
recognition of music notation. The app's interactive controls (clef
toggle, key selector, mode toggle, quiz buttons, audio controls) are
fully keyboard-navigable and screen-reader friendly. The staff itself,
however, is not designed to be read aloud, since doing so would
defeat the purpose of the visual quizzes.

If you can't read music notation visually, our companion app
[Ear Trainer](https://filmnoises.github.io/Ear-Training/) trains the
same underlying skill (interval and chord recognition) through audio
alone.

## License

This app's code is released under the MIT License. See [LICENSE](LICENSE)
for details. (Third-party libraries are listed in the Attribution
section of the app and retain their own licenses.)

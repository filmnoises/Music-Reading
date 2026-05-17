# Changelog

All notable changes to the Music Reading Trainer are documented in
this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- **v0.2.0** — Add A minor (relative minor of C major). Both share
  the no-accidentals key signature; pairing them in the app teaches
  the relative-major/minor relationship at the simplest level.
- **v0.3.0** — Add F major and D minor (one flat each, a relative
  pair). Introduces the flat side of the circle of fifths.
- **v0.4.0** — Add D major and B minor (two sharps).
- **v0.5.0** — Add B♭ major and G minor (two flats).
- Additional levels beyond Level 1 (intervals): triads, seventh
  chords, scales — mirroring the level progression in Ear Trainer.
- Light-touch integration with Ear Trainer (Pattern B from the
  planning conversation): potentially a "see this interval on the
  staff →" cross-link when a user gets an Ear Trainer interval right
  or wrong, that opens Music Reading with the same interval pre-loaded.
  Deferred until both apps have a few releases under their belts.
- Mobile-friendly layout review (the app is usable on tablets and
  phones but hasn't been deliberately optimized for those sizes).
- Save settings (clef, key, mode, activity) to localStorage so they
  persist across sessions.

---

## [0.1.0] — 2026-05-17

First public release. Establishes the app's core shape and ships it
to GitHub Pages as a sibling to the existing Ear Trainer.

### Added — core app

- **Music notation display** via VexFlow, rendered as SVG. Treble and
  bass clefs, with proper key signatures and accidentals.
- **Twelve intervals** from minor 2nd through octave, both ascending
  and descending.
- **Three keys:** C major (no accidentals), G major (one sharp:
  F♯), and E minor (relative minor of G major, same key signature).
- **Two activity modes:**
  - *Learn* — exercises are shown with the answer visible. The user
    explores the patterns without time pressure.
  - *Quiz* — the second note is hidden; the user identifies it by
    clicking the correct chromatic note name. Three attempts before
    the answer is revealed.
- **Three-beat exercise structure.** Each exercise plays in 3/4 time:
  beat 1 is the root note alone (melodic), beat 2 is the second note
  alone (melodic), beat 3 is the two notes sounded together (harmonic).
  This mirrors how a musician would practice an interval at an
  instrument.
- **Mode A vs. Mode B toggle for descending perfect intervals.** Two
  legitimate conceptual models for descending P4, P5, and octave —
  letter-name-matching (Mode A) and interval-distance (Mode B). Both
  are taught in real music education; the app lets the student choose
  which to practice.
- **Salamander Grand Piano sample playback** via Tone.js. Same audio
  stack as Ear Trainer, with the expanded 30-sample set (every minor
  third from A0 to C8) for low pitch-shift artifacts.

### Added — first-run pedagogy

- **Embedded User Manual** as a collapsible `<details>` block at the
  top of the page, covering all the music theory a learner needs to
  understand the exercises: clefs, note durations, time signatures,
  sharps and flats, key signatures, intervals, the Mode A / Mode B
  distinction, exercise structure, range, and attribution.
- **Mode A vs. Mode B reference panel** that stays open by default,
  showing a concrete example of how the two modes differ. Collapsible.

### Added — accessibility

- **Accessibility framing:** this app is a sight-reading trainer
  designed for sighted users; the staff is the curriculum, not
  decoration. Interactive controls are fully keyboard-navigable and
  screen-reader friendly, but the staff itself is not made audible
  via screen reader (doing so would defeat the quiz). Users who can't
  read notation visually are directed to the companion Ear Trainer
  app, which trains the same underlying skill through audio alone.
- Comprehensive `aria-label`, `aria-labelledby`, `aria-pressed`,
  `aria-live`, and `role` attributes throughout the UI.

### Added — auto-start audio

- Sample loading begins automatically on page load. The audio context
  is resumed on the first user interaction (click, keydown, or
  touchstart), as required by browser autoplay policies. The status
  banner shows "Loading piano samples…" then "Ready" and auto-hides.
  No explicit "Enable Audio" button — the app gets out of the user's
  way once they're ready to start.

### Added — attribution

- Visible attribution block lists Salamander Grand Piano (CC-BY 3.0),
  Tone.js (MIT), and VexFlow (MIT) — the third-party work this app
  builds on. CC-BY 3.0 requires this visibility for the piano samples;
  the MIT licenses don't strictly require it but it's good manners.
- Sister-app footer link to Ear Trainer makes the relationship
  between the two apps discoverable to first-time visitors.

### Files included in this release

- `index.html` — the entire app, including styles and scripts (single
  file by design, like Ear Trainer)
- `README.md` — repository home page on GitHub
- `CHANGELOG.md` — this file
- `release.sh` — release helper script (parallel to Ear Trainer's)

### What to test in v0.1.0

A checklist for testers to verify before declaring the release good.
Copy into a tracker and check off as each is verified.

**Basic interaction**
- [ ] Open the live site; "Loading piano samples…" banner appears,
  then "Ready" message, then banner disappears.
- [ ] Press Play on the first exercise; you hear the three-beat
  sequence (root, second note, harmonic) on a real piano sound.
- [ ] Click Next; a new exercise loads on the staff with title and
  prompt updated.
- [ ] Click Previous; you go back to the prior exercise.

**Clef switching**
- [ ] Toggle Bass Clef; the staff redraws in bass clef, the audio
  plays in a lower octave.
- [ ] Toggle back to Treble; staff redraws.

**Key switching**
- [ ] Switch to G major; key signature shows one sharp; exercises
  are now rooted on G.
- [ ] Switch to E minor; key signature still shows one sharp; tonic
  is now E. A "Major 3rd ascending" from E lands on G♯ (because
  the key sig is G major). A "Minor 3rd ascending" from E lands on
  G natural.
- [ ] Switch back to C major; no accidentals; tonic back to C.

**Mode A vs. Mode B (perfect intervals only)**
- [ ] Find a descending perfect-interval exercise (P4, P5, or octave).
- [ ] Toggle Mode A; second note descends to the same letter name.
- [ ] Toggle Mode B; second note descends by interval distance.
- [ ] Toggle for a *non*-perfect descending interval (m2, M3, etc.);
  the toggle has no effect — the exercise is the same in both modes.

**Quiz mode**
- [ ] Switch to Quiz activity; the second note shows as a question mark.
- [ ] Click the correct note name; button highlights green; audio
  plays the note you picked; status says "Correct."
- [ ] Click a wrong note name; button highlights red; you hear the
  note you picked; status says "Not quite — that was [name]. X
  attempts left."
- [ ] After 3 wrong attempts, the correct answer is revealed, the
  original exercise replays, and you cannot click any more buttons
  for this question.

**Accessibility**
- [ ] Tab through every control on the page; focus indicator is
  clearly visible on each.
- [ ] On screen reader, all controls announce sensible labels.
- [ ] The User Manual `<details>` expands and collapses with keyboard.
- [ ] The audio status banner announces its state changes
  (loading / ready) via `aria-live`.

**Manual / attribution**
- [ ] Open the User Manual; all sections render correctly.
- [ ] About Accessibility section is present, with link to Ear Trainer.
- [ ] Audio & Attribution lists Salamander, Tone.js, and VexFlow with
  working external links.
- [ ] Footer "Sister app: Ear Trainer →" link works.

**Sister app discoverability**
- [ ] Visit Ear Trainer's live site too; verify cross-link from this
  app reaches the right place. (Note: Ear Trainer doesn't yet have a
  reciprocal cross-link to Music Reading; that's a separate small
  edit to ship in Ear Trainer's next release.)

---

(No prior entries — this is the first release.)

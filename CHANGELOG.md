# Changelog

All notable changes to the Music Reading Trainer are documented in
this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- **v0.3.0** — Add D major and B minor (two sharps). Continue climbing
  the sharp side of the circle of fifths.
- **v0.4.0** — Open the flat side: F major and D minor (one flat).
- Additional levels beyond Level 1 (intervals): triads, seventh
  chords, scales — mirroring the level progression in Ear Trainer.
- Light-touch integration with Ear Trainer: a "see this interval on
  the staff →" cross-link when a user gets an Ear Trainer interval
  right or wrong. Deferred until both apps have a few releases.
- Mobile-friendly layout review.
- Save settings to localStorage so they persist across sessions.

---

## [0.2.1] — 2026-06-18

Patch release. Fixes the note-range ceiling, extends the usable range
upward at a music-teacher tester's suggestion, and improves the quiz
answer feedback box.

### Fixed

- **Bass-clef note range over-shoot.** The bass upper bound was set to
  semitone `64`, which is E5 — about five ledger lines above the bass
  staff — not the E4 the code comment intended. High-tonic keys could
  place notes absurdly high above the staff. Corrected as part of the
  range change below.

### Changed — note ranges

- **Upper range now reaches the space above the second ledger line**
  above the staff, in every key and both clefs (music-teacher tester
  request). Treble tops out at D6, bass at F4. Lower bounds are
  unchanged (treble A3, bass C2 — two ledger lines below the staff).
- In a few keys an interval near the new ceiling won't complete a full
  octave because the upper note would fall outside the range; that
  exercise is simply not generated. This is expected and accepted.
- All 14 keys verified to retain at least two valid starting octaves
  and to reach the new top note.

### Changed — quiz answer feedback

- **"Correct!" box now names the interval and direction** after the
  note, to reinforce interval recognition alongside note reading —
  e.g. "Correct! The second note is G — Perfect 5th, ascending." The
  reveal message (shown after three misses) was updated to match.
- **Box moved directly beneath the staff** (previously sat under the
  note-choice grid in the right column) and **enlarged** slightly
  (font 0.86rem → 1rem, more padding).
- **Reserved space, no layout shift.** In quiz mode the box always
  occupies its vertical space — empty and invisible before an answer,
  filled and colored after — so the Play buttons below it never jump
  when feedback appears. In learn mode the box is hidden entirely (no
  empty gap).

### Files in this release

- `index.html` — full app (single file)
- `CHANGELOG.md` — this file

### What to test in v0.2.1

**Note ranges**
- [ ] In each clef and several keys, the highest notes reach the space
  just above the second ledger line above the staff (treble ~D6,
  bass ~F4) and go no higher.
- [ ] No notes appear three or more ledger lines above the staff.
- [ ] Lowest notes still reach about two ledger lines below the staff.

**Quiz feedback box**
- [ ] Box appears directly under the staff, not under the note grid.
- [ ] Correct answer reads "… is X — [interval], [ascending/
  descending]." with the right interval and direction.
- [ ] After three misses, the reveal message also shows interval and
  direction.
- [ ] Before answering (quiz mode), the empty box reserves space and
  the Play buttons do not move when an answer is submitted.
- [ ] In learn mode there is no empty gap under the staff.
- [ ] Screen reader still announces the status (aria-live) in its new
  location.

---

## [0.2.0] — 2026-06-03

Major feature release. Expands the key library to the full circle of
fifths, replaces the hardcoded exercise list with a dynamic generator,
adds a Note Reference panel for beginners, and introduces interval and
direction filters for both Learn and Quiz modes. Visual style aligned
with the Ear Trainer dark studio aesthetic.

### Added — visual style

- **Dark studio aesthetic** matching the Ear Trainer: near-black
  `#14110f` background, brass `#d4a24c` accent, Fraunces serif for
  display text, JetBrains Mono for labels and data.
- **White-background staff panels** — VexFlow renders black-on-white
  naturally; a `patchSvgBackground()` helper injects a white rect as
  the SVG's first child so ledger lines and note stems render correctly
  without any CSS color overrides that would interfere with VexFlow's
  internal rendering.
- `overflow: visible` on all staff SVGs so notes on ledger lines above
  or below the staff are never clipped.

### Added — key signatures

- **Circle of fifths key grid** — all 14 keys now available, arranged
  in circle of fifths order left to right: C, G, D, A, E (sharps side)
  then F, B♭ (flats side). Each major key is paired with its relative
  minor directly below it — they share a key signature.
- Keys available: C major / A minor, G major / E minor, D major /
  B minor, A major / F♯ minor, E major / C♯ minor, F major / D minor,
  B♭ major / G minor.

### Added — clef

- **Both clef** — shows the grand staff (treble on top, bass below),
  the view pianists read from. Audio plays the treble-clef octave; a
  note below the staff explains that the bass staff shows the same
  interval one octave lower.

### Added — Note Reference panel

- Collapsible **Note Reference** panel below the controls shows every
  natural note on both treble and bass staves with letter-name labels.
  Ledger-line notes are labeled in gold to call them out. Intended as
  a visual guide for absolute beginners learning to orient on the staff.

### Added — exercise controls

- **Interval filter** — new Row 3 in controls. Buttons: All · m2 ·
  M2 · m3 · M3 · P4 · TT · P5 · m6 · M6 · m7 · M7 · P8. Selecting
  a specific interval locks both Learn and Quiz to that interval.
- **Direction toggle** — Ascending / Descending / Both. Defaults to
  Ascending. Wired into both exercise generators; selecting Descending
  means all exercises will descend.

### Changed — exercise generation

- Learn mode now uses the same dynamic generator as Quiz mode
  (`generateLearnExercise()`), replacing a hardcoded exercise array.
  Changing any control (key, clef, interval, direction, mode) now
  immediately generates a correctly matching exercise rather than
  cycling through a fixed list.
- Expanded note ranges: treble A3–C6 (A below middle C up to two
  ledger lines above the staff); bass C2–E4 (two ledger lines below
  through E above middle C).

### Changed — descending perfect intervals

- **Renamed "Mode A / Mode B"** to **"Root Relative" / "Exact
  Distance"** throughout the app. The old names were opaque; the new
  names communicate the concept directly.
  - **Root Relative** — the descending note is the same letter name as
    ascending. C down a P5 = G. The interval inverts but stays in key.
    Good for sight-singing and beginners.
  - **Exact Distance** — count down the exact semitones. C down a P5
    (7 semitones) = F. Used for Circle of Fifths and chord-progression
    thinking.
- Control label changed to "Descending Perfect Intervals (see below)"
  with a plain-language explanation strip below the toggle.
- Quick Reference panel below the exercise card updated to match new
  language; "Mode A vs. Mode B" heading removed.
- User Manual section rewritten with proper theory explanation of
  interval inversion (Root Relative) and semitone distance (Exact
  Distance).

### Fixed

- Reveal Notes panel was reading interval name from the old hardcoded
  `exercises[]` array (`exercises[currentIndex]`) rather than the live
  `currentLearnEx` object. Now correctly shows the interval name of
  the exercise actually on screen.
- Mode label in reveal panel updated from "Mode A / Mode B" to "Root
  Relative / Exact Distance".

### Files in this release

- `index.html` — full app (single file)
- `README.md` — updated for v0.2.0
- `CHANGELOG.md` — this file
- `release.sh` — unchanged

### What to test in v0.2.0

**Style and rendering**
- [ ] Dark background, brass accent color, Fraunces/JetBrains Mono
  fonts load correctly.
- [ ] Staff renders black-on-white. Notes, stems, ledger lines, clef
  symbol, and key signature accidentals are all clearly visible.
- [ ] Notes on ledger lines above and below the staff are fully visible
  and not clipped (e.g. C4 below treble, high C6 above treble).

**Key grid**
- [ ] All 14 key buttons present and labeled correctly.
- [ ] Switching to G major shows one sharp on the staff; root note is G.
- [ ] Switching to E minor shows the same one sharp; root is E.
- [ ] Switching to B♭ major shows two flats; root is B♭.
- [ ] Only one key button is active (gold) at a time.

**Clef — Both**
- [ ] Select Both; grand staff renders with treble on top, bass below.
- [ ] Explanation note appears below the staff explaining audio plays
  treble-clef octave.
- [ ] Switching back to Treble or Bass removes the explanation note.

**Note Reference panel**
- [ ] Panel is present and collapsible.
- [ ] Treble staff shows notes C4 through A5 with letter names.
- [ ] Bass staff shows notes E2 through C4 with letter names.
- [ ] Ledger-line note labels appear in gold.

**Interval filter**
- [ ] All · m2 · M2 … P8 buttons all present.
- [ ] Selecting P5 in Learn mode generates only Perfect 5th exercises.
- [ ] Selecting P5 in Quiz mode generates only Perfect 5th questions.
- [ ] Returning to All restores full random pool.

**Direction toggle**
- [ ] Ascending-only: all exercises go up.
- [ ] Descending-only: all exercises go down.
- [ ] Both: mix of ascending and descending appears over several
  exercises.
- [ ] Direction toggle interacts correctly with interval filter
  (e.g. P5 + Descending = descending P5 exercises only).

**Root Relative / Exact Distance**
- [ ] Toggle is labeled "Root Relative" and "Exact Distance" — no
  "Mode A" or "Mode B" anywhere in the UI.
- [ ] With Descending + P5 from C selected:
  - Root Relative: second note is G below.
  - Exact Distance: second note is F below.
- [ ] Toggle has no effect on non-perfect descending intervals.
- [ ] Quick Reference panel below exercise uses new language.

**Reveal Notes (Learn mode)**
- [ ] Reveal shows the correct interval name matching what is on screen
  (not a name from a different exercise).
- [ ] Descending perfect interval reveals show "(Root Relative)" or
  "(Exact Distance)" correctly.

**Quiz mode**
- [ ] Quiz still functions: correct answer highlights green, wrong
  highlights red, three attempts then reveal.
- [ ] Interval filter and direction filter both affect quiz questions.

**Accessibility**
- [ ] Tab through all controls; focus ring visible on each.
- [ ] Direction toggle and interval filter buttons all have correct
  `aria-pressed` states.
- [ ] Screen reader announces control labels correctly.

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
- **Root Relative / Exact Distance toggle for descending perfect
  intervals.** Two legitimate conceptual models for descending P4, P5,
  and octave. Both are taught in real music education; the app lets
  the student choose which to practice. (Originally shipped as
  "Mode A / Mode B"; renamed in v0.2.0.)
- **Salamander Grand Piano sample playback** via Tone.js. Same audio
  stack as Ear Trainer, with the expanded 30-sample set (every minor
  third from A0 to C8) for low pitch-shift artifacts.

### Added — first-run pedagogy

- **Embedded User Manual** as a collapsible `<details>` block at the
  top of the page.
- **Descending interval reference panel** that stays open by default,
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
  touchstart), as required by browser autoplay policies.

### Added — attribution

- Visible attribution block lists Salamander Grand Piano (CC-BY 3.0),
  Tone.js (MIT), and VexFlow (MIT).
- Sister-app footer link to Ear Trainer.

---

(End of changelog.)

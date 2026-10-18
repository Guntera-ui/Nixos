# German Learning Hub — TUI v1.0

A keyboard-first German study tool for NixOS + Hyprland, run in Kitty through the existing `Super+G` / `german-lookup` shortcut.

**Status:** Functional local backend with unit tests; Textual UI and NixOS build require verification on your NixOS machine. No live Wiktionary calls were made during packaging.

## Architecture

```text
Hyprland Super+G
    └── german-lookup  (Home Manager package / Kitty)
          └── Textual TUI (Python)
                ├── dictionary.py → German Wiktionary MediaWiki API
                │                  → cached canonical entries
                ├── storage.py    → SQLite (XDG_DATA_HOME)
                │                  → lexemes, cache, review history
                ├── practice.py   → graded recall questions + SM-2-style intervals
                └── exports.py    → Markdown templates / exports

User data: ~/.local/share/deutsch-hub/library.sqlite3
Markdown:  ~/Documents/German/{Nouns,Verbs,Adjectives,...}
Source:    /etc/nixos/config/german-tui (read-only after Nix build)
```

No background process or scheduled tasks. Network is used only when looking up a word absent from the 14-day cache. German entries come from the German Wiktionary MediaWiki API; available English glosses are requested from the English Wiktionary definition API (optional, best effort). Definitions and morphology are extracted conservatively: no automatic translations, conjugations, or paradigms are invented.

## Installation on Gunter4070

1. Back up the existing launcher:

   ```bash
   sudo cp /etc/nixos/modules/german-tools.nix /etc/nixos/modules/german-tools-v2.nix.bak
   ```

2. Copy the downloaded archive to `~/Downloads/` if it isn't there already, then unpack:

   ```bash
   sudo tar -xzf ~/Downloads/German-Learning-Hub-TUI-v1.tar.gz -C /etc/nixos
   ```

   This archive contains relative `modules/` and `config/` paths (no strip-components). It replaces **only** `modules/german-tools.nix` and adds `config/german-tui/`. It does not touch `home.nix`, `configuration.nix`, the Hyprland Lua file, GPU settings, or your existing study notes.

3. Your existing Home Manager `imports` must already contain:

   ```nix
   ./modules/german-tools.nix
   ```

   **Do not add the import twice.** The command name `german-lookup` is unchanged.

4. Test the Nix evaluation, then activate:

   ```bash
   sudo nixos-rebuild build --flake /etc/nixos#Gunter_nix
   sudo nixos-rebuild switch --no-reexec --flake /etc/nixos#Gunter_nix
   ```

5. Press **Super+G** to open a Kitty TUI. If testing from an existing terminal, run `german-lookup` with no arguments.

### Example workflow — a German noun

1. Press **Super+G**. The **Dictionary** tab opens.
2. Search for `Haus`, press **Enter**. Available German definitions, source-backed forms, and examples appear. A failed network lookup leaves a clear error; lookup doesn't invent data.
3. In the `Your English translation` field, enter `house`. Optionally add a short sentence/usage note.
4. Press **Ctrl+S** (or Save to library) to store the entry in SQLite. The entry is now available offline.
5. Press **Ctrl+E** to create a new Markdown note in `~/Documents/German/Nouns/haus.md`. A subsequent export creates `haus-2.md` rather than overwrite an edited note.
6. Press **Ctrl+2**, highlight `Haus`, press **Enter** to inspect your saved entry.
7. Press **Ctrl+3**, choose **Start / next**. If the source supplied its grammatical gender, you'll be asked for the article. Type `das` and Enter. The next due date is recorded.
8. Repeat on a later day. The practice engine selects one available question per due word. It never claims a form was learned when the source lacked it.

### Example workflow — a verb

1. Look up `laufen`.
2. Inspect sourced Präsens, Präteritum, Hilfsverb and Partizip II where Wiktionary provides them.
3. Add your translation (`to run`) and a usage note, save it.
4. Export Markdown. The note includes morphology, sourced examples, grammar patterns to fill in, original sentences, and corrections.
5. Practice questions use verified inflection fields (`gelaufen`, `sein`), depending on availability.

### Example workflow — a grammar topic

1. **Super+G**, then **Ctrl+4** for Notes.
2. Enter `Wechselpräpositionen`.
3. Select **New grammar note**. The program creates a new `.md` document and opens a separate Kitty + Neovim window.
4. Fill in pattern, contexts, contrasts, original examples and review checklist.
5. Your Markdown files stay writable in `~/Documents/German/Grammar/`.

### Key bindings

| Key | Action |
|---|---|
| Ctrl+1 | Dictionary tab |
| Ctrl+2 | Library tab |
| Ctrl+3 | Practice tab |
| Ctrl+4 | Notes tab |
| Ctrl+L | Focus dictionary lookup |
| Ctrl+S | Save current lookup or selected word |
| Ctrl+E | Export current word to Markdown |
| Ctrl+R | Open practice + refresh due words |
| Ctrl+Q | Quit TUI (and its Kitty window when launched via Super+G) |
| Tab / Shift+Tab | Move between input fields and controls |
| Arrow keys / Enter | Navigate and select a word in the Library |

### CLI subcommands

```bash
# Return sourced definitions and extracted morphology
# (may require an internet connection)
german-lookup lookup laufen

# Machine-readable JSON
german-lookup lookup Haus --json

# Save a manual entry while offline
german-lookup add Hund --gloss dog --part Substantiv --gender m

# Check practice counters
german-lookup stats

# Generate Markdown from saved entries
german-lookup export Haus
german-lookup export --all

# Generate Markdown without opening the TUI
german-lookup note grammar "Konjunktiv II"
german-lookup note practice "Reading exercises"
```

## Technical details

- `dictionary.py`: German Wiktionary MediaWiki `action=parse`, `prop=wikitext`, plus optional English Wiktionary definition API, extracts the first German section's inflection-overview template, definitions and examples. Multiple senses, inflected spellings, templates, and Wiktionary changes can limit extraction: verify important forms using the source.
- `storage.py`: SQLite tables `lexemes`, `lookup_cache` (TTL 14 days), `reviews`. WAL enabled. Grade >=3 schedules forward, below 3 repeats after one day; simple SM-2-derived formula. This is a study tool, not an empirically validated learning intervention.
- `practice.py`: exercises generated solely from saved source forms or learner-supplied translations. Correct grades as 5; incorrect as 2. Accent and spelling differences matter; case and whitespace are normalized.
- `exports.py`: Markdown templates are installed with Nix. Notes are created using exclusive write, so edited files are never overwritten.
- `ui.py`: Textual with CSS palette #0f1018 / #161823 / #202337 / #f4f1ff / #f29ac3 / #c6a0f6 / #8aadf4 / #7dcfe3.

## Test / troubleshoot

To run parser/storage/Markdown unit tests with standard Python:

```bash
cd /etc/nixos
python3 -m unittest discover -s config/german-tui/tests -v
```

These tests do not need Textual or network access. A project-only copy works too:

```bash
python3 /etc/nixos/config/german-tui/main.py stats
```

If the app doesn't open, test `german-lookup` inside Kitty first, and inspect the first traceback. Textual must be available through the `pkgs.python3.withPackages` derivation in the Home Manager module.

### Backups and migration

- Existing **v2 Markdown notes** in `~/Documents/German/` are not modified or automatically imported into the SQLite vocabulary library. Open them from the Notes folder or export new vocabulary notes from TUI.
- For database backup, close all instances of the TUI first (SQLite WAL may have pending files), then copy `~/.local/share/deutsch-hub/library.sqlite3` to a safe location.
- Restore the v2 launcher by replacing `modules/german-tools.nix` with the `.bak` copy and rebuilding.
- No CLI updater or background service is installed.

## Testing status

Backend Python syntax and 7 automated unit tests passed on the packaging environment. The Textual dependency and Nix build were not available for a full runtime UI test; verify the flake build and Super+G behavior on the laptop.

German Wiktionary content belongs to its contributors and is subject to the terms/licensing displayed at the source entry. Exported vocabulary notes include attribution links.

# Brush & Base

Paint-night notes and finished mini photos from the hobby desk.

**Live site:** [tyberium.github.io/brush-and-base](https://tyberium.github.io/brush-and-base/)

## What goes on the site

| Publish | Keep offline |
|---------|--------------|
| Finished model photos in `assets/photos/` | Handwritten diary page scans |
| Progress snapshots in entry front matter | Raw diary JPGs |
| Transcribed recipes in `entries/` | |

## Repo layout

| Path | Purpose |
|------|---------|
| `index.md` | Homepage (data-driven catalogue) |
| `entries/` | One markdown file per model or session |
| `systems/` | Game-system landing pages (top nav) |
| `factions/` | Faction / project landing pages |
| `_data/systems.yml` | System lexicon (top masthead) |
| `_data/factions.yml` | Faction lexicon (name, banner, parent system) |
| `_data/navigation.yml` | Top masthead links (systems) |
| `assets/photos/` | Model photos (progress and finished) |
| `assets/banners/` | Faction header images |

## How browsing is organised

```
System (top nav)  ->  Faction  ->  Model entry
Warhammer 40,000  ->  Thousand Sons  ->  Magnus
```

- Top masthead lists **game systems only** (Minimal Mistakes has no dropdowns)
- Sidebar and homepage nest **System -> Faction -> Models**
- Every entry sets `faction:` to a key in `_data/factions.yml`
- Every faction sets `system:` to a key in `_data/systems.yml`

## Photo naming

`{entry_slug}_{DDMMYYYY}.jpg` - e.g. `ahriman_11062026.jpg`

Multiple shots from one session: append `_01`, `_02`, etc.

Keep names snake_case. No spaces, ampersands, or typos in the slug.

## Paint night workflow

1. Photo the minis (for the site) and diary page (keep offline)
2. Add or update a file in `entries/` with `faction:` matching `_data/factions.yml`
3. Drop model photos in `assets/photos/`
4. Set `finished:` to the finished photo path when you have one
5. New faction: add it to `_data/factions.yml` under the right `system:`, create `factions/{slug}.md`
6. New system: add it to `_data/systems.yml`, create `systems/{slug}.md`, and add it to `_data/navigation.yml` if it belongs in the top bar
7. Run `scripts/check_photo_refs.ps1`
8. Commit and push - site rebuilds automatically

### Progress steps (entry front matter)

```yaml
faction: thousand_sons
finished: /assets/photos/rubric_marine_28022025.jpg
progress:
  - photo: /assets/photos/rubric_marine_12022022.jpg
    note: Based all armour panels Vallejo red
  - photo: /assets/photos/rubric_marine_28022025.jpg
    note: Dot highlight with Stormhost Silver
```

`finished:` is the large image at the bottom of the entry page. If omitted, the last progress photo is used.

## Checks

```powershell
.\scripts\check_photo_refs.ps1
```

Fails if any markdown/YAML/HTML asset path does not exist on disk.

Manual image install instructions

If the automatic download (`scripts/fetch-bg-images.ps1`) fails (e.g., network/CORS/server errors), please download the images manually and place them in `assets/bg/` with the exact filenames below:

Required filenames:
- `assets/bg/m51.jpg` — Whirlpool Galaxy (M51)
- `assets/bg/pillars.jpg` — Pillars of Creation
- `assets/bg/crab.jpg` — Crab Nebula (M1)
- `assets/bg/kepler.jpg` — Kepler Supernova Remnant
- `assets/bg/eht.jpg` — EHT Black Hole (M87)

Suggested sources (public domain / NASA / Hubble / EHT):
- Hubble images: search on https://commons.wikimedia.org (many Hubble images are public domain). Use the "Download" or "Original file" link and save as the filename above.
- Event Horizon Telescope (M87) image: Wikimedia Commons or EHT press resources (check the image licensing/citation).

After placing the files:
1. Start a local server from the repo root (to avoid file:// texture restrictions):
   - Python: `python -m http.server 8000`
   - or use VS Code Live Server
2. Open `http://localhost:8000/index.html` and select a background from the dropdown — the site will use local images and the WebGL shader will load textures without CORS issues.

If you want, attach the images here or give me temporary access to a ZIP and I can add them to the repo for you.

Notes:
- These images are large; you may prefer to download smaller (1200px) versions to save space/bandwidth.
- If you want, I can also add a lightweight sample image (small, compressed) to keep the visual working until you add high-res files.

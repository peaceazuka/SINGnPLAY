# singnplay.app website

Static site for SINGnPLAY, the home for all SINGnPLAY apps. WorshipTime is the first.

- `index.html`: the hub (apps grid and build progress)
- `worshiptime/index.html`: the WorshipTime app page
- `assets/styles.css`: shared styles (colors match the Flutter theme)

## Adding an app
Copy the WorshipTime `<article class="app-card">` in `index.html`, change its details, and add a page at `/<app-slug>/index.html`.

## Deploying
No build step. Point any static host at this folder, for example Cloudflare Pages with build command empty and output directory `website`.

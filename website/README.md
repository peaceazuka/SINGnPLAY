# SINGnPLAY marketing website

Static marketing site for the SINGnPLAY WorshipTime app, built with
[Astro](https://astro.build) + [Tailwind CSS v4](https://tailwindcss.com).
It's a separate, standalone project from the Flutter app in the repo root —
it only borrows the app's brand colors and fonts for a consistent look.

## Editing content yourself

Almost all the text on the site (headings, taglines, prices, FAQ, store
links, testimonials) lives in one file:

```
src/data/site.ts
```

Open it, change the strings, save — no other file needs to change. Anything
written as `"PLACEHOLDER: ..."` is a stand-in that should be replaced with
real content before launch (testimonials, pricing, App Store / Play Store
URLs).

For layout/design changes, each section of the page is its own file under
`src/components/` (e.g. `Hero.astro`, `Pricing.astro`, `Faq.astro`), assembled
in `src/pages/index.astro`. Colors and fonts are defined once in
`src/styles/global.css` under the `@theme` block, matching
`lib/flutter_flow/flutter_flow_theme.dart` in the app.

## Local development

```bash
npm install
npm run dev
```

Open the printed `localhost` URL. Changes to any file hot-reload in the
browser immediately.

## Build

```bash
npm run build
npm run preview   # serve the production build locally to double check
```

Output goes to `dist/`.

## Deploying to Cloudflare Pages (automatic, via GitHub Actions)

Deploys run in `.github/workflows/deploy-website.yml` — every push that
touches `website/**` builds the site and pushes it to Cloudflare Pages
with `wrangler`. One-time setup:

1. In Cloudflare, create a scoped API token: **dashboard → My Profile →
   API Tokens → Create Token**, custom permissions only:
   - `Account → Cloudflare Pages → Edit`
   - `Zone → DNS → Edit`, scoped to just the `singnplay.app` zone
   Give it a short expiration date.
2. Find your **Account ID** (Cloudflare dashboard → Workers & Pages →
   right sidebar on the overview page).
3. In the GitHub repo: **Settings → Secrets and variables → Actions →
   New repository secret**, add:
   - `CLOUDFLARE_API_TOKEN`
   - `CLOUDFLARE_ACCOUNT_ID`
4. Push to the branch (or run the workflow manually from the **Actions**
   tab) — this creates the `singnplay` Pages project on first run and
   deploys `website/dist`.
5. In Cloudflare, open the new `singnplay` Pages project → **Custom
   domains** → **Add domain** → `singnplay.app`. Since the domain is
   already in the same Cloudflare account, DNS and SSL are configured
   automatically — this one step still has to be done once by hand in
   the dashboard.

No environment variables or server are needed at runtime; this is a
fully static site. The workflow currently triggers on pushes to
`claude/upbeat-pascal-0sdcxw` — update the `branches:` list once this
work lands on your repo's permanent branch.

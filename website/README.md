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

## Deploying to Cloudflare Pages

1. Push this repo to GitHub (already done if you're reading this from the repo).
2. In the [Cloudflare dashboard](https://dash.cloudflare.com) → **Workers & Pages** → **Create** → **Pages** → **Connect to Git**, pick this repository.
3. Set the build configuration:
   - **Root directory**: `website`
   - **Build command**: `npm run build`
   - **Build output directory**: `dist`
4. Deploy. Every push to your main branch redeploys automatically; every
   pull request gets its own preview URL.
5. Add a custom domain under the Pages project's **Custom domains** tab —
   type `singnplay.app`. Since the domain is registered in the same
   Cloudflare account, DNS is wired up and the SSL certificate is issued
   automatically, no manual records needed.

No environment variables or server are needed; this is a fully static site.

# AGENTS.md — Portfolio / Solo Agency (Astro + Tailwind)

## Mission
Build a premium, conversion-focused **one-page** website for a **solo** creator (Nikolas Maerker).
The site should feel like a modern student-led agency, but copy must reflect **one person** (“I”, not “we”).

## Stack (hard constraints)
- Astro (static only): `output: "static"`
- Tailwind CSS via Vite (`@tailwindcss/vite`)
- No React, no SSR, no server routes, no runtime DB
- No new dependencies unless explicitly approved

## Source of truth (content)
- All content must come from: `content/site.json`
- Do not hardcode personal info inside components (names, links, bios, service copy, etc.)
- Components should be data-driven from `site.json`

## File structure
- Page entry: `src/pages/index.astro`
- Sections: `src/components/sections/*`
  - Hero, Services, Work, Process, Media, About, Contact
- Styles: `src/styles/global.css`
- Public assets:
  - Portrait: `public/hero/Nikolas_Maerker_Seite_no_bg.webp`
  - Work images: `public/work/*`
  - Social thumbnails: `public/social/*`
  - OG image: `public/og.png` (or jpg)
  - Favicon: `public/favicon.*`

## Design goals
- “Premium minimal” look (Stitch/Madison-inspired): strong typography, warm light background, subtle borders, soft shadows
- Consistent design tokens:
  - Container: `max-w-5xl` (or `max-w-6xl` if needed)
  - Section spacing: `py-20` (desktop), `py-16` (mobile)
  - Radius: cards `rounded-2xl`, buttons `rounded-xl`, pills `rounded-full`
  - Borders: `border border-zinc-200/70`
  - Shadows: `shadow-sm` / `shadow-md` (sparingly)
  - Focus: visible `focus:ring-2 focus:ring-zinc-400 focus:ring-offset-2`
- Minimal JS (prefer none). Use semantic HTML and accessible interactions.

## Page structure (order + anchors)
One-page layout with section ids:
1) Hero — `#top`
2) Services — `#services`
3) Work / Case studies — `#work`
4) Process — `#process`
5) Media (YouTube + Instagram preview) — `#media`
6) About — `#about`
7) Contact — `#contact`

Sticky top nav with anchor links:
- Services, Work, Process, About, Contact
- Right-side primary button: “Contact” or “Let’s talk”

## Content requirements (site.json schema expectations)
`site.json` should include (as available):
- `name`, `role`, `location`, `tagline`
- `siteUrl`, `ogImage`, optional `twitterHandle`
- `links`: `email` (mailto), `github`, `linkedin`, optional `instagram`
- `hero`:
  - `badgeText`, `headline`, `subheadline`
  - `portraitSrc` (must point to `/hero/Nikolas_Maerker_Seite_no_bg.webp`)
  - `primaryCta` { `label`, `href` } (e.g. “Let’s talk” -> `#contact`)
  - `secondaryCta` { `label`, `href` } (e.g. “View work” -> `#work`)
- `services[]` (3 pillars):
  1) Web Design & Development
  2) Photo & Video
  3) Drone / Aerial
  Each service: `title`, `description`, `bullets[]`
- `work[]` (case studies):
  Each: `title`, `description`, `href`, `image`, `tags[]`, optional `resultsBullets[]`
- `process`:
  - `heading`, `steps[]` (4 steps)
- `media`:
  - `youtubeUrl` or `youtubeEmbedUrl`
  - `instagramProfileUrl`
  - `instagramThumbnails[]` (local images linking out)
  - IMPORTANT: Do not implement Instagram API feed by default
- `about`:
  - `paragraph`, `bullets[]` (3 bullets)
- `contact`:
  - `emailCtaText` (optional), `bookingUrl` (optional)

## Media integration rules
- YouTube: responsive `<iframe>` with `loading="lazy"`
- Instagram: GDPR-friendly default:
  - show profile link + local thumbnails linking out
  - do NOT add Instagram API integration unless explicitly approved

## Safety / change control
- Prefer small incremental changes
- When asked to modify code:
  - Touch only the necessary files
  - Do not reformat large files unnecessarily
  - Do not reorder `site.json` keys unless requested
- Never add dependencies without asking first

## Output expectations for agent work
When making changes:
- List files to be modified first
- After modifications, output either:
  - unified diffs, OR
  - full file contents for each changed file (if requested)
- Provide test commands:
  - `pnpm dev`
  - `pnpm build`
  - `pnpm preview`

## Common pitfalls to avoid
- Don’t paste code into terminal; write to files
- Don’t use Tailwind CDN scripts
- Don’t generate or replace the portrait; always use the provided file
- Don’t introduce “we” language; keep it solo operator voice
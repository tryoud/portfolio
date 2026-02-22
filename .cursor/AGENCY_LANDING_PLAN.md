# Agency landing page — Phase 1 plan

## 1) Repo audit

**Pages**
- `src/pages/index.astro` — single one-pager; imports global.css, site.json, four sections; has sticky nav (Work, About, Contact) and SEO head (canonical, OG, Twitter).

**Sections**
- `src/components/sections/Hero.astro` — name, location, badge “Available for projects”, role, tagline, CTAs (#projects, #contact), GitHub/LinkedIn.
- `src/components/sections/Projects.astro` — `id="projects"`; grid of project cards (title, description, optional impact bullets, stack badges, View link).
- `src/components/sections/About.astro` — `id="about"`; reads `site.about` (paragraph + bullets).
- `src/components/sections/Contact.astro` — `id="contact"`; email CTA, GitHub/LinkedIn, optional bookingUrl.

**Content**
- `content/site.json` — name, role, location, tagline, siteUrl, ogImage, twitterHandle, bookingUrl, about { paragraph, bullets }, links { email, github, linkedin }, projects[] (title, description, impact[], stack, href).

---

## 2) Structure extracted from Framer (content baseline)

**Hero**
- Greeting: “Hello, I'm Nikolas”
- Role: “Web Developer - Photographer & Videographer” (or split line)
- CTA: “Let's Talk”

**Services**
- **Web Development**  
  Copy (strip verification): “My skill set focuses on designing and developing the entire user journey from start to finish, including SEO, database restructuring, and data analysis.”  
  CTAs: Let's Talk, Learn More.
- **Photography & Videography**  
  Copy: “From event photography and drone shots to professional video editing and creating aftermovies.”  
  CTAs: Let's Talk, Learn More.

**Contact**
- “Get in touch” — no separate categories on the fetched page; we can add contact categories (Web Dev / Photography / Videography) as per your spec.

**To remove**
- Any “Impact-Site-Verification: …” text from copy and from final site.

---

## 3) Proposed one-pager IA

| Order | Section   | Id / Nav        | Purpose |
|-------|-----------|-----------------|---------|
| 1     | Hero      | (top)           | Hello + role + primary CTA (e.g. Let's talk → #contact) |
| 2     | Services  | `#services`     | Two service blocks: Web Development, Photography & Videography (title, description, CTA) |
| 3     | Work      | `#work`         | Case studies / projects (current Projects section; rename for “work”) |
| 4     | Process   | `#process`       | How we work (short steps or bullets) |
| 5     | About     | `#about`        | Student-led team angle (from site.about) |
| 6     | Contact   | `#contact`      | Get in touch + contact categories (Web Dev / Photography / Videography) |

**Nav**
- Update nav links to: Services, Work, Process, About, Contact (anchors: #services, #work, #process, #about, #contact).
- Hero primary CTA can be “Let's talk” → #contact; secondary “View work” → #work.

---

## 4) content/site.json — fields to add/change

**Add**
- **hero**
  - `greeting` (string): e.g. “Hello, I'm Nikolas”
  - Keep using `name`, `role`, `tagline` for rest of hero; optional `ctaPrimary`, `ctaSecondary` if you want labels from data.
- **services** (array of objects, each):
  - `id` (string): e.g. `web-development`, `photography-videography` (for optional deep-links)
  - `title` (string): e.g. “Web Development”, “Photography & Videography”
  - `description` (string): clean copy (no Impact-Site-Verification)
  - `ctaLabel` (string, optional): e.g. “Let's talk” or “Learn more”
- **process**
  - `heading` (string): e.g. “How we work”
  - `steps` (array of strings): 3–4 short steps
- **contact**
  - `headline` (string): e.g. “Get in touch”
  - `categories` (array of objects): `{ "label": "Web Development", "description": "…" }` or just labels; optional `mailto` or `href` per category if you want separate contact points later.

**Change**
- **role** — align with Framer: e.g. “Web Developer · Photographer & Videographer” (or keep current and add `hero.roleOverride`).
- **about** — keep `paragraph` and `bullets`; ensure copy reflects “student-led agency” (you edit the strings).
- **projects** — can rename to `work` in JSON for clarity, or keep `projects` and only change section title to “Work” in UI. Optional: add `category` (“web” | “photography” | “videography”) per item for filtering later.

**Remove / avoid**
- No Impact-Site-Verification or similar strings in any description/copy.

**Example shape (additions only)**

```json
{
  "hero": {
    "greeting": "Hello, I'm Nikolas"
  },
  "services": [
    {
      "id": "web-development",
      "title": "Web Development",
      "description": "My skill set focuses on designing and developing the entire user journey from start to finish, including SEO, database restructuring, and data analysis."
    },
    {
      "id": "photography-videography",
      "title": "Photography & Videography",
      "description": "From event photography and drone shots to professional video editing and creating aftermovies."
    }
  ],
  "process": {
    "heading": "How we work",
    "steps": ["Discovery & brief", "Proposal & timeline", "Build & review", "Launch & support"]
  },
  "contact": {
    "headline": "Get in touch",
    "categories": [
      { "label": "Web Development" },
      { "label": "Photography" },
      { "label": "Videography" }
    ]
  }
}
```

Existing fields (siteUrl, ogImage, twitterHandle, about, links, projects) stay; nav will use section ids.

---

## 5) Files to modify or create

**Modify**
- `content/site.json` — add hero.greeting, services[], process{}, contact{ headline, categories }; set role/tagline/about copy to agency + student-led; remove any verification text.
- `src/pages/index.astro` — import and render Services, Process; rename “Projects” usage to “Work” in order; add section ids: #services, #work, #process, #about, #contact; update nav links; keep SEO head (canonical, OG, Twitter from site.json).
- `src/components/sections/Hero.astro` — use `site.hero.greeting` (or site.name fallback), keep role/tagline, primary CTA “Let's talk” → #contact, secondary “View work” → #work; keep social links; no hardcoded personal info.
- `src/components/sections/Projects.astro` — rename section title to “Work”, keep `id="projects"` or change to `id="work"` (and update nav); no copy changes beyond title.
- `src/components/sections/About.astro` — keep id="about", read from site.about; ensure no verification text.
- `src/components/sections/Contact.astro` — use site.contact.headline and site.contact.categories; email CTA + social links; optional bookingUrl; contact categories (Web Dev / Photography / Videography).

**Create**
- `src/components/sections/Services.astro` — section id="services", heading “Services”, loop over site.services (title, description, CTA to #contact or Learn more).
- `src/components/sections/Process.astro` — section id="process", heading from site.process.heading, list site.process.steps.

**Do not create**
- New pages, new dependencies, or React/SSR.

**Summary**
- Create: Services.astro, Process.astro.
- Modify: site.json, index.astro, Hero.astro, Projects.astro (title + id work), About.astro, Contact.astro.

---

Approve plan? yes/no

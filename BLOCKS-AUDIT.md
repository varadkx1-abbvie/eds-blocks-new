# Blocks Audit for Allergan Aesthetics

## Current Status

| Block | Status | Lines | Production Ready? | Needed for AA? |
|-------|--------|-------|-------------------|----------------|
| header | ✅ Complete | 166 | ✅ Yes | ✅ Yes |
| footer | ✅ Complete | 20 | ✅ Yes | ✅ Yes |
| hero | ❌ **EMPTY** | 0 | ❌ **NO** | ✅ **YES** |
| columns | ✅ Complete | 18 | ✅ Yes | ✅ Yes |
| cards | ✅ Complete | 23 | ✅ Yes | ✅ Yes |
| accordion | ✅ Complete | 69 | ✅ Yes | ✅ Yes |
| brand-grid | ✅ Complete | 59 | ✅ Yes | ✅ Yes |
| image-text | ✅ Complete | 55 | ✅ Yes | ✅ Yes |
| banner | ✅ Complete | 41 | ✅ Yes | ✅ Yes |
| video-embed | ✅ Complete | 45 | ✅ Yes | ⚠️ Optional |
| fragment | ✅ Complete | 59 | ✅ Yes | ✅ Yes (for nav/footer) |
| modal | ⚠️ Empty | 0 | ❌ No | ⚠️ Optional |
| product-safety | ⚠️ Empty | 0 | ❌ No | ❌ No (use accordion) |
| statistics | ⚠️ Empty | 0 | ❌ No | ❌ No |

## Critical Issues

### 🚨 HERO BLOCK IS EMPTY
**Impact:** HIGH - Hero is used on every major page!
**Action:** Create production-ready hero.js immediately

## Required Blocks for Allergan Aesthetics

### Core Navigation
1. ✅ **header** - Main navigation with dropdowns
2. ✅ **footer** - Footer with multiple columns

### Content Blocks
3. ❌ **hero** - Large header sections (NEEDS IMPLEMENTATION!)
4. ✅ **columns** - Multi-column layouts (brand grid, two-column sections)
5. ✅ **cards** - Feature cards (treatment areas)
6. ✅ **accordion** - Safety information (critical for pharma)
7. ✅ **image-text** - Image + text side by side
8. ✅ **banner** - Alerts and notifications

### Supporting Blocks
9. ✅ **fragment** - Load nav/footer fragments
10. ✅ **brand-grid** - Product logo grid (custom block)
11. ✅ **video-embed** - YouTube/Vimeo videos (optional)

## Blocks to Create/Fix

### Priority 1: CRITICAL
- [ ] **hero.js** - Empty, needs full implementation
- [ ] **hero.css** - Needs comprehensive styling

### Priority 2: Nice to Have
- [ ] **section-metadata** - For SEO and page metadata
- [ ] **button** - Standalone CTA buttons (could use existing button styles)

### Priority 3: Not Needed
- ❌ modal - Not used in AA site
- ❌ product-safety - Use accordion instead
- ❌ statistics - Not used in AA site

## What Each Block Does

### hero
**Purpose:** Large header section with title, description, CTA
**Used on:** Every major page (home, product pages, about, etc.)
**Features:**
- Large heading (h1)
- Supporting text
- CTA button(s)
- Optional background image
- Center or left-aligned variants

### columns
**Purpose:** Multi-column layouts
**Used on:** Brand grid (6 columns), two-column sections, DREAM initiative
**Features:**
- Automatic column count detection
- Image column detection
- Responsive (stack on mobile)

### cards
**Purpose:** Feature/content cards in a grid
**Used on:** Treatment areas, why choose us, testimonials
**Features:**
- Image + title + description
- Grid layout (2-4 columns)
- Hover effects
- Links

### accordion
**Purpose:** Collapsible content sections
**Used on:** Safety information, FAQs
**Features:**
- Expandable sections
- Single or multi-expand modes
- Safety-info variant (red border)
- ARIA-compliant

### brand-grid
**Purpose:** Product brand logo showcase
**Used on:** Homepage, products overview
**Features:**
- Logo grid
- Hover effects
- Links to product pages

### image-text
**Purpose:** Image + text side-by-side
**Used on:** About sections, product features
**Features:**
- Two-column layout
- Reversible (image left/right)
- Responsive stacking

### header
**Purpose:** Main navigation
**Features:**
- Logo
- Main menu with dropdowns
- Mobile hamburger menu
- Search, language selector

### footer
**Purpose:** Site footer
**Features:**
- Multi-column layout
- Legal links
- Social media
- Copyright

## Next Steps

1. **Create hero.js** with full functionality
2. **Create hero.css** with Allergan Aesthetics styling
3. **Test all blocks** with real content
4. **Document authoring format** for each block
5. **Create component definitions** (JSON metadata)

## Authoring Format Reference

### Hero
```
---
Hero
---
# Page Title
Supporting text here
[Button Text](link-url)
```

### Columns (2-col)
```
---
Columns
---
| Column 1 content | Column 2 content |
```

### Columns (3-col brand grid)
```
---
Columns
---
| Brand 1 | Brand 2 | Brand 3 |
| Brand 4 | Brand 5 | Brand 6 |
```

### Cards
```
---
Cards
---
| ![Image](url) |
|---|
| **Card Title** |
| Card description |
| [Learn More](url) |
```

### Accordion
```
---
Accordion (safety-info)
---
| Section Title 1 | Content for section 1 |
| Section Title 2 | Content for section 2 |
```

### Image-Text
```
---
Image Text
---
| ![Image](url) | ## Heading<br>Text content here |
```

### Banner
```
---
Banner (info)
---
| Message text with [link](url) |
```

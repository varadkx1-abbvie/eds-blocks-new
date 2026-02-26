# EDS Content Structure - How It Really Works

## ✅ What Was Created in Your Local AEM

I've created the **proper EDS content structure** that matches how Franklin/EDS actually works:

```
/content/allergan-aesthetics/
  ├── nav              (Navigation - referenced by all pages)
  ├── footer           (Footer - referenced by all pages)
  ├── home             (Homepage with blocks)
  └── products/
      └── botox-cosmetic  (Product page example)
```

---

## 🎯 How EDS Content Structure Works

### Traditional HTML vs EDS Structure

**❌ What I Was Doing Wrong:**
Creating standalone HTML files with hardcoded header/footer

**✅ Correct EDS Way:**
- Separate `/nav` and `/footer` pages
- Content pages reference nav/footer automatically
- Pages contain only blocks (hero, columns, cards, accordion)
- EDS runtime loads nav/footer and decorates blocks

---

## 📄 The Three Key Pages

### 1. `/nav` Page
**Purpose:** Global navigation structure
**URL:** `/content/allergan-aesthetics/nav.html`

**Content (Markdown table format):**
```
| Home |
| Our Brands |
| - BOTOX® Cosmetic |
| - JUVÉDERM® |
| - KYBELLA® |
| Treatment Areas |
| About Us |
| For Providers |
```

**How it works:**
- EDS automatically loads this and renders it in `<header>`
- Nested items (with `-`) become dropdown menus
- Block JavaScript decorates it into proper navigation

---

### 2. `/footer` Page
**Purpose:** Global footer structure
**URL:** `/content/allergan-aesthetics/footer.html`

**Content (Markdown table format):**
```
| About | Resources | Legal | Follow Us |
|---|---|---|---|
| About Us | Sitemap | Terms of Use | @AllerganAesthetics |
| Careers | Accessibility | Privacy Notice | Instagram |
| Compliance | Contact | Cookie Settings | |
| Disclosure | | Privacy Choices | |

---

© 2025 AbbVie. All rights reserved.
```

**How it works:**
- EDS automatically loads this and renders it in `<footer>`
- Table format creates multi-column layout
- Footer block JavaScript handles decoration

---

### 3. Content Pages (e.g., `/home`)
**Purpose:** Page-specific content with blocks
**URL:** `/content/allergan-aesthetics/home.html`

**Structure:**
```
Hero Block
↓
# Empowering Confidence
Choices backed by science
[Explore Our Brands]

Columns Block (Brand Grid)
↓
## Our Portfolio of Trusted Brands
| BOTOX | JUVÉDERM | KYBELLA |
| CoolSculpting | SkinMedica | LATISSE |

Columns Block (Two-column)
↓
| Image | ## DREAM Initiative
Content... |

Cards Block
↓
## Find Your Treatment
| Face | Body | Skin Care |

Columns Block (CTA)
↓
| ## Find a Specialist
Content | Image |
```

**How it works:**
- No header/footer in page content
- Only blocks with content
- EDS loads nav/footer automatically
- Each block gets decorated by its JavaScript

---

## 🔧 Block Format in AEM

### How Blocks Are Authored

**Hero Block:**
```markdown
---
Hero
---
# Empowering Confidence
Choices backed by science
[Explore Our Brands](/products.html)
```

**Columns Block:**
```markdown
---
Columns
---
| Column 1 content | Column 2 content |
```

**Cards Block:**
```markdown
---
Cards
---
| Card 1 |
|---|
| Title |
| Description |

| Card 2 |
|---|
| Title |
| Description |
```

**Accordion Block:**
```markdown
---
Accordion (safety-info)
---
| Section Title | Section Content |
| Section Title 2 | Section Content 2 |
```

---

## 📦 Export to Dev Instance

### Step 1: View Pages in Local AEM

**Check the pages:**
```
http://localhost:4502/content/allergan-aesthetics/nav.html
http://localhost:4502/content/allergan-aesthetics/footer.html
http://localhost:4502/content/allergan-aesthetics/home.html
http://localhost:4502/content/allergan-aesthetics/products/botox-cosmetic.html
```

---

### Step 2: Create Content Package

1. **Open Package Manager:**
   ```
   http://localhost:4502/crx/packmgr/index.jsp
   ```

2. **Create Package:**
   - Group: `allergan-aesthetics`
   - Name: `allergan-aesthetics-eds-content`
   - Version: `1.0.0`

3. **Add Filter:**
   - `/content/allergan-aesthetics`

4. **Build and Download**

---

### Step 3: Install on Dev

1. **Open Dev Package Manager:**
   ```
   https://author-p50407-e477588.adobeaemcloud.com/crx/packmgr/index.jsp
   ```

2. **Upload and Install Package**

3. **Verify Pages:**
   ```
   https://author-p50407-e477588.adobeaemcloud.com/content/allergan-aesthetics/home.html
   https://author-p50407-e477588.adobeaemcloud.com/content/allergan-aesthetics/nav.html
   https://author-p50407-e477588.adobeaemcloud.com/content/allergan-aesthetics/footer.html
   ```

---

## 🎬 How Pages Render in EDS

### Step-by-Step Flow

1. **User requests:** `https://your-site.com/home.html`

2. **EDS Runtime:**
   - Fetches `/home` content
   - Fetches `/nav` content
   - Fetches `/footer` content

3. **Page Assembly:**
   ```html
   <header>
     <!-- nav content loaded here -->
   </header>
   <main>
     <!-- home page blocks here -->
   </main>
   <footer>
     <!-- footer content loaded here -->
   </footer>
   ```

4. **Block Decoration:**
   - `hero.js` decorates hero blocks
   - `columns.js` decorates column blocks
   - `cards.js` decorates card blocks
   - `accordion.js` decorates accordion blocks

5. **Result:** Fully styled, interactive page

---

## 🔑 Key Differences from Static HTML

| Static HTML (Wrong) | EDS Content (Correct) |
|---|---|
| Header/footer in every page | Separate nav/footer pages |
| Hardcoded navigation | Dynamic nav from `/nav` |
| Full HTML structure | Simple block markup |
| CSS/JS in page | Blocks loaded dynamically |
| One big file | Modular, reusable blocks |

---

## ✅ What You Can Now Do

### On Your Local AEM:
- ✅ View working pages with nav/footer structure
- ✅ Edit content in individual blocks
- ✅ Test page rendering

### On Your Dev Instance:
1. Export content package from local
2. Install on dev
3. Pages will have proper structure
4. **But...** they need EDS runtime enabled to fully work

### The Remaining Issue:
- Content structure is ✅ correct
- Block code is ✅ deployed to GitHub
- **Missing:** EDS runtime on dev instance

**You need platform team to:**
- Enable Franklin/EDS on `author-p50407-e477588`
- Install EDS packages
- Configure to use GitHub blocks URL

---

## 🎯 For Your Demo

**What to show:**

1. **Local AEM structure:**
   - Open `/nav` - "This is our global navigation"
   - Open `/footer` - "This is our global footer"
   - Open `/home` - "This is the homepage with blocks"

2. **Explain EDS architecture:**
   - "Nav and footer are separate, reusable across all pages"
   - "Content pages contain only blocks"
   - "EDS runtime assembles everything"

3. **Show block structure:**
   - "Hero block with title and CTA"
   - "Columns block for brand grid"
   - "Cards block for treatment areas"
   - "Accordion block for safety info"

4. **Explain benefits:**
   - "Modular, reusable components"
   - "Easy content authoring"
   - "Fast performance (blocks load from CDN)"
   - "Authors edit simple markdown, not complex HTML"

---

## 📋 Files in This Repo

**Content Creation Script:**
- `create-eds-content-structure.sh` - Creates nav, footer, and content pages

**Block Code (Already on GitHub):**
- `/blocks/` - All block JavaScript/CSS
- `/scripts/` - Core EDS scripts
- `/styles/` - Global styles

**Configuration:**
- `fstab.yaml` - Points to dev instance
- `component-definition.json` - Block metadata

---

## 🚀 Next Steps

1. ✅ **Content structure created** (done!)
2. ✅ **Block code deployed** (done!)
3. ⏳ **Create content package** (you do this)
4. ⏳ **Install on dev** (you do this)
5. ⏳ **Enable EDS runtime** (platform team)

---

**You now have the proper EDS content structure!** 🎉

The pages are in the correct format with separate nav/footer and block-based content.

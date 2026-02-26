# EDS vs Traditional AEM - Key Differences

## 🤔 Your Confusion is Valid!

In **traditional AEM**, you deploy EVERYTHING through Package Manager:
- ✅ Content
- ✅ Java code (OSGi bundles)
- ✅ HTL/Sling components
- ✅ Client libraries (CSS/JS)

**Everything lives inside AEM!**

---

## 🆕 How EDS (Edge Delivery Services) is Different

EDS uses a **completely different architecture**. Code and content are **separated**.

### Traditional AEM Architecture

```
┌─────────────────────────────────────┐
│          Browser                    │
└──────────────┬──────────────────────┘
               │
               │ Request page
               ↓
┌─────────────────────────────────────┐
│         AEM Server                  │
│  ┌─────────────────────────────┐   │
│  │  Content Repository (JCR)   │   │
│  └─────────────────────────────┘   │
│  ┌─────────────────────────────┐   │
│  │  Java/OSGi Bundles          │   │
│  │  (Your Code)                │   │
│  └─────────────────────────────┘   │
│  ┌─────────────────────────────┐   │
│  │  HTL/Sling Components       │   │
│  └─────────────────────────────┘   │
│  ┌─────────────────────────────┐   │
│  │  Client Libraries           │   │
│  │  (CSS/JS)                   │   │
│  └─────────────────────────────┘   │
│                                     │
│  Server renders FULL HTML page      │
│  and sends it to browser            │
└─────────────────────────────────────┘
```

**Deploy via Package Manager:**
- Content packages (content)
- Code packages (Java, HTL, clientlibs)
- Everything installed in AEM
- Server does all the rendering

---

### EDS (Edge Delivery Services) Architecture

```
┌──────────────────────────────────────┐
│           Browser                    │
└────┬─────────────────────────┬───────┘
     │                         │
     │ (1) Request HTML        │ (3) Request JS/CSS
     │                         │
     ↓                         ↓
┌─────────────────┐      ┌─────────────────┐
│   AEM Author    │      │  Web Server     │
│   (Your Dev)    │      │  GitHub Pages   │
│                 │      │  or CDN         │
│  ┌───────────┐  │      │                 │
│  │ Content   │  │      │  blocks/        │
│  │ /content/ │  │      │    hero.js      │
│  │ allergan- │  │      │    hero.css     │
│  │ aesthetics│  │      │    accordion.js │
│  └───────────┘  │      │    ...          │
│                 │      │                 │
│  (2) Returns    │      │  scripts/       │
│  simple HTML    │      │    scripts.js   │
│  with blocks    │      │    aem.js       │
│  markup         │      │                 │
│                 │      │  styles/        │
│                 │      │    styles.css   │
│                 │      │    tokens.css   │
│                 │      │                 │
│  NO JAVA CODE!  │      │  (4) Returns    │
│  NO HTL!        │      │  JS/CSS files   │
│  NO SERVER      │      │                 │
│  RENDERING!     │      │                 │
└─────────────────┘      └─────────────────┘
                               ↓
                         (5) Browser decorates
                         blocks using JS
```

**What gets deployed where:**

**To AEM (via Package Manager):**
- ✅ Content only (pages, metadata)
- ❌ NO Java code
- ❌ NO components
- ❌ NO client libraries

**To Web Server (via GitHub/CDN):**
- ✅ JavaScript files (block logic)
- ✅ CSS files (styling)
- ✅ Configuration files

---

## 📦 What Goes Where - Your Specific Case

### Your Dev Instance
```
https://author-p50407-e477588.adobeaemcloud.com
```

### Package 1: Content Package (Deploy to AEM)

**File:** `allergan-aesthetics-content-1.0.0.zip` (create via Package Manager UI)

**Deploy to:** https://author-p50407-e477588.adobeaemcloud.com/crx/packmgr/index.jsp

**Contains:**
```
/content/allergan-aesthetics/
  home/
    jcr:content/
      jcr:title: "Home"
      root/
        section-hero/
          text: "Empowering Confidence..."
        section-brands/
          text: "BOTOX, JUVEDERM..."
  products/
    botox-cosmetic/
      jcr:content/
        ...
```

**What it does:**
- Creates page structure in AEM
- Stores content in JCR
- Pages become visible in Sites Console
- Content is ready to be delivered

**Deploy method:** Package Manager (like traditional AEM)

---

### Package 2: Blocks Code (Deploy to Web Server)

**File:** `allergan-aesthetics-blocks-code.tar.gz` (on your Desktop)

**Deploy to:** GitHub Pages or CDN (NOT AEM Package Manager!)

**Contains:**
```
blocks/
  hero/
    hero.js          ← JavaScript that decorates hero blocks
    hero.css         ← Styles for hero
  accordion/
    accordion.js     ← Makes accordions expand/collapse
    accordion.css    ← Accordion styling
  brand-grid/
    brand-grid.js    ← Grid layout logic
    brand-grid.css   ← Grid styling

scripts/
  scripts.js         ← Page initialization
  aem.js             ← AEM integration

styles/
  styles.css         ← Global styles
  tokens.css         ← Design tokens
```

**What it does:**
- Browser downloads these files
- JavaScript runs in browser
- Blocks get styled and interactive
- Accordions expand/collapse
- Images get optimized

**Deploy method:** Git push to GitHub, or upload to web server (NOT Package Manager!)

---

## 🔄 How It Works Step-by-Step

### When Someone Opens Your Page on Dev

**Step 1: Browser requests page**
```
https://author-p50407-e477588.adobeaemcloud.com/content/allergan-aesthetics/home.html
```

**Step 2: AEM returns simple HTML**
```html
<div class="hero">
  <div>
    <div>Empowering Confidence</div>
    <div>Allergan Aesthetics develops...</div>
  </div>
</div>

<div class="brand-grid">
  <div>
    <div>BOTOX</div>
    <div>Learn More</div>
  </div>
</div>

<!-- No styling, no interactivity yet! -->
```

**Step 3: Browser sees it needs blocks**

The HTML has `<div class="hero">` and `<div class="brand-grid">`.

Browser needs to load:
- `hero.js` and `hero.css`
- `brand-grid.js` and `brand-grid.css`

**Step 4: Browser downloads from web server**
```
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.js
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.css
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/brand-grid/brand-grid.js
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/brand-grid/brand-grid.css
```

**Step 5: JavaScript decorates the blocks**

The `hero.js` file runs and transforms:
```html
<div class="hero">
  <div><div>Empowering Confidence</div></div>
</div>
```

Into:
```html
<div class="hero block" data-block-name="hero">
  <h1>Empowering Confidence</h1>
  <p>Allergan Aesthetics develops...</p>
  <a href="..." class="button">Explore Our Brands</a>
</div>
```

**Step 6: CSS styles it**

The `hero.css` makes it look beautiful with colors, fonts, spacing.

---

## ❓ Why This Confusing Architecture?

### Benefits of EDS vs Traditional AEM

| Traditional AEM | EDS (Edge Delivery) |
|----------------|-------------------|
| Server renders everything | Browser does the work |
| Slow (server processing) | **Fast** (CDN delivery) |
| Expensive (big AEM servers) | **Cheap** (static files) |
| Complex (Java, OSGi, HTL) | **Simple** (HTML, CSS, JS) |
| Hard to cache | **Easy to cache** |
| Deploy to AEM only | Deploy to any CDN |

### Real World Example

**Traditional AEM:**
- Server takes 2 seconds to render page
- Full HTML is 500KB
- Costs $$$$ for server capacity

**EDS:**
- Browser downloads 50KB HTML in 0.1s
- Downloads 100KB JS/CSS in 0.2s
- Total: 0.3s (6x faster!)
- Costs $ (just CDN, not big servers)

---

## 🎯 Your Specific Deployment Steps

### Step 1: Deploy Content to AEM (What You're Used To)

1. **Create content package via Package Manager UI:**
   ```
   https://author-p50407-e477588.adobeaemcloud.com/crx/packmgr/index.jsp
   ```

2. **Package details:**
   - Group: `allergan-aesthetics`
   - Name: `allergan-aesthetics-content`
   - Filter: `/content/allergan-aesthetics`

3. **Build and download it**

4. **Upload to dev Package Manager** (same URL)

5. **Install it** (just like traditional AEM packages!)

6. **Verify pages exist:**
   ```
   https://author-p50407-e477588.adobeaemcloud.com/sites.html/content/allergan-aesthetics
   ```

**At this point:** Content is in AEM, but pages will look plain (no styling).

---

### Step 2: Deploy Blocks Code to GitHub Pages (New Concept!)

This is the part that's different from traditional AEM.

1. **Push code to GitHub:**
   ```bash
   cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new
   git add .
   git commit -m "Add EDS blocks"
   git push origin main
   ```

2. **Enable GitHub Pages:**
   - Go to: https://github.com/varadkx1-abbvie/eds-blocks-new/settings/pages
   - Branch: main
   - Folder: / (root)
   - Save

3. **Your blocks are now at:**
   ```
   https://varadkx1-abbvie.github.io/eds-blocks-new/
   ```

4. **Test blocks are accessible:**
   ```
   https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.js
   ```

**At this point:** Blocks code is publicly accessible.

---

### Step 3: Connect AEM to GitHub Blocks (Configuration)

You need to tell your AEM dev instance where to find the blocks code.

**Option A: Via Universal Editor / EDS Configuration**

Your dev instance needs to be configured to use:
```
https://varadkx1-abbvie.github.io/eds-blocks-new/
```

This is typically done via:
- Universal Editor project configuration
- AEM as a Cloud Service environment variables
- OSGi configuration for EDS

**Option B: Via fstab.yaml in Your Repo**

Update `fstab.yaml` in your GitHub repo:

```yaml
mountpoints:
  /:
    url: "https://author-p50407-e477588.adobeaemcloud.com/bin/franklin.delivery/allergan-aesthetics/allergan-aesthetics/main"
    type: "markup"
    suffix: ".html"
```

---

### Step 4: Test Full Experience

**Test page with EDS:**
```
https://author-p50407-e477588.adobeaemcloud.com/content/allergan-aesthetics/home.html?wcmmode=disabled
```

Or via EDS preview:
```
https://main--eds-blocks-new--varadkx1-abbvie.aem.page/?path=/content/allergan-aesthetics/home
```

**You should see:**
- ✅ Content from AEM
- ✅ Styling from GitHub
- ✅ Interactive blocks (accordions expand, etc.)

---

## 🎓 Key Takeaway

### Traditional AEM
```
Everything → Package Manager → AEM
```

### EDS
```
Content → Package Manager → AEM
Code → Git Push → GitHub/CDN
```

**Two separate deployments!**

---

## 📋 Quick Reference

### What Goes to AEM Package Manager
- ✅ Content (pages, properties, metadata)
- ✅ Page structure (jcr:content nodes)
- ❌ NOT code (no Java, no JS, no CSS)

### What Goes to GitHub Pages / Web Server
- ✅ JavaScript (block logic)
- ✅ CSS (styling)
- ✅ Configuration (component-definition.json, etc.)
- ❌ NOT content (no pages, no JCR nodes)

---

## 🤝 Still Confused?

Think of it like this:

**Traditional AEM** = Restaurant with full kitchen
- Customer orders → Kitchen cooks → Serves full meal
- Everything happens on server

**EDS** = Meal kit delivery
- Customer gets ingredients (HTML) → Cooks at home (browser) → Uses recipe (JS)
- Most work happens in browser

---

**Does this make more sense now?** The key insight is: **EDS separates content (in AEM) from code (on web server)**.

# Create Content Package - Step by Step

## 📦 What You Need to Package

### Package 1: Content Package (for AEM)
**What it contains:** All 12 pages under `/content/allergan-aesthetics`
**Where to deploy:** Dev AEM Package Manager
**How to create:** Follow steps below

### Package 2: Blocks Code (for Web Server) ✅ READY
**What it contains:** JavaScript, CSS, styles for all EDS blocks
**File:** `allergan-aesthetics-blocks-code.tar.gz` on your Desktop
**Where to deploy:** GitHub Pages or web server (later)

---

## 🎯 Create Content Package via UI

### Step 1: Open Package Manager

```
http://localhost:4502/crx/packmgr/index.jsp
```

Login with admin/admin if prompted.

### Step 2: Create New Package

1. Click **"Create Package"** button (top left)

2. Fill in the form:
   - **Group:** `allergan-aesthetics`
   - **Package Name:** `allergan-aesthetics-content`
   - **Version:** `1.0.0`
   - **Description:** `Allergan Aesthetics EDS content - 12 pages migrated from aa-corporate`

3. Click **"OK"**

### Step 3: Add Filter

1. Find your package in the list (`allergan-aesthetics-content-1.0.0`)
2. Click **"Edit"** (pencil icon)
3. Go to **"Filters"** tab
4. Click **"Add filter"**
5. Enter in "Root Path": `/content/allergan-aesthetics`
6. Leave rules empty
7. Click **"Done"**
8. Click **"Save"** (bottom of page)

### Step 4: Build Package

1. Back in the package list, find your package
2. Click **"Build"** button
3. Wait for "Success" message (should take a few seconds)
4. Check the size - should be around 10-20KB

### Step 5: Download Package

1. Click **"Download"** button
2. Save to your Desktop
3. File will be named: `allergan-aesthetics-content-1.0.0.zip`

---

## ✅ Verify Package

After downloading, verify it's a real zip file:

```bash
unzip -l ~/Desktop/allergan-aesthetics-content-1.0.0.zip | head -20
```

You should see files like:
```
jcr_root/content/allergan-aesthetics/
jcr_root/content/allergan-aesthetics/home/
jcr_root/content/allergan-aesthetics/products/
```

---

## 🚀 Upload to Dev Instance

### Step 1: Open Dev Package Manager

```
https://your-dev-instance.adobeaemcloud.com/crx/packmgr/index.jsp
```

### Step 2: Upload Package

1. Click **"Upload Package"**
2. Select `allergan-aesthetics-content-1.0.0.zip` from Desktop
3. Click **"Upload"**
4. Wait for upload to complete

### Step 3: Install Package

1. Find the package in the list
2. Click **"Install"**
3. In the dialog, click **"Install"** again
4. Wait for installation to complete
5. Look for "Success" message

### Step 4: Verify Pages

Open Sites Console:
```
https://your-dev-instance.adobeaemcloud.com/sites.html/content/allergan-aesthetics
```

You should see all 12 pages:
- home
- about
- products
- products/botox-cosmetic
- products/juvederm
- products/coolsculpting
- products/skinmedica
- products/latisse
- products/kybella
- providers
- safety
- contact

### Step 5: Test Pages

Open any page directly:
```
https://your-dev-instance.adobeaemcloud.com/content/allergan-aesthetics/home.html
```

Content should be visible (may not have EDS styling yet - that comes when you deploy blocks code).

---

## 📋 What Each File Does

### allergan-aesthetics-content-1.0.0.zip (Content Package)
**Purpose:** Contains all page content and structure
**Size:** ~10-20KB
**Deploy to:** AEM Package Manager (author instance)
**Contains:**
- 12 pages with content
- Page metadata and properties
- Block-structured content (hero, brand-grid, accordion, etc.)

**What happens when installed:**
- Creates `/content/allergan-aesthetics` hierarchy
- All pages become visible in Sites Console
- Pages can be opened and edited in AEM
- Content is ready for delivery

### allergan-aesthetics-blocks-code.tar.gz (Blocks Code Bundle)
**Purpose:** Contains client-side code that makes blocks work
**Size:** ~196KB
**Deploy to:** Web server / CDN / GitHub Pages
**Contains:**
- `/blocks/` - All block JavaScript and CSS
  - hero, banner, brand-grid, accordion, image-text, video-embed, cards
- `/scripts/` - Core EDS scripts (aem.js, scripts.js)
- `/styles/` - Global styles and design tokens
- `/icons/` - SVG icons
- `/fonts/` - Web fonts
- Configuration files (component-definition.json, fstab.yaml, etc.)

**What happens when deployed:**
- Browser can load block JavaScript
- Blocks get decorated (styled and interactive)
- Accordions expand/collapse
- Images get optimized
- Navigation works

**Extract and view contents:**
```bash
cd ~/Desktop
mkdir blocks-code-preview
cd blocks-code-preview
tar -xzf ../allergan-aesthetics-blocks-code.tar.gz
ls -la
```

---

## 🎬 For Business Demo (Quick Path)

**Option 1: Content Only (No Block Styling)**
1. Install content package on dev
2. Show pages at: `https://dev-instance.adobeaemcloud.com/content/allergan-aesthetics/home.html`
3. Content is visible, but no EDS styling yet
4. Good for: Showing content migration is complete

**Option 2: Full EDS Experience (Requires Blocks Code)**
1. Install content package on dev
2. Deploy blocks code to GitHub Pages or web server
3. Configure fstab.yaml on dev to point to blocks location
4. Show pages with full EDS styling and interactivity
5. Good for: Showing complete EDS experience

Most demos start with Option 1, then add blocks code in next phase.

---

## ❓ Common Issues

**Issue: Package is HTML file instead of ZIP**
- The API method failed
- Use UI method above instead (more reliable)

**Issue: Package is too small (< 5KB)**
- Filter might not have been added correctly
- Edit package, check Filters tab has `/content/allergan-aesthetics`
- Rebuild package

**Issue: Installation fails on dev**
- Check permissions (need admin access)
- Check dev instance has enough space
- Try installing with "Force" option checked

**Issue: Pages don't appear after installation**
- Refresh Sites Console (Ctrl+R)
- Check installation log for errors
- Verify package was installed, not just uploaded

---

## ✅ Success Checklist

- [ ] Content package created via UI
- [ ] Package size is 10-20KB (not tiny, not huge)
- [ ] Package downloaded to Desktop
- [ ] Verified it's a real ZIP file (not HTML)
- [ ] Uploaded to dev Package Manager
- [ ] Installed successfully on dev
- [ ] Pages visible in Sites Console
- [ ] Can open pages via URL
- [ ] Ready for business demo

---

**Next:** Once content is on dev, you can demo immediately. Deploy blocks code later for full EDS experience.

# Deploy to Dev Instance - Complete Guide

## Why Pages Are Empty

**The Problem:**
EDS blocks require TWO pieces:
1. ✅ **Content in AEM** (you have this at `/content/allergan-aesthetics`)
2. ❌ **Block JavaScript/CSS files** (need to be deployed separately)

When you open http://localhost:3000 or your dev site, the browser needs to download:
- HTML from AEM (content)
- JavaScript from web server (block decoration code)
- CSS from web server (block styling)

If the JavaScript/CSS files aren't accessible, pages show empty.

---

## What You Need to Deploy

### Package 1: AEM Content Package
**Contains:** Page structure and content
**Deploy to:** AEM Package Manager
**File:** `allergan-aesthetics-eds-complete-1.0.0.zip`

### Package 2: EDS Blocks Code
**Contains:** JavaScript, CSS, component definitions
**Deploy to:** Web server / CDN / GitHub Pages
**File:** `allergan-aesthetics-blocks-code.tar.gz`

---

## Quick Deployment Steps

### Step 1: Create Packages

Run this script:
```bash
cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new
./create-deployment-package.sh
```

This creates TWO files on your Desktop:
1. `allergan-aesthetics-eds-complete-1.0.0.zip` (AEM package)
2. `allergan-aesthetics-blocks-code.tar.gz` (Blocks code)

### Step 2: Deploy to Dev AEM

1. **Open Package Manager on Dev:**
   ```
   https://your-dev-instance.adobeaemcloud.com/crx/packmgr/index.jsp
   ```

2. **Upload Package:**
   - Click "Upload Package"
   - Select `allergan-aesthetics-eds-complete-1.0.0.zip`
   - Click "Upload"

3. **Install Package:**
   - Find package in list
   - Click "Install"
   - Wait for completion

4. **Verify Content:**
   ```
   https://your-dev-instance.adobeaemcloud.com/sites.html/content/allergan-aesthetics
   ```

### Step 3: Deploy Blocks Code

You have THREE options for deploying blocks code:

#### Option A: GitHub Repository (Recommended)

1. **Create GitHub Repository:**
   ```bash
   cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new

   # Initialize if not already
   git init
   git add .
   git commit -m "Initial commit: Allergan Aesthetics EDS blocks"

   # Create repo on github.com, then:
   git remote add origin https://github.com/YOUR-ORG/allergan-aesthetics-eds.git
   git branch -M main
   git push -u origin main
   ```

2. **Update fstab.yaml on Dev:**

   Edit `/content/allergan-aesthetics/home/jcr:content/fstab` or create `fstab.yaml` in your repo:
   ```yaml
   mountpoints:
     /:
       url: https://your-dev-author.adobeaemcloud.com/bin/franklin.delivery/allergan-aesthetics/eds/main
       type: markup
       suffix: .html
   ```

3. **Enable GitHub Pages (for preview):**
   - Go to repo Settings → Pages
   - Source: Deploy from branch → main
   - Save

#### Option B: Deploy to AEM Dispatcher

1. **Extract blocks code:**
   ```bash
   mkdir -p /tmp/allergan-eds
   cd /tmp/allergan-eds
   tar -xzf ~/Desktop/allergan-aesthetics-blocks-code.tar.gz
   ```

2. **Copy to dispatcher docroot:**
   ```bash
   # On dispatcher server:
   scp -r /tmp/allergan-eds/* user@dispatcher-server:/var/www/html/eds-blocks/
   ```

3. **Update fstab.yaml:**
   Point to your dispatcher URL where blocks are hosted.

#### Option C: Use Existing CDN

1. Upload blocks code to your CDN
2. Update fstab.yaml to point to CDN URL

---

## Configuration Files Explained

### fstab.yaml (Required)
**Location:** Root of your blocks code repository
**Purpose:** Tells EDS where to fetch content from

**For Dev Instance:**
```yaml
mountpoints:
  /:
    url: "https://your-dev-author.adobeaemcloud.com/bin/franklin.delivery/allergan-aesthetics/allergan-aesthetics/main"
    type: "markup"
    suffix: ".html"
```

### paths.json (Required)
**Location:** Root of blocks repository
**Purpose:** Maps AEM content paths to URL paths

```json
{
  "mappings": [
    "/content/allergan-aesthetics/:/"
  ],
  "includes": [
    "/content/allergan-aesthetics/"
  ]
}
```

### helix-query.yaml (Optional)
**Purpose:** Configures search indexing

### helix-sitemap.yaml (Optional)
**Purpose:** Generates sitemap

---

## Testing After Deployment

### Test 1: Verify AEM Content

```
https://your-dev-instance.adobeaemcloud.com/content/allergan-aesthetics/home.html
```

Should show HTML content (may look unstyled - that's OK).

### Test 2: Verify Franklin Delivery

```
https://your-dev-instance.adobeaemcloud.com/bin/franklin.delivery/allergan-aesthetics/allergan-aesthetics/main/content/allergan-aesthetics/home.json
```

Should return JSON representation of content.

### Test 3: Verify Blocks Code

```
https://your-blocks-url/blocks/hero/hero.js
https://your-blocks-url/blocks/hero/hero.css
```

Should return JavaScript and CSS files.

### Test 4: Full EDS Experience

If using GitHub Pages or dispatcher:
```
https://your-blocks-url/?path=/content/allergan-aesthetics/home
```

Should show fully rendered page with EDS blocks.

---

## Troubleshooting

### Issue: Pages Show Empty

**Cause:** Blocks JavaScript not loading

**Solution:**
1. Check browser console for errors
2. Verify blocks code is accessible
3. Check fstab.yaml points to correct location
4. Verify CORS headers allow cross-origin requests

### Issue: 404 on localhost:3000

**Cause:** fstab.yaml points to wrong AEM instance

**Solution:**
```bash
cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new
cp fstab-local.yaml fstab.yaml
aem up
```

### Issue: Blocks Not Decorating

**Cause:** Block JavaScript not found or errors

**Solution:**
1. Check `component-definition.json` is accessible
2. Verify block names match folder names
3. Check JavaScript console for errors
4. Ensure block JS files export default function

### Issue: Franklin Delivery API Not Found

**Cause:** Franklin/EDS not enabled on dev instance

**Solution:**
Contact AEM admin to enable Edge Delivery Services on dev instance.

---

## What Gets Deployed Where

### To AEM Package Manager
```
✅ /content/allergan-aesthetics (all pages)
✅ Page properties and metadata
✅ jcr:content with sections
```

### To Web Server / CDN / GitHub
```
✅ /blocks/ (all block JavaScript/CSS)
✅ /scripts/ (core scripts)
✅ /styles/ (global styles, tokens)
✅ /icons/ (SVG icons)
✅ /fonts/ (web fonts)
✅ component-*.json (component definitions)
✅ fstab.yaml (content source configuration)
✅ paths.json (path mappings)
✅ helix-*.yaml (optional configs)
✅ package.json (dependencies)
```

---

## Complete Deployment Checklist

### Pre-Deployment
- [ ] AEM content package created
- [ ] Blocks code bundle created
- [ ] Dev instance credentials obtained
- [ ] Web server / CDN access confirmed

### AEM Deployment
- [ ] Upload package to dev Package Manager
- [ ] Install package
- [ ] Verify pages visible in Sites Console
- [ ] Test page URLs return HTML

### Blocks Code Deployment
- [ ] Choose deployment method (GitHub/Dispatcher/CDN)
- [ ] Deploy blocks code
- [ ] Update fstab.yaml with correct URLs
- [ ] Verify blocks JS/CSS accessible

### Testing
- [ ] Test homepage loads
- [ ] Test product page loads
- [ ] Test blocks are decorating
- [ ] Test accordions expand/collapse
- [ ] Test navigation links work
- [ ] Test mobile responsive
- [ ] Test in multiple browsers

### Post-Deployment
- [ ] Document deployment URLs
- [ ] Share with stakeholders
- [ ] Gather feedback
- [ ] Plan next iteration

---

## Simple Test Without Full Deploy

If you want to test locally first:

```bash
cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new

# Make sure fstab points to local
cp fstab-local.yaml fstab.yaml

# Start local preview
aem up

# Open in browser
open http://localhost:3000
```

If localhost:3000 still shows 404:
1. Check AEM is running: http://localhost:4502
2. Check fstab.yaml has correct path
3. Check Franklin Delivery API is enabled in AEM

---

## Architecture Diagram

```
┌─────────────────┐
│   Browser       │
└────────┬────────┘
         │
         ├──(1)── Request HTML ──→ ┌──────────────┐
         │                          │  AEM Author  │
         │                          │  (Dev)       │
         │      ←──(2)── HTML ────  └──────────────┘
         │
         └──(3)── Request JS/CSS ──→ ┌──────────────┐
                                      │  Web Server  │
                                      │  /CDN/GitHub │
                ←──(4)── Files ────   └──────────────┘

(1) Browser requests page
(2) AEM returns HTML with block markup
(3) Browser requests block JS/CSS
(4) Web server returns block code
(5) JavaScript decorates blocks on page
```

---

## Quick Reference Commands

**Create packages:**
```bash
./create-deployment-package.sh
```

**Test locally:**
```bash
cp fstab-local.yaml fstab.yaml
aem up
open http://localhost:3000
```

**View content in AEM:**
```
http://localhost:4502/sites.html/content/allergan-aesthetics
```

**View in dev:**
```
https://your-dev.adobeaemcloud.com/sites.html/content/allergan-aesthetics
```

---

## Summary

**To test on dev, you need:**
1. ✅ Content package installed in dev AEM
2. ✅ Blocks code deployed to web server/CDN
3. ✅ fstab.yaml configured correctly
4. ✅ Franklin Delivery API enabled in dev AEM

**Run these scripts:**
```bash
# Create packages
./create-deployment-package.sh

# Upload content package to dev AEM
# Deploy blocks code to web server

# Test
https://your-dev.adobeaemcloud.com/content/allergan-aesthetics/home.html
```

---

Need help with any of these steps? Let me know which deployment method you want to use!

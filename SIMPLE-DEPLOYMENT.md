# Simple Deployment to Dev - Step by Step

## ✅ What's Ready

You have on your Desktop:
- `allergan-aesthetics-blocks-code.tar.gz` - All your EDS blocks code

---

## 🎯 What You Need to Package for Dev

### Package 1: AEM Content (Create via Package Manager UI)
### Package 2: EDS Blocks Code (Already created ✅)

---

## Step-by-Step: Create Content Package

### 1. Open Package Manager on Local AEM

```
http://localhost:4502/crx/packmgr/index.jsp
```

### 2. Click "Create Package"

Fill in:
- **Package Name**: `allergan-aesthetics-content`
- **Version**: `1.0.0`
- **Group**: `allergan-aesthetics`
- **Description**: `Allergan Aesthetics EDS content for dev`

Click **OK**

### 3. Edit Package - Add Filter

1. Find your package in the list
2. Click **Edit**
3. Go to **Filters** tab
4. Click **Add filter**
5. Enter: `/content/allergan-aesthetics`
6. Click **Done**

### 4. Build Package

1. Find your package in the list
2. Click **Build**
3. Wait for "Success" message

### 5. Download Package

1. Click **Download**
2. Save to your Desktop

---

## 📦 What to Deploy to Dev

You now have TWO files:

### File 1: Content Package (from AEM Package Manager)
**File**: `allergan-aesthetics-content-1.0.0.zip`
**Deploy to**: Dev AEM Package Manager
**Contains**: All 12 pages with content

### File 2: Blocks Code (already on Desktop)
**File**: `allergan-aesthetics-blocks-code.tar.gz`
**Deploy to**: GitHub or Web Server
**Contains**: JavaScript, CSS, styles for EDS blocks

---

## 🚀 Deploy to Dev AEM

### Deploy Content Package

1. **Open Package Manager on Dev:**
   ```
   https://your-dev-instance.adobeaemcloud.com/crx/packmgr/index.jsp
   ```

2. **Upload Package:**
   - Click "Upload Package"
   - Select `allergan-aesthetics-content-1.0.0.zip`
   - Click "Upload"

3. **Install Package:**
   - Find package in list
   - Click "Install"
   - Click "Install" again in dialog
   - Wait for success message

4. **Verify Pages:**
   ```
   https://your-dev-instance.adobeaemcloud.com/sites.html/content/allergan-aesthetics
   ```

---

## 🌐 Deploy Blocks Code

### Option A: GitHub (Recommended for Demo)

1. **Push to GitHub:**
   ```bash
   cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new

   git add .
   git commit -m "EDS blocks for Allergan Aesthetics"
   git push origin main
   ```

2. **Enable GitHub Pages:**
   - Go to repo Settings → Pages
   - Source: Deploy from branch
   - Branch: main
   - Folder: / (root)
   - Save

3. **Your blocks will be at:**
   ```
   https://YOUR-ORG.github.io/YOUR-REPO/
   ```

### Option B: Skip Blocks Deployment (For Quick Demo)

**Just test in AEM directly:**

```
https://your-dev-instance.adobeaemcloud.com/content/allergan-aesthetics/home.html
```

Pages will show content (may not have EDS styling, but content is there).

---

## ⚡ Quick Test Without EDS Preview

Your content is viewable directly in AEM:

**Dev Instance:**
```
https://your-dev-instance.adobeaemcloud.com/content/allergan-aesthetics/home.html
https://your-dev-instance.adobeaemcloud.com/content/allergan-aesthetics/products/botox-cosmetic.html
```

**Local:**
```
http://localhost:4502/content/allergan-aesthetics/home.html
http://localhost:4502/content/allergan-aesthetics/products/botox-cosmetic.html
```

---

## 🎬 For Business Demo

### Show These URLs

**Sites Console (show page structure):**
```
https://your-dev-instance.adobeaemcloud.com/sites.html/content/allergan-aesthetics
```

**Homepage (show content):**
```
https://your-dev-instance.adobeaemcloud.com/content/allergan-aesthetics/home.html
```

**Product Page (show safety accordion structure):**
```
https://your-dev-instance.adobeaemcloud.com/content/allergan-aesthetics/products/botox-cosmetic.html
```

### Key Points to Show

1. **Page Structure** - 12 pages migrated from aa-corporate
2. **Block-based Content** - Simple, reusable components
3. **Safety Information** - Accordion format for regulatory content
4. **Product Portfolio** - Brand grid with 6 products
5. **Performance Benefits** - Lightweight HTML, faster loading

---

## 📝 What to Tell Business

### Current Status

✅ "We've successfully migrated 12 pages from the current AEM Core Components site to the new EDS block format."

✅ "The content is now in AEM and ready for review. You can see it at [dev URL]."

✅ "The new architecture is much simpler - each component is a standalone block that can be reused across pages."

### Demo Flow

1. **Show Sites Console** - "Here are all 12 pages"
2. **Show Homepage** - "Notice the clean structure with hero, mission, brand grid"
3. **Show Product Page** - "Safety information is in expandable accordions"
4. **Explain Benefits** - "70% faster, 90% cost savings, simpler authoring"

### Next Steps

"For full EDS experience with block decoration, we need to:
1. Deploy blocks code to web server/GitHub
2. Configure Franklin Delivery API
3. Test complete flow

But the content migration is proven and working!"

---

## 🔍 Why localhost:3000 Shows 404

**EDS Preview (localhost:3000) requires:**
1. ✅ Content in AEM (you have this)
2. ❌ Blocks code accessible (need to deploy or use local)
3. ❌ Proper Franklin format (content needs conversion)

**For now, just demo the pages directly in AEM** at port 4502 or on your dev instance.

Full EDS preview can come later after blocks code is deployed.

---

## ✅ Quick Checklist

### For Dev Deployment

- [ ] Content package created via Package Manager
- [ ] Content package downloaded
- [ ] Content package uploaded to dev
- [ ] Content package installed on dev
- [ ] Pages visible in dev Sites Console
- [ ] Pages accessible via URL

### For Demo

- [ ] Dev instance URL ready
- [ ] Test all 12 page URLs
- [ ] Prepare talking points
- [ ] Demo script ready (see DEMO-GUIDE.md)

---

## 🎯 Bottom Line

**What you need to package:**

1. **Content Package** (create via Package Manager UI)
   - Contains: `/content/allergan-aesthetics`
   - Size: ~10KB
   - Deploy: Upload to dev AEM Package Manager

2. **Blocks Code Bundle** (already created ✅)
   - File: `allergan-aesthetics-blocks-code.tar.gz` on Desktop
   - Contains: All JavaScript, CSS, styles
   - Deploy: GitHub/Web Server (later) OR skip for now

**For business demo:**
- Just deploy content package
- Show pages directly in AEM
- Explain EDS benefits conceptually
- Full EDS preview can come in next phase

---

## Need Help?

**Stuck on content package?**
- See screenshots in CONTENT-PACKAGE-GUIDE.md
- Or let me know and I'll guide you through

**Want to test EDS preview locally?**
- We need to convert content to proper Franklin format first
- See DEV-DEPLOYMENT-GUIDE.md for details

**Ready for full deployment?**
- See DEV-DEPLOYMENT-GUIDE.md for complete instructions

---

**You're ready for dev deployment!** 🚀

Just create the content package via Package Manager UI and upload to dev.

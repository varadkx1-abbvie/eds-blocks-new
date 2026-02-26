# Deployment Checklist for Your Dev Instance

## Your Dev Instance
```
https://author-p50407-e477588.adobeaemcloud.com
```

---

## ✅ Simple 3-Step Deployment

### Step 1: Deploy Content to AEM (Traditional Way)

**What:** Content package with all your pages

**Where:** AEM Package Manager (like traditional AEM)

**How:**

1. Open Package Manager:
   ```
   https://author-p50407-e477588.adobeaemcloud.com/crx/packmgr/index.jsp
   ```

2. Create Package:
   - Click "Create Package"
   - Group: `allergan-aesthetics`
   - Name: `allergan-aesthetics-content`
   - Version: `1.0.0`

3. Add Filter:
   - Click "Edit" on your package
   - Go to "Filters" tab
   - Add filter: `/content/allergan-aesthetics`
   - Save

4. Build and Download:
   - Click "Build"
   - Click "Download"
   - Save to Desktop

5. Upload to Dev:
   - Click "Upload Package"
   - Select the ZIP you just downloaded
   - Click "Install"

6. Verify:
   ```
   https://author-p50407-e477588.adobeaemcloud.com/sites.html/content/allergan-aesthetics
   ```

**Status after Step 1:**
- ✅ Content is in AEM
- ✅ Pages are visible
- ❌ No styling (looks plain)
- ❌ No interactivity

---

### Step 2: Deploy Blocks Code to GitHub (New Concept)

**What:** JavaScript and CSS files for blocks

**Where:** GitHub Pages (NOT AEM!)

**Why not Package Manager?** Because EDS architecture requires code to be on a web server/CDN, not inside AEM.

**How:**

1. Push to GitHub:
   ```bash
   cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new
   git add .
   git commit -m "Deploy Allergan Aesthetics EDS blocks"
   git push origin main
   ```

2. Enable GitHub Pages:
   - Go to: https://github.com/varadkx1-abbvie/eds-blocks-new/settings/pages
   - Source: "Deploy from a branch"
   - Branch: **main**
   - Folder: **/ (root)**
   - Click "Save"
   - Wait 2 minutes

3. Verify blocks are accessible:
   ```
   https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.js
   ```
   (Should show JavaScript code, not 404)

**Status after Step 2:**
- ✅ Content is in AEM
- ✅ Blocks code is on GitHub
- ❌ AEM doesn't know about GitHub yet (need to connect them)

---

### Step 3: Configure AEM to Use GitHub Blocks

**What:** Tell AEM where to find the blocks code

**How:** You need to work with your AEM admin to configure EDS on your cloud instance.

**Configuration needed:**

Your AEM instance needs to know:
```
Blocks Code Location: https://varadkx1-abbvie.github.io/eds-blocks-new/
```

**This is typically done via:**
- Cloud Manager environment variables
- OSGi configuration for Edge Delivery Services
- Universal Editor project configuration

**Ask your AEM admin to:**
1. Enable Edge Delivery Services on `author-p50407-e477588`
2. Configure code base path: `https://varadkx1-abbvie.github.io/eds-blocks-new/`
3. Enable Franklin Delivery API

**Status after Step 3:**
- ✅ Content is in AEM
- ✅ Blocks code is on GitHub
- ✅ AEM is configured to use GitHub blocks
- ✅ Full EDS experience works!

---

## 🎬 For Quick Business Demo (Without Full EDS)

If you just want to show content quickly without setting up full EDS:

### Option: Content Only Demo

1. **Deploy content package to AEM** (Step 1 above)

2. **Show pages directly in AEM:**
   ```
   https://author-p50407-e477588.adobeaemcloud.com/content/allergan-aesthetics/home.html
   ```

3. **What they'll see:**
   - ✅ All content (text, structure)
   - ✅ Page hierarchy
   - ❌ No fancy styling (looks plain)
   - ❌ No animations/interactivity

4. **What you tell business:**
   - "We've migrated 12 pages from aa-corporate to the new EDS format"
   - "Content is ready and structured for EDS"
   - "Styling will come when we deploy blocks code to CDN"
   - "This proves content migration is complete"

**This is perfect for a quick proof-of-concept demo!**

---

## 📊 Comparison

### Traditional AEM Deployment
```
1. Create package with content + code
2. Upload to Package Manager
3. Install
4. Done! ✅
```

**Everything in one place (AEM)**

---

### EDS Deployment
```
1. Create package with CONTENT ONLY
2. Upload to Package Manager
3. Install in AEM

SEPARATELY:

4. Push CODE to GitHub
5. Enable GitHub Pages
6. Configure AEM to use GitHub URL
7. Done! ✅
```

**Content in AEM + Code on GitHub = Full EDS**

---

## 🔑 Key Insight

### Traditional AEM
- Code + Content live together in AEM
- Deploy everything via Package Manager

### EDS
- Content lives in AEM
- Code lives on CDN/GitHub
- Two separate deployments
- Browser fetches from both locations

---

## 🎯 What You Need to Know

1. **Content Package** = Pages, text, structure
   - Deploy to: AEM Package Manager (traditional way)
   - Your dev: https://author-p50407-e477588.adobeaemcloud.com/crx/packmgr/index.jsp

2. **Blocks Code** = JavaScript, CSS, styling
   - Deploy to: GitHub Pages (new way)
   - Your blocks: https://varadkx1-abbvie.github.io/eds-blocks-new/

3. **Configuration** = Connecting them together
   - Needs: AEM admin / Cloud Manager access
   - Purpose: Tell AEM where blocks code lives

---

## 🚀 Start Here

**For today:** Just do Step 1 (deploy content package)

**Result:** Pages will be visible in AEM, ready for demo

**For full EDS:** Add Steps 2 & 3 when ready

---

## 📞 Need Help?

**Stuck on Step 1 (Content Package):**
- See: CREATE-PACKAGE-INSTRUCTIONS.md
- This is just like traditional AEM packages

**Confused about Step 2 (GitHub):**
- See: DEPLOY-BLOCKS-TO-GITHUB.md
- Or see: EDS-VS-TRADITIONAL-AEM.md for architecture explanation

**Need Step 3 (Configuration):**
- Talk to your AEM Cloud Manager admin
- They need to enable EDS on your instance

---

**Bottom Line:** Deploy content first (Step 1). That's enough for a basic demo!

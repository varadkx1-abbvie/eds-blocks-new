# How to Make EDS Blocks Work on Dev Instance

Your dev instance: `https://author-p50407-e477588.adobeaemcloud.com`

---

## 🎯 The 4 Things You Need

To make EDS blocks work on dev, you need ALL 4 of these:

1. ✅ **Blocks code on GitHub Pages** (done!)
2. ⏳ **Content package on dev AEM** (you need to do this)
3. ⏳ **EDS runtime enabled on dev** (platform team needs to do this)
4. ⏳ **Configuration connecting blocks to content** (you need to do this)

---

## Step-by-Step Guide

### Step 1: Push Blocks Code to GitHub (Do This First!)

```bash
cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new
git push origin main
```

**Verify it worked:**
- Go to: https://github.com/varadkx1-abbvie/eds-blocks-new
- Check GitHub Pages is enabled: Settings → Pages
- Test blocks are accessible:
  ```
  https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.js
  ```

**Status after this step:** ✅ Blocks code is publicly accessible

---

### Step 2: Create Content Package from Local AEM

#### 2a. Open Package Manager on Local

```
http://localhost:4502/crx/packmgr/index.jsp
```

#### 2b. Create New Package

Click **"Create Package"**

Fill in:
- **Group:** `allergan-aesthetics`
- **Package Name:** `allergan-aesthetics-eds-blocks`
- **Version:** `1.0.0`
- **Description:** `Allergan Aesthetics EDS blocks content - nav, footer, and test pages`

Click **OK**

#### 2c. Add Filters

1. Find your package in the list
2. Click **"Edit"**
3. Go to **"Filters"** tab
4. Click **"Add filter"**
5. Enter Root Path: `/content/allergan-aesthetics`
6. Click **"Done"**
7. Click **"Save"**

#### 2d. Build Package

1. Back in package list, find your package
2. Click **"Build"**
3. Wait for "Success" message
4. Check size (should be 20-50KB with test pages)

#### 2e. Download Package

1. Click **"Download"**
2. Save to your Desktop
3. File: `allergan-aesthetics-eds-blocks-1.0.0.zip`

**Status after this step:** ✅ Content package ready to deploy

---

### Step 3: Upload Content Package to Dev

#### 3a. Open Package Manager on Dev

```
https://author-p50407-e477588.adobeaemcloud.com/crx/packmgr/index.jsp
```

Login with your credentials.

#### 3b. Upload Package

1. Click **"Upload Package"**
2. Select `allergan-aesthetics-eds-blocks-1.0.0.zip` from Desktop
3. Click **"Upload"**
4. Wait for upload to complete

#### 3c. Install Package

1. Find the package in the list (scroll down)
2. Click **"Install"** button
3. In the dialog:
   - Check "Force Upload" if needed
   - Click **"Install"**
4. Wait for "Package installed" message

#### 3d. Verify Installation

Open Sites Console:
```
https://author-p50407-e477588.adobeaemcloud.com/sites.html/content/allergan-aesthetics
```

**You should see:**
- nav page
- footer page
- home page
- test folder with 7 test pages
- products folder

**Status after this step:** ✅ Content is on dev

---

### Step 4: Check if EDS Runtime is Enabled (Critical!)

This is the KEY step that determines if your blocks will work.

#### Test if EDS/Franklin is enabled:

```
https://author-p50407-e477588.adobeaemcloud.com/bin/franklin.delivery/allergan-aesthetics/allergan-aesthetics/main/content/allergan-aesthetics/nav.json
```

**If you see JSON:** ✅ EDS is enabled!
```json
{
  ":type": "sheet",
  "data": [...]
}
```

**If you see 404 or error:** ❌ EDS is NOT enabled
```
404 Not Found
or
Service not available
```

---

## 🔧 If EDS Runtime is NOT Enabled (Most Likely)

You need your **AEM Cloud Manager admin** to enable Edge Delivery Services.

### What to Tell Your Admin:

> "Hi, I need Edge Delivery Services (EDS/Franklin) enabled on our dev author instance `author-p50407-e477588`.
>
> Specifically, I need:
> 1. Franklin/EDS packages installed
> 2. Franklin Delivery API enabled at `/bin/franklin.delivery`
> 3. Ability to use EDS blocks with external block code from GitHub Pages
>
> The blocks code is already deployed at: https://varadkx1-abbvie.github.io/eds-blocks-new/
>
> This is for the Allergan Aesthetics EDS migration project."

### What They Need to Do:

1. **In Cloud Manager:**
   - Enable Edge Delivery Services for the environment
   - May require feature flag or product add-on

2. **Install EDS Packages:**
   - Franklin Core bundles
   - EDS runtime components
   - Universal Editor integration (optional)

3. **Configure EDS:**
   - Enable Franklin Delivery API servlet
   - Configure CORS for GitHub Pages
   - Set up service worker paths

**This typically takes 1-2 days for platform team.**

---

## 🚀 If EDS Runtime IS Enabled (Lucky!)

### Step 5: Configure Blocks Location

You need to tell dev where to find your blocks code.

#### Option A: Via Page Property (Simplest)

1. Open any page in Sites Console:
   ```
   https://author-p50407-e477588.adobeaemcloud.com/sites.html/content/allergan-aesthetics
   ```

2. Select `home` page

3. Open **Properties**

4. Go to **Cloud Services** tab

5. Add property:
   - **Name:** `codeBasePath` or `aem.live.url`
   - **Value:** `https://varadkx1-abbvie.github.io/eds-blocks-new`

6. Save

#### Option B: Via CRXDE (Alternative)

1. Open CRXDE:
   ```
   https://author-p50407-e477588.adobeaemcloud.com/crx/de/index.jsp
   ```

2. Navigate to: `/conf/allergan-aesthetics/settings/cloudconfigs/aem-boilerplate`

3. Create node if doesn't exist:
   - Type: `nt:unstructured`

4. Add property:
   - Name: `codeBasePath`
   - Type: String
   - Value: `https://varadkx1-abbvie.github.io/eds-blocks-new`

5. Save All

#### Option C: Via fstab.yaml (Best Practice)

Your fstab.yaml already points to dev:
```yaml
mountpoints:
  /:
    url: "https://author-p50407-e477588.adobeaemcloud.com/bin/franklin.delivery/..."
    type: "markup"
```

This should work automatically once EDS is enabled.

---

## ✅ Step 6: Test Your Blocks!

### Test Page URLs:

**Test pages:**
```
https://author-p50407-e477588.adobeaemcloud.com/content/allergan-aesthetics/test/test-hero.html
```

### What to Check:

1. **Open test page in browser**
2. **Open Developer Tools** (F12)
3. **Check Console** for errors
4. **Check Network tab**:
   - Look for requests to GitHub Pages
   - Should see: `hero.js`, `hero.css` loading
5. **Check if blocks render**:
   - Hero should show title and button
   - Columns should show side-by-side
   - Cards should show in grid

### Troubleshooting:

**If blocks don't load:**
- Check browser console for errors
- Verify GitHub Pages URLs are accessible
- Check CORS headers (should be OK with GitHub Pages)
- Verify EDS runtime is actually enabled

**If pages are empty:**
- Check Franklin Delivery API is working
- Verify content package installed correctly
- Check browser network tab for failed requests

---

## 📊 Architecture Diagram

```
┌─────────────────────────────────────────────────────────┐
│                       Browser                           │
└───────┬─────────────────────────────────┬───────────────┘
        │                                 │
        │ (1) Request page                │ (3) Request blocks JS/CSS
        │                                 │
        ↓                                 ↓
┌─────────────────────┐          ┌─────────────────────────┐
│   Dev AEM Author    │          │   GitHub Pages          │
│   author-p50407...  │          │   varadkx1-abbvie.github│
│                     │          │   .io/eds-blocks-new/   │
│  /content/          │          │                         │
│    allergan-        │          │   /blocks/              │
│    aesthetics/      │          │     hero/hero.js        │
│      nav            │          │     hero/hero.css       │
│      footer         │          │     columns/...         │
│      home           │          │     cards/...           │
│      test/...       │          │   /scripts/aem.js       │
│                     │          │   /styles/styles.css    │
│  Franklin API:      │          │                         │
│  /bin/franklin.     │          └─────────────────────────┘
│  delivery/          │                    │
└─────────────────────┘                    │
        │                                  │
        │ (2) Returns content (JSON)       │ (4) Returns files
        │                                  │
        └──────────────┬───────────────────┘
                       │
                       ↓
              (5) EDS decorates blocks
              (6) User sees styled page
```

---

## 🎯 Quick Status Check

Use this to figure out what's working:

| Test | Command | Expected Result | What It Means |
|------|---------|-----------------|---------------|
| **GitHub Pages** | Open `https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.js` | See JavaScript code | ✅ Blocks code is accessible |
| **Content on Dev** | Open `https://author-p50407-e477588.adobeaemcloud.com/sites.html/content/allergan-aesthetics` | See page list | ✅ Content is deployed |
| **Franklin API** | Open `https://author-p50407-e477588.adobeaemcloud.com/bin/franklin.delivery/.../nav.json` | See JSON | ✅ EDS runtime is enabled |
| **Page Renders** | Open `https://author-p50407-e477588.adobeaemcloud.com/content/allergan-aesthetics/test/test-hero.html` | See styled hero | ✅ Everything works! |

---

## 🔍 Common Scenarios

### Scenario 1: Everything Works Immediately ✅
- EDS runtime is already enabled
- Content package installs fine
- Blocks load from GitHub
- Pages render perfectly
- **Action:** Celebrate! Start creating content.

### Scenario 2: EDS Not Enabled ⏳ (Most Common)
- Content package installs fine
- Pages are empty
- Franklin API returns 404
- **Action:** Contact platform team to enable EDS

### Scenario 3: CORS Issues ⚠️
- EDS is enabled
- Content is deployed
- Browser blocks GitHub requests (CORS error)
- **Action:** Admin needs to configure CORS for GitHub Pages

### Scenario 4: Configuration Missing ⚠️
- EDS is enabled
- Content is deployed
- Blocks don't load (wrong URL)
- **Action:** Configure codeBasePath property

---

## 📞 Who to Contact

### If Pages Don't Render at All:
**AEM Cloud Manager Admin**
- Need: Enable Edge Delivery Services
- Timeline: 1-2 days typically

### If CORS Errors:
**DevOps/Platform Team**
- Need: Configure CORS headers
- Timeline: Few hours

### If Configuration Issues:
**AEM Developer/Architect**
- Need: Set up EDS configuration
- Timeline: 1 hour

---

## ✅ Success Criteria

You'll know it's working when:
1. ✅ Open test hero page
2. ✅ See styled hero section with title
3. ✅ Button is styled properly
4. ✅ Browser console has no errors
5. ✅ Network tab shows JS/CSS loading from GitHub

---

## 🚀 Next Steps After It Works

Once blocks are rendering on dev:

1. **Create production content** (homepage, product pages)
2. **Test all blocks** with real content
3. **Get stakeholder approval**
4. **Create package for UAT**
5. **Deploy to production**

---

## 📋 Deployment Checklist

- [ ] Push code to GitHub
- [ ] Verify GitHub Pages is enabled
- [ ] Test blocks JS files are accessible
- [ ] Create content package from local
- [ ] Upload package to dev
- [ ] Install package on dev
- [ ] Verify content in Sites Console
- [ ] Check if Franklin API is enabled
- [ ] If not, request EDS enablement from admin
- [ ] Once enabled, test page rendering
- [ ] Verify blocks load from GitHub
- [ ] Check all 7 test pages work
- [ ] Demo to stakeholders

---

## 💡 Pro Tips

1. **Test locally first** with `aem up` command (if possible)
2. **Use test pages** to verify each block works
3. **Check browser console** religiously
4. **Document any issues** for platform team
5. **Be patient** - EDS enablement takes time
6. **Have fallback plan** - can show static demo if needed

---

## 🎯 Bottom Line

**You can do Steps 1-3 right now** (push code, create package, deploy to dev)

**Step 4 requires platform team** (enable EDS runtime)

**Once Step 4 is done, everything should just work!**

---

**Need help with any specific step? Let me know!**

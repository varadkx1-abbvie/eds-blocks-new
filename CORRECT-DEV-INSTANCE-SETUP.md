# Setup Guide for Correct Dev Instance

## ✅ Great News: EDS is Already Working!

**Your correct dev instance:** `https://author-p48761-e275513.adobeaemcloud.com`

**EDS is already enabled!** You can see working blocks at:
```
https://author-p48761-e275513.adobeaemcloud.com/ui#/aem/sites.html/content/eds-common-blocks
```

---

## 🎯 What I Updated

### 1. fstab.yaml
**Changed from:**
```yaml
url: "https://author-p50407-e477588.adobeaemcloud.com/..."
```

**Changed to:**
```yaml
url: "https://author-p48761-e275513.adobeaemcloud.com/..."
```

---

## 🔍 Learn from Existing Working Blocks

Since EDS is already working on this instance, let's understand the setup:

### Step 1: Inspect Existing Working Blocks

1. **Open Sites Console:**
   ```
   https://author-p48761-e275513.adobeaemcloud.com/sites.html/content/eds-common-blocks
   ```

2. **Look at:**
   - How pages are structured
   - How nav/footer are configured
   - What blocks exist
   - How they're authored

3. **Open CRXDE:**
   ```
   https://author-p48761-e275513.adobeaemcloud.com/crx/de/index.jsp
   ```

4. **Navigate to:**
   ```
   /content/eds-common-blocks
   ```

5. **Check:**
   - How blocks are stored in JCR
   - What properties are set
   - How nav/footer are referenced

---

## 🔧 How the Working EDS is Configured

### Find the Blocks Code Location

The existing EDS blocks must be loading from somewhere. Let's find out:

#### Check 1: Page Properties

1. Open any working page in `eds-common-blocks`
2. Right-click → Properties
3. Look for:
   - `codeBasePath`
   - `aem.live.url`
   - Any cloud service configurations

#### Check 2: CRXDE Configuration

1. Open CRXDE
2. Navigate to: `/conf/eds-common-blocks/settings/cloudconfigs`
3. Look for EDS/Franklin configuration
4. Note the `codeBasePath` value

#### Check 3: View Page Source

1. Open a working EDS page
2. View page source (Ctrl+U)
3. Look for `<script>` tags loading from external URL
4. That's where blocks code is hosted

---

## 🎯 What You Need to Do for Allergan Aesthetics

### Step 1: Verify Your Content is Installed

**Open Sites Console:**
```
https://author-p48761-e275513.adobeaemcloud.com/sites.html/content/allergan-aesthetics
```

**You should see:**
- nav
- footer
- home
- test folder
- products folder

**If you see them:** ✅ Content is installed correctly!

**If you don't see them:**
- Re-upload the content package
- Make sure you installed (not just uploaded)

---

### Step 2: Copy Configuration from Working EDS

#### Option A: Copy via Page Properties

1. **Open working EDS page:**
   ```
   https://author-p48761-e275513.adobeaemcloud.com/sites.html/content/eds-common-blocks
   ```

2. **Select a page → Properties**

3. **Note all cloud service configurations**

4. **Open your Allergan page:**
   ```
   https://author-p48761-e275513.adobeaemcloud.com/sites.html/content/allergan-aesthetics
   ```

5. **Select home page → Properties**

6. **Apply same configurations**

#### Option B: Copy via CRXDE

1. **Open CRXDE:**
   ```
   https://author-p48761-e275513.adobeaemcloud.com/crx/de/index.jsp
   ```

2. **Copy configuration from:**
   ```
   /conf/eds-common-blocks/settings/cloudconfigs
   ```

3. **To:**
   ```
   /conf/allergan-aesthetics/settings/cloudconfigs
   ```

4. **Update `codeBasePath` to:**
   ```
   https://varadkx1-abbvie.github.io/eds-blocks-new
   ```

---

### Step 3: Test Your Allergan Aesthetics Blocks

#### Test Franklin Delivery API

```
https://author-p48761-e275513.adobeaemcloud.com/bin/franklin.delivery/allergan-aesthetics/allergan-aesthetics/main/content/allergan-aesthetics/nav.json
```

**Expected:** JSON data (not 404)

**If you get JSON:** ✅ Franklin API is working!

**If you get 404:** Check the path format by comparing with working eds-common-blocks URL

#### Test Hero Block Page

```
https://author-p48761-e275513.adobeaemcloud.com/content/allergan-aesthetics/test/test-hero.html
```

**What to check:**
1. **Open page in browser**
2. **Open Developer Tools (F12)**
3. **Check Console** for errors
4. **Check Network tab:**
   - Look for requests to `varadkx1-abbvie.github.io`
   - Should see `hero.js`, `hero.css`, `aem.js` loading
5. **Check if hero renders** with styling

**If blocks render:** 🎉 SUCCESS! Everything is working!

**If blocks don't render:** See troubleshooting below

---

## 🔍 Troubleshooting Steps

### Issue 1: Blocks Don't Load from GitHub

**Symptoms:**
- Pages are empty
- No requests to GitHub in Network tab
- No errors in console

**Cause:** Configuration not pointing to GitHub blocks

**Solution:**
1. Check `codeBasePath` is set correctly
2. Verify it points to: `https://varadkx1-abbvie.github.io/eds-blocks-new`
3. Copy configuration from working `eds-common-blocks`

---

### Issue 2: CORS Errors

**Symptoms:**
- Console shows: "blocked by CORS policy"
- Requests to GitHub fail

**Cause:** CORS not configured for your GitHub URL

**Solution:**
1. Contact admin to add GitHub URL to CORS whitelist
2. Or check if there's a CORS configuration you can copy from `eds-common-blocks`

---

### Issue 3: Franklin API 404

**Symptoms:**
- `/bin/franklin.delivery/...` returns 404

**Cause:** Wrong path format or project name

**Solution:**
1. Check working EDS URL format:
   ```
   /bin/franklin.delivery/[project]/[repo]/[branch]/content/...
   ```
2. Compare with your URL
3. Adjust to match pattern

---

## 📋 Complete Setup Checklist

### Phase 1: Configuration Discovery
- [ ] Open `eds-common-blocks` in Sites Console
- [ ] Check page properties for cloud configs
- [ ] Note `codeBasePath` or blocks URL
- [ ] Check CRXDE for `/conf/eds-common-blocks/settings`
- [ ] Document the configuration structure

### Phase 2: Apply to Allergan Aesthetics
- [ ] Verify Allergan content is in Sites Console
- [ ] Copy cloud service config from `eds-common-blocks`
- [ ] Update `codeBasePath` to GitHub URL
- [ ] Save configuration

### Phase 3: Testing
- [ ] Test Franklin Delivery API returns JSON
- [ ] Open test-hero.html page
- [ ] Check browser console (no errors)
- [ ] Check Network tab (blocks loading from GitHub)
- [ ] Verify hero block renders with styling
- [ ] Test all 7 test pages

### Phase 4: Production Content
- [ ] Create homepage with real content
- [ ] Create product pages
- [ ] Test all blocks work
- [ ] Get stakeholder approval

---

## 🎯 Quick Start Commands

### Push Updated Configuration
```bash
cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new
git add fstab.yaml
git commit -m "Update fstab to point to correct dev instance"
git push origin main
```

### Key URLs to Test

**Sites Console:**
```
https://author-p48761-e275513.adobeaemcloud.com/sites.html/content/allergan-aesthetics
```

**Test Page:**
```
https://author-p48761-e275513.adobeaemcloud.com/content/allergan-aesthetics/test/test-hero.html
```

**Franklin API:**
```
https://author-p48761-e275513.adobeaemcloud.com/bin/franklin.delivery/allergan-aesthetics/allergan-aesthetics/main/content/allergan-aesthetics/nav.json
```

**CRXDE:**
```
https://author-p48761-e275513.adobeaemcloud.com/crx/de/index.jsp
```

---

## 💡 Pro Tips

### 1. Compare Side-by-Side

Open two browser tabs:
- Tab 1: Working `eds-common-blocks` page
- Tab 2: Your `allergan-aesthetics` page

Compare:
- Network requests
- Console logs
- Loaded files
- Configuration

### 2. Use Browser DevTools

**Network Tab Checklist:**
- ✅ `aem.js` loads from GitHub
- ✅ `scripts.js` loads from GitHub
- ✅ `hero.js` loads from GitHub
- ✅ `hero.css` loads from GitHub
- ✅ `styles.css` loads from GitHub
- ✅ All return 200 (not 404)

### 3. Check Service Worker

EDS uses service workers. Check:
```javascript
// In browser console
navigator.serviceWorker.getRegistrations().then(r => console.log(r));
```

Should show registered service worker.

---

## 🚀 Expected Timeline

**If EDS is already configured:**
- Copy config: 15 minutes
- Test: 10 minutes
- Fix issues: 30 minutes
- **Total: ~1 hour**

**If config needs admin setup:**
- Request access: 1 day
- Configure: 2 hours
- Test: 30 minutes
- **Total: 1-2 days**

---

## ✅ Success Criteria

You'll know everything is working when:

1. ✅ Can see Allergan content in Sites Console
2. ✅ Franklin API returns JSON (not 404)
3. ✅ Test pages load without errors
4. ✅ Browser Network shows blocks loading from GitHub
5. ✅ Hero block renders with title and button styled
6. ✅ All 7 test pages render correctly
7. ✅ Can author new content with blocks

---

## 📞 Next Steps

1. **Verify content is installed** (check Sites Console)
2. **Find working EDS configuration** (from eds-common-blocks)
3. **Copy configuration** to allergan-aesthetics
4. **Test test-hero.html page**
5. **Report results** - what works, what doesn't
6. **Iterate** until all blocks render

---

**The fact that EDS is already working on this instance is GREAT NEWS!** You just need to copy the configuration and point it to your GitHub blocks.

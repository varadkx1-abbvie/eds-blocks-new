# GitHub Settings Checklist for EDS Blocks

## ✅ Good News: GitHub Pages is Already Working!

I tested your blocks URL and got HTTP 200 ✅
```
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.js
```

But let me give you a complete checklist to verify everything.

---

## 🔧 Required GitHub Settings

### 1. GitHub Pages (CRITICAL)

**Go to:** https://github.com/varadkx1-abbvie/eds-blocks-new/settings/pages

**Verify these settings:**

| Setting | Required Value | Status |
|---------|----------------|--------|
| **Source** | Deploy from a branch | ✅ Should be set |
| **Branch** | `main` | ✅ Should be set |
| **Folder** | `/ (root)` | ✅ Should be set |

**How to check:**
1. Go to repo: https://github.com/varadkx1-abbvie/eds-blocks-new
2. Click **Settings** tab (top right)
3. Click **Pages** (left sidebar)
4. Look at the configuration

**What you should see:**
```
✅ Your site is live at https://varadkx1-abbvie.github.io/eds-blocks-new/
```

**If you see a different message:**
- "GitHub Pages is currently disabled" → Enable it (see instructions below)
- "Your site is ready to be published" → Wait 2-3 minutes
- No Pages option at all → Check repository visibility (see below)

---

### 2. Repository Visibility

**Go to:** https://github.com/varadkx1-abbvie/eds-blocks-new/settings

**Check:** General → Danger Zone → Change repository visibility

**Required:** Repository must be **Public** OR you need GitHub Pro/Team/Enterprise

| Your Plan | Public Repo | Private Repo |
|-----------|-------------|--------------|
| GitHub Free | ✅ GitHub Pages works | ❌ GitHub Pages disabled |
| GitHub Pro | ✅ Works | ✅ Works |
| GitHub Team | ✅ Works | ✅ Works |
| GitHub Enterprise | ✅ Works | ✅ Works |

**If your repo is private and you have Free plan:**
- **Option A:** Make repo public (easiest)
- **Option B:** Upgrade to GitHub Pro ($4/month)
- **Option C:** Deploy blocks to different host (S3, Azure, etc.)

**To make repo public:**
1. Go to Settings → General
2. Scroll to "Danger Zone"
3. Click "Change repository visibility"
4. Select "Public"
5. Type repo name to confirm
6. Click "I understand, change repository visibility"

---

### 3. Branch Protection (Optional but Recommended)

**Go to:** https://github.com/varadkx1-abbvie/eds-blocks-new/settings/branches

**Recommended rules for `main` branch:**
- ✅ Require pull request reviews (prevents accidental breaks)
- ✅ Require status checks to pass (if you have CI/CD)
- ⚠️ Don't enable "Require linear history" (makes pushing harder)

**For now:** This is optional, can configure later

---

### 4. Actions Permissions (If Using GitHub Actions)

**Go to:** https://github.com/varadkx1-abbvie/eds-blocks-new/settings/actions

**If you want auto-deployment:**
- Allow all actions (recommended)
- Enable read and write permissions for workflows

**For now:** Not critical, GitHub Pages works without Actions

---

## 🧪 Test Your GitHub Pages Setup

### Test 1: Homepage
```
https://varadkx1-abbvie.github.io/eds-blocks-new/
```
**Expected:** See your README or index.html

### Test 2: Block JavaScript
```
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.js
```
**Expected:** See JavaScript code (starts with `import { createOptimizedPicture...`)

### Test 3: Block CSS
```
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.css
```
**Expected:** See CSS code (starts with `/* Hero Block...`)

### Test 4: Core Scripts
```
https://varadkx1-abbvie.github.io/eds-blocks-new/scripts/aem.js
```
**Expected:** See JavaScript code

### Test 5: Styles
```
https://varadkx1-abbvie.github.io/eds-blocks-new/styles/styles.css
```
**Expected:** See CSS code

### Test 6: Configuration
```
https://varadkx1-abbvie.github.io/eds-blocks-new/fstab.yaml
```
**Expected:** See YAML configuration

---

## ✅ Run These Tests Now

Open each URL in your browser and verify you see content (not 404):

```bash
# Copy/paste these into your browser one by one:

https://varadkx1-abbvie.github.io/eds-blocks-new/
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.js
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.css
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/columns/columns.js
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/cards/cards.js
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/accordion/accordion.js
https://varadkx1-abbvie.github.io/eds-blocks-new/scripts/aem.js
https://varadkx1-abbvie.github.io/eds-blocks-new/styles/styles.css
https://varadkx1-abbvie.github.io/eds-blocks-new/fstab.yaml
```

**All should return code, not 404!**

---

## 🔧 How to Enable GitHub Pages (If Not Already Enabled)

### Step-by-Step:

1. **Go to your repository:**
   ```
   https://github.com/varadkx1-abbvie/eds-blocks-new
   ```

2. **Click Settings tab** (top navigation)

3. **Click Pages** (left sidebar, under "Code and automation")

4. **Under "Build and deployment":**
   - **Source:** Select "Deploy from a branch"
   - **Branch:** Select `main`
   - **Folder:** Select `/ (root)`
   - Click **Save**

5. **Wait 2-3 minutes** for deployment

6. **Refresh the page** - you should see:
   ```
   ✅ Your site is live at https://varadkx1-abbvie.github.io/eds-blocks-new/
   ```

7. **Test the URL** - click the link to verify

---

## ⚠️ Common Issues

### Issue 1: "GitHub Pages is unavailable"
**Cause:** Repository is private and you have GitHub Free plan

**Solution:**
- Make repository public, OR
- Upgrade to GitHub Pro

---

### Issue 2: 404 on Pages URL
**Cause:** GitHub Pages not deployed yet or wrong branch

**Solutions:**
1. Wait 2-3 minutes after enabling
2. Verify branch is `main` (not `master`)
3. Check you have files in the root (README.md, blocks/, etc.)
4. Trigger rebuild by making a small change and pushing

---

### Issue 3: Old content showing
**Cause:** GitHub Pages cache

**Solutions:**
1. Wait 5-10 minutes for cache to clear
2. Force refresh in browser (Ctrl+Shift+R / Cmd+Shift+R)
3. Open in incognito/private window

---

### Issue 4: Some files work, others don't
**Cause:** File path case sensitivity

**Solutions:**
- Check file names match exactly (case-sensitive!)
- Verify folders exist in repository
- Re-push if needed

---

## 🔒 CORS Headers (Automatic with GitHub Pages)

Good news! GitHub Pages automatically serves files with proper CORS headers:

```
Access-Control-Allow-Origin: *
```

This means your dev AEM instance CAN load blocks from GitHub Pages once EDS is enabled.

**No additional configuration needed!**

---

## 📊 Verify Everything is Working

### Quick Check Script

Open your browser console (F12) and paste this:

```javascript
// Test if all critical files are accessible
const baseUrl = 'https://varadkx1-abbvie.github.io/eds-blocks-new';
const files = [
  '/blocks/hero/hero.js',
  '/blocks/hero/hero.css',
  '/blocks/columns/columns.js',
  '/blocks/cards/cards.js',
  '/blocks/accordion/accordion.js',
  '/scripts/aem.js',
  '/styles/styles.css'
];

Promise.all(
  files.map(file =>
    fetch(baseUrl + file)
      .then(r => ({ file, status: r.status, ok: r.ok }))
  )
).then(results => {
  console.table(results);
  const allOk = results.every(r => r.ok);
  console.log(allOk ? '✅ All files accessible!' : '❌ Some files missing');
});
```

**Expected output:**
```
✅ All files accessible!
```

---

## 🎯 What You Need Right Now

### Minimum Required Settings:
1. ✅ **GitHub Pages enabled** - Check at `/settings/pages`
2. ✅ **Source: Deploy from branch**
3. ✅ **Branch: main**
4. ✅ **Folder: / (root)**

### Nice to Have (Optional):
- Branch protection rules
- GitHub Actions (for auto-testing)
- Custom domain (for production)

---

## ✅ Final Verification

**Run this checklist:**

- [ ] GitHub Pages shows "Your site is live at..."
- [ ] Can access homepage: https://varadkx1-abbvie.github.io/eds-blocks-new/
- [ ] Can access hero.js: .../blocks/hero/hero.js
- [ ] Can access aem.js: .../scripts/aem.js
- [ ] Can access styles.css: .../styles/styles.css
- [ ] All files return 200 (not 404)
- [ ] Browser console test script passes

**If all checked:** ✅ Your GitHub setup is perfect!

**If any fail:** See troubleshooting section above

---

## 🚀 Next Steps After Verification

Once GitHub Pages is confirmed working:

1. ✅ **Test all block URLs** (done above)
2. ⏳ **Wait for EDS to be enabled on dev** (admin task)
3. ⏳ **Test blocks on dev** (once EDS is enabled)
4. ⏳ **Create production content** (once testing passes)

---

## 📞 Need Help?

**If GitHub Pages won't enable:**
- Check if repo is private (needs public or Pro plan)
- Verify you have admin access to repo
- Contact GitHub support if issues persist

**If files return 404:**
- Verify files exist in repo: https://github.com/varadkx1-abbvie/eds-blocks-new
- Check file paths are correct (case-sensitive!)
- Wait a few minutes and try again

**If old content shows:**
- Clear browser cache
- Try incognito window
- Wait for GitHub cache to expire (5-10 min)

---

**Your GitHub setup is likely already correct since I got HTTP 200 on the blocks!** Just verify the checklist above to be sure.

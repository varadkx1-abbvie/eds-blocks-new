# Deploy Blocks Code to GitHub Pages

## Why GitHub Pages?

- Free hosting
- No server setup required
- Automatic HTTPS
- Easy to update (just git push)
- Works perfectly for EDS blocks code

---

## Step 1: Push Code to GitHub

Your code is already in this repo, so let's make sure it's up to date:

```bash
cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new

# Check current remote
git remote -v

# Add all files
git add .

# Commit
git commit -m "Add Allergan Aesthetics EDS blocks and content"

# Push to GitHub
git push origin main
```

If you get SSH authentication issues, use:
```bash
ssh-add ~/.ssh/id_rsa
# Enter passphrase when prompted
git push origin main
```

---

## Step 2: Enable GitHub Pages

1. Go to your GitHub repository:
   ```
   https://github.com/varadkx1-abbvie/eds-blocks-new
   ```

2. Click **Settings** (top right)

3. Scroll down to **Pages** section (left sidebar)

4. Under "Source":
   - Select: **Deploy from a branch**
   - Branch: **main**
   - Folder: **/ (root)**

5. Click **Save**

6. Wait 1-2 minutes for deployment

7. Your blocks will be available at:
   ```
   https://varadkx1-abbvie.github.io/eds-blocks-new/
   ```

---

## Step 3: Test Blocks Are Accessible

Try accessing a block file:

```
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.js
https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/accordion/accordion.js
https://varadkx1-abbvie.github.io/eds-blocks-new/styles/styles.css
```

You should see the JavaScript/CSS code, not a 404.

---

## Step 4: Configure Dev AEM to Use GitHub Blocks

Now you need to tell your dev AEM instance where to find the blocks code.

### Option A: Using AEM Configuration (Recommended)

1. **Create/Update fstab.yaml in your content:**

   In AEM, you need to configure where EDS should look for blocks. This is typically done via OSGi configuration or by setting properties.

   For now, the simplest approach is to configure this in your Universal Editor or EDS configuration on the dev instance.

2. **Or manually configure via CRXDE:**

   ```
   https://your-dev-instance.adobeaemcloud.com/crx/de/index.jsp
   ```

   Navigate to: `/content/allergan-aesthetics/home/jcr:content`

   Add property:
   - Name: `cq:conf`
   - Type: String
   - Value: `/conf/allergan-aesthetics`

   Then create configuration at: `/conf/allergan-aesthetics/settings/cloudconfigs/aem-boilerplate`

   Add property:
   - Name: `codeBasePath`
   - Type: String
   - Value: `https://varadkx1-abbvie.github.io/eds-blocks-new`

### Option B: Update fstab.yaml in Your Repo (Easier)

Update the fstab.yaml in your GitHub repo to point to the correct AEM instance:

```bash
cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new
```

Create/update `fstab.yaml`:

```yaml
mountpoints:
  /:
    url: "https://your-dev-author.adobeaemcloud.com/bin/franklin.delivery/allergan-aesthetics/allergan-aesthetics/main"
    type: "markup"
    suffix: ".html"
```

Replace `your-dev-author.adobeaemcloud.com` with your actual dev instance URL.

Then:
```bash
git add fstab.yaml
git commit -m "Update fstab for dev instance"
git push origin main
```

---

## Step 5: Test Full EDS Experience

### Test via EDS Preview URL

```
https://main--eds-blocks-new--varadkx1-abbvie.aem.page/?path=/content/allergan-aesthetics/home
```

Or test directly on your dev instance (if properly configured):

```
https://your-dev-instance.adobeaemcloud.com/content/allergan-aesthetics/home.html?wcmmode=disabled
```

The blocks should now be styled and interactive!

---

## Alternative: Extract and Deploy to Your Own Server

If you have access to a web server on your dev environment:

### Step 1: Extract the tar.gz

```bash
# On your local machine
cd ~/Desktop
mkdir allergan-blocks-code
cd allergan-blocks-code
tar -xzf ../allergan-aesthetics-blocks-code.tar.gz

# Now you have all the files extracted
ls -la
```

### Step 2: Upload to Your Web Server

```bash
# Option 1: SCP to server
scp -r * user@your-dev-server:/var/www/html/allergan-blocks/

# Option 2: Use your deployment tool
# Deploy contents to your web server/CDN
```

### Step 3: Update Configuration

Point your AEM dev instance to:
```
https://your-dev-server.com/allergan-blocks/
```

---

## What's Inside the tar.gz?

```
blocks/                 → All block components (JS + CSS)
  hero/
  accordion/
  brand-grid/
  image-text/
  banner/
  cards/
  video-embed/
  ...
scripts/                → Core EDS scripts
  aem.js               → AEM integration
  scripts.js           → Page initialization
styles/                 → Global styles
  styles.css           → Main stylesheet
  tokens.css           → Design system tokens
icons/                  → SVG icons
fonts/                  → Web fonts
component-definition.json → Block metadata
component-filters.json
component-models.json
fstab.yaml             → Content source config
paths.json             → URL path mappings
helix-query.yaml       → Search indexing
helix-sitemap.yaml     → Sitemap generation
package.json           → Dependencies
head.html              → Common head content
404.html               → Error page
```

---

## Verification Checklist

After deployment, verify:

- [ ] GitHub Pages is enabled and deployed
- [ ] Can access: `https://varadkx1-abbvie.github.io/eds-blocks-new/blocks/hero/hero.js`
- [ ] Can access: `https://varadkx1-abbvie.github.io/eds-blocks-new/styles/styles.css`
- [ ] Dev AEM configured to use GitHub URL
- [ ] Test page loads with styling
- [ ] Accordion blocks expand/collapse
- [ ] Hero sections have proper styling
- [ ] Brand grid cards are interactive

---

## Quick Summary

**Content Package (ZIP)** → Install in AEM Package Manager
- Contains: Page content and structure
- Lives in: AEM repository

**Blocks Code (TAR.GZ)** → Deploy to Web Server/GitHub Pages
- Contains: JavaScript, CSS, styles
- Lives in: Web server (publicly accessible)

**Both needed for full EDS experience!**

---

## Need Help?

**Issue: GitHub Pages not working**
- Check Settings → Pages is enabled
- Wait 2-3 minutes after enabling
- Check repository is public (or has proper permissions)

**Issue: Blocks not loading**
- Check browser console for errors
- Verify blocks URL is accessible (test JS files directly)
- Check CORS headers (GitHub Pages handles this automatically)

**Issue: Styling not applied**
- Check styles.css is loading
- Verify block JavaScript is running (check console)
- Check network tab for 404s

---

**Ready to deploy?** Start with GitHub Pages - it's the easiest option!

# AEM Local Instance Setup Guide

## Prerequisites

1. **AEM 6.5 or AEM as a Cloud Service SDK** running locally
2. **AEM instance running** at `http://localhost:4502`
3. **Admin credentials**: admin/admin (or your configured credentials)
4. **Edge Delivery Services enabled** in your AEM instance

---

## Step 1: Configure AEM for Edge Delivery Services

### Install Required Packages

1. Open Package Manager: `http://localhost:4502/crx/packmgr/index.jsp`
2. Install the following packages (if not already installed):
   - AEM Edge Delivery Services Core Bundle
   - Franklin Delivery API

### Enable Franklin Delivery

1. Go to OSGi Configuration: `http://localhost:4502/system/console/configMgr`
2. Find "Franklin Delivery Servlet" configuration
3. Ensure it's enabled and configured

---

## Step 2: Create the Project Structure in AEM

### Via CRX/DE

1. Open CRX/DE: `http://localhost:4502/crx/de/index.jsp`
2. Login with admin/admin

3. Create the project structure:
   ```
   /content/allergan-aesthetics (cq:Page)
   ├── jcr:content (cq:PageContent)
   │   ├── sling:resourceType = "core/franklin/components/page/v1/page"
   │   └── cq:template = "/conf/allergan-aesthetics/settings/wcm/templates/page-template"
   ├── home (cq:Page)
   ├── products (cq:Page)
   │   └── botox-cosmetic (cq:Page)
   ├── about (cq:Page)
   └── providers (cq:Page)
   ```

### Via Sites Console (Recommended)

1. Open Sites Console: `http://localhost:4502/sites.html/content`
2. Click "Create" → "Site"
3. Enter details:
   - **Site Title**: Allergan Aesthetics
   - **Site Name**: allergan-aesthetics
   - **Template**: Select EDS/Franklin template

---

## Step 3: Import Sample Content

### Method 1: Using Package Manager

I'll create a content package that you can install.

### Method 2: Manual Import via Sites Console

1. Open Sites Console: `http://localhost:4502/sites.html/content`
2. Navigate to `/content/allergan-aesthetics`
3. Create pages manually and copy content from `sample-content/` directory

### Method 3: Using cURL (Automated)

Use the provided script to create pages automatically:

```bash
cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new
chmod +x create-aem-pages.sh
./create-aem-pages.sh
```

---

## Step 4: Configure fstab for Local Development

Your project now has two fstab configurations:

### For Cloud Development
`fstab.yaml` - Points to AEM Cloud instance

### For Local Development
`fstab-local.yaml` - Points to local AEM instance

**To use local AEM:**

1. Rename or backup current fstab:
   ```bash
   mv fstab.yaml fstab-cloud.yaml
   ```

2. Use local fstab:
   ```bash
   cp fstab-local.yaml fstab.yaml
   ```

3. Update paths.json:
   ```bash
   cp paths-local.json paths.json
   ```

---

## Step 5: Start Local Development

```bash
# Install AEM CLI if not already installed
npm install -g @adobe/aem-cli

# Start the local development server
aem up
```

This will start a proxy server at `http://localhost:3000` that:
- Serves your EDS blocks (JavaScript/CSS)
- Fetches content from your local AEM instance
- Enables hot-reload for block development

---

## Step 6: Create Content Package for Dev Instance

### Create Package in AEM

1. Open Package Manager: `http://localhost:4502/crx/packmgr/index.jsp`
2. Click "Create Package"
3. Enter package details:
   - **Package Name**: allergan-aesthetics-content
   - **Version**: 1.0.0
   - **Group**: allergan-aesthetics

4. Click "Edit" on the package
5. Go to "Filters" tab
6. Add filter:
   ```
   /content/allergan-aesthetics
   ```

7. Click "Done"
8. Click "Build" to create the package
9. Click "Download" to save the package

### Install on Dev Instance

1. Open Package Manager on dev instance
2. Click "Upload Package"
3. Select downloaded package
4. Click "Install"

---

## Step 7: Verify Setup

### Check Pages in AEM

1. Open Sites Console: `http://localhost:4502/sites.html/content/allergan-aesthetics`
2. Verify all pages are created
3. Open a page in Universal Editor

### Check Franklin Delivery

1. Open in browser: `http://localhost:4502/content/allergan-aesthetics/home.html`
2. Verify content renders correctly
3. Check Franklin JSON: `http://localhost:4502/bin/franklin.delivery/allergan-aesthetics/allergan-aesthetics/main/content/allergan-aesthetics/home.json`

### Check EDS Preview

1. Open: `http://localhost:3000`
2. Should show your home page with EDS blocks applied
3. Make changes to blocks and see them hot-reload

---

## Troubleshooting

### Issue: Franklin Delivery API not responding

**Solution:**
1. Check OSGi bundles: `http://localhost:4502/system/console/bundles`
2. Ensure "Franklin Delivery" bundles are active
3. Restart AEM if needed

### Issue: Content not showing in preview

**Solution:**
1. Verify fstab.yaml points to correct AEM instance
2. Check AEM credentials in environment
3. Verify page path in AEM matches fstab mapping

### Issue: Blocks not loading

**Solution:**
1. Check browser console for JavaScript errors
2. Verify block files exist in `blocks/` directory
3. Run `npm run build:json` to regenerate component models
4. Clear browser cache

### Issue: 403 Forbidden errors

**Solution:**
1. Check AEM permissions for anonymous/user
2. Configure CORS in AEM OSGi config
3. Add localhost:3000 to allowed origins

---

## Next Steps

1. ✅ Verify pages load in local AEM
2. ✅ Test with `aem up` to see EDS rendering
3. ✅ Populate with actual content and images
4. ✅ Customize blocks with brand-specific styling
5. ✅ Create content package for dev deployment
6. ✅ Test on dev instance
7. ✅ Prepare for UAT and production

---

## Useful Commands

```bash
# Start local dev server
aem up

# Build component models
npm run build:json

# Lint code
npm run lint

# Fix linting issues
npm run lint:fix

# Check AEM instance status
curl -u admin:admin http://localhost:4502/system/console/bundles.json

# Get page JSON from Franklin API
curl -u admin:admin "http://localhost:4502/bin/franklin.delivery/allergan-aesthetics/allergan-aesthetics/main/content/allergan-aesthetics/home.json"
```

---

## AEM API Endpoints

- **Sites Console**: http://localhost:4502/sites.html/content
- **CRX/DE**: http://localhost:4502/crx/de
- **Package Manager**: http://localhost:4502/crx/packmgr
- **OSGi Console**: http://localhost:4502/system/console
- **Franklin Delivery**: http://localhost:4502/bin/franklin.delivery/
- **Universal Editor**: http://localhost:4502/ui#/aem/editor.html/content/...

---

## Support

- AEM EDS Documentation: https://www.aem.live/docs/
- AEM Community: https://experienceleaguecommunities.adobe.com/
- GitHub Issues: Open issues in your repository

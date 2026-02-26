# Content Package Creation Guide

## Overview

This guide walks you through creating and deploying AEM content packages for the Allergan Aesthetics migration.

---

## Method 1: Using AEM Package Manager (Recommended)

### Step 1: Create Package

1. Open Package Manager:
   ```
   http://localhost:4502/crx/packmgr/index.jsp
   ```

2. Click **"Create Package"** button

3. Fill in package details:
   - **Package Name**: `allergan-aesthetics-content`
   - **Version**: `1.0.0`
   - **Group**: `allergan-aesthetics`
   - **Description**: `Allergan Aesthetics EDS content pages`

4. Click **"OK"**

### Step 2: Configure Package Filters

1. Find your package in the list
2. Click **"Edit"** button
3. Go to **"Filters"** tab
4. Click **"Add filter"**
5. Add the following filters:

   ```
   /content/allergan-aesthetics
   ```

   Optional additional filters:
   ```
   /content/dam/allergan-aesthetics
   /conf/allergan-aesthetics
   ```

6. Click **"Done"**

### Step 3: Build Package

1. Find your package in the list
2. Click **"Build"** button
3. Wait for build to complete (green checkmark)
4. Verify package size (should be > 0 bytes)

### Step 4: Download Package

1. Click **"Download"** button
2. Save to your local machine:
   ```
   /Users/varadkx1/Desktop/allergan-aesthetics-content-1.0.0.zip
   ```

### Step 5: Install on Dev Instance

1. Open Package Manager on **dev instance**:
   ```
   https://your-dev-instance.adobeaemcloud.com/crx/packmgr/index.jsp
   ```

2. Click **"Upload Package"**
3. Select downloaded `.zip` file
4. Click **"Upload"**
5. Find uploaded package in list
6. Click **"Install"**
7. Wait for installation to complete

### Step 6: Verify Installation

1. Open Sites Console on dev:
   ```
   https://your-dev-instance.adobeaemcloud.com/sites.html/content
   ```

2. Navigate to `/content/allergan-aesthetics`
3. Verify all pages are present
4. Open a page to verify content

---

## Method 2: Using VLT (Vault Tool)

### Prerequisites

Install VLT (Vault Tool):
```bash
npm install -g @adobe/aio-cli-plugin-aem-rde
```

Or download from: https://github.com/apache/jackrabbit-filevault

### Export Content

```bash
# Navigate to project directory
cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new

# Create vault directory
mkdir -p vault/jcr_root

# Export content from local AEM
vlt --credentials admin:admin export \
    http://localhost:4502/crx \
    /content/allergan-aesthetics \
    ./vault/jcr_root/content/allergan-aesthetics

# Create package definition
cat > vault/META-INF/vault/filter.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<workspaceFilter version="1.0">
    <filter root="/content/allergan-aesthetics"/>
</workspaceFilter>
EOF
```

### Import to Dev Instance

```bash
# Import to dev instance
vlt --credentials your-user:your-pass import \
    https://your-dev-instance.adobeaemcloud.com/crx \
    ./vault/jcr_root
```

---

## Method 3: Using cURL Script

### Create Automated Deployment Script

```bash
#!/bin/bash

SOURCE_AEM="http://localhost:4502"
TARGET_AEM="https://your-dev-instance.adobeaemcloud.com"
SOURCE_USER="admin:admin"
TARGET_USER="your-user:your-pass"
PACKAGE_PATH="/content/allergan-aesthetics"

# Build package on source
curl -u $SOURCE_USER -X POST \
    "$SOURCE_AEM/crx/packmgr/service/.json?cmd=build" \
    -F "package=/etc/packages/allergan-aesthetics/allergan-aesthetics-content-1.0.0.zip"

# Download package
curl -u $SOURCE_USER \
    "$SOURCE_AEM/etc/packages/allergan-aesthetics/allergan-aesthetics-content-1.0.0.zip" \
    -o package.zip

# Upload to target
curl -u $TARGET_USER -X POST \
    "$TARGET_AEM/crx/packmgr/service/.json" \
    -F "file=@package.zip" \
    -F "force=true"

# Install on target
curl -u $TARGET_USER -X POST \
    "$TARGET_AEM/crx/packmgr/service/.json?cmd=install" \
    -F "package=/etc/packages/allergan-aesthetics/allergan-aesthetics-content-1.0.0.zip"
```

---

## Package Structure

### Standard Content Package

```
allergan-aesthetics-content-1.0.0.zip
├── META-INF/
│   └── vault/
│       ├── filter.xml
│       ├── config.xml
│       └── properties.xml
└── jcr_root/
    └── content/
        └── allergan-aesthetics/
            ├── .content.xml
            ├── home/
            │   └── .content.xml
            ├── products/
            │   ├── .content.xml
            │   ├── botox-cosmetic/
            │   │   └── .content.xml
            │   └── juvederm/
            │       └── .content.xml
            ├── about/
            │   └── .content.xml
            └── providers/
                └── .content.xml
```

---

## Filter Configuration Examples

### Basic Content Only
```xml
<?xml version="1.0" encoding="UTF-8"?>
<workspaceFilter version="1.0">
    <filter root="/content/allergan-aesthetics"/>
</workspaceFilter>
```

### Content + Assets
```xml
<?xml version="1.0" encoding="UTF-8"?>
<workspaceFilter version="1.0">
    <filter root="/content/allergan-aesthetics"/>
    <filter root="/content/dam/allergan-aesthetics"/>
</workspaceFilter>
```

### Complete Package (Content + Config + Assets)
```xml
<?xml version="1.0" encoding="UTF-8"?>
<workspaceFilter version="1.0">
    <filter root="/content/allergan-aesthetics"/>
    <filter root="/content/dam/allergan-aesthetics"/>
    <filter root="/conf/allergan-aesthetics"/>
    <filter root="/content/experience-fragments/allergan-aesthetics"/>
</workspaceFilter>
```

---

## Deployment Checklist

### Before Deployment

- [ ] Test all pages locally with `aem up`
- [ ] Verify blocks render correctly
- [ ] Run `npm run lint` and fix issues
- [ ] Build component models: `npm run build:json`
- [ ] Review content for PHI/PII data
- [ ] Verify all images and assets are included
- [ ] Check for broken links
- [ ] Test responsive design (mobile, tablet, desktop)
- [ ] Verify accessibility (WCAG 2.1 AA)
- [ ] Review medical disclaimers and safety information

### During Deployment

- [ ] Backup dev instance before installation
- [ ] Install package on dev instance
- [ ] Clear dispatcher cache (if applicable)
- [ ] Clear browser cache
- [ ] Verify pages load correctly
- [ ] Test all interactive elements (accordions, videos, etc.)
- [ ] Check Universal Editor functionality
- [ ] Verify analytics tracking (if configured)

### After Deployment

- [ ] Smoke test all pages
- [ ] Check console for JavaScript errors
- [ ] Verify block loading and decoration
- [ ] Test form submissions (if applicable)
- [ ] Check external links (PDF downloads, etc.)
- [ ] Monitor RUM metrics
- [ ] Run Lighthouse audit
- [ ] Document any issues found
- [ ] Notify stakeholders of deployment

---

## Troubleshooting

### Issue: Package build fails

**Symptoms**: Build fails with error, package size is 0 bytes

**Solutions**:
1. Check filter paths are correct
2. Verify content exists at specified paths
3. Check AEM logs: `/crx-quickstart/logs/error.log`
4. Ensure you have write permissions

### Issue: Package installs but pages don't appear

**Symptoms**: Package installs successfully but pages missing in Sites Console

**Solutions**:
1. Check package filters include correct paths
2. Verify page nodes exist in CRX/DE: `/crx/de`
3. Clear repository cache: restart AEM
4. Check for permission issues
5. Review installation log in Package Manager

### Issue: Content appears but blocks don't render

**Symptoms**: Pages load but EDS blocks not applied

**Solutions**:
1. Verify `fstab.yaml` points to correct AEM instance
2. Check `paths.json` mappings are correct
3. Run `npm run build:json` to regenerate models
4. Verify Franklin Delivery API is enabled
5. Check browser console for errors
6. Clear browser and dispatcher cache

### Issue: 401/403 errors when accessing pages

**Symptoms**: Authentication or permission errors

**Solutions**:
1. Check AEM user permissions
2. Configure CORS settings in AEM OSGi
3. Add target domain to allowed origins
4. Verify authentication credentials
5. Check firewall/network settings

---

## Best Practices

### Version Control

- Use semantic versioning: `major.minor.patch`
- Increment version for each package build
- Include changelog in package description
- Tag releases in Git

### Package Organization

- **Content packages**: Page content only
- **Code packages**: OSGi bundles, clientlibs
- **Asset packages**: DAM assets separately
- Keep packages small (<50MB recommended)

### Testing Strategy

1. **Local**: Test on localhost:4502
2. **Dev**: Deploy to dev environment first
3. **QA/Staging**: Full UAT testing
4. **Production**: Final deployment with rollback plan

### Documentation

- Document package contents and purpose
- Include installation instructions
- Note dependencies and prerequisites
- Provide rollback procedures

---

## Quick Reference

### Package Manager Commands

```bash
# Build package
curl -u admin:admin -X POST \
  "http://localhost:4502/crx/packmgr/service/.json?cmd=build" \
  -F "package=/etc/packages/group/package-name-1.0.0.zip"

# Download package
curl -u admin:admin \
  "http://localhost:4502/etc/packages/group/package-name-1.0.0.zip" \
  -o package.zip

# Upload package
curl -u admin:admin -X POST \
  "http://localhost:4502/crx/packmgr/service/.json" \
  -F "file=@package.zip" \
  -F "force=true"

# Install package
curl -u admin:admin -X POST \
  "http://localhost:4502/crx/packmgr/service/.json?cmd=install" \
  -F "package=/etc/packages/group/package-name-1.0.0.zip"

# Uninstall package
curl -u admin:admin -X POST \
  "http://localhost:4502/crx/packmgr/service/.json?cmd=uninstall" \
  -F "package=/etc/packages/group/package-name-1.0.0.zip"

# Delete package
curl -u admin:admin -X POST \
  "http://localhost:4502/crx/packmgr/service/.json?cmd=delete" \
  -F "package=/etc/packages/group/package-name-1.0.0.zip"
```

---

## Next Steps

1. ✅ Create pages in local AEM using provided script
2. ✅ Add content from `sample-content/` directory
3. ✅ Test locally with `aem up`
4. ✅ Create content package
5. ✅ Deploy to dev instance
6. ✅ Conduct UAT testing
7. ✅ Prepare for production deployment

---

For additional help, refer to:
- AEM Package Manager Documentation
- Adobe Experience League
- Your AEM admin team

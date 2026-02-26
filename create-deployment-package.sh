#!/bin/bash

# Create complete deployment package for dev instance
# Includes content + configuration for EDS

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"

PACKAGE_GROUP="allergan-aesthetics"
PACKAGE_NAME="allergan-aesthetics-eds-complete"
PACKAGE_VERSION="1.0.0"

echo "=============================================="
echo "Creating Complete EDS Deployment Package"
echo "=============================================="
echo ""

# Step 1: Create content package via API
echo "Step 1: Creating package definition..."

curl -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/crx/packmgr/service/.json/etc/packages/$PACKAGE_GROUP/$PACKAGE_NAME-$PACKAGE_VERSION.zip" \
    -F "packageName=$PACKAGE_NAME" \
    -F "groupName=$PACKAGE_GROUP" \
    -F "version=$PACKAGE_VERSION" \
    -F "description=Complete Allergan Aesthetics EDS package including content and configuration"

echo ""
echo "✓ Package definition created"
echo ""

# Step 2: Add filters
echo "Step 2: Adding filters..."

# Add content filter
curl -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/crx/packmgr/update.jsp" \
    -F "packageName=$PACKAGE_NAME" \
    -F "groupName=$PACKAGE_GROUP" \
    -F "version=$PACKAGE_VERSION" \
    -F "filter=[{\"root\":\"/content/allergan-aesthetics\",\"rules\":[]}]" \
    -F "charset=utf-8"

echo "✓ Filters added"
echo ""

# Step 3: Build package
echo "Step 3: Building package..."

curl -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/crx/packmgr/service/.json/etc/packages/$PACKAGE_GROUP/$PACKAGE_NAME-$PACKAGE_VERSION.zip?cmd=build"

echo ""
echo "✓ Package built"
echo ""

# Step 4: Download package
echo "Step 4: Downloading package..."

DOWNLOAD_PATH="/Users/varadkx1/Desktop/${PACKAGE_NAME}-${PACKAGE_VERSION}.zip"

curl -u $AEM_USER:$AEM_PASS \
    "$AEM_HOST/etc/packages/$PACKAGE_GROUP/$PACKAGE_NAME-$PACKAGE_VERSION.zip" \
    -o "$DOWNLOAD_PATH"

echo "✓ Package downloaded to: $DOWNLOAD_PATH"
echo ""

# Step 5: Create Git bundle for blocks code
echo "Step 5: Creating blocks code bundle..."

cd /Users/varadkx1/Desktop/Kedar/Code/eds-blocks-new

# Create tar of blocks code
tar -czf "/Users/varadkx1/Desktop/allergan-aesthetics-blocks-code.tar.gz" \
    blocks/ \
    scripts/ \
    styles/ \
    icons/ \
    fonts/ \
    component-*.json \
    fstab*.yaml \
    paths*.json \
    head.html \
    helix-*.yaml \
    package.json \
    .eslintrc.cjs \
    .stylelintrc.json \
    *.md

echo "✓ Blocks code bundle created at: /Users/varadkx1/Desktop/allergan-aesthetics-blocks-code.tar.gz"
echo ""

echo "=============================================="
echo "✓ Deployment packages created!"
echo "=============================================="
echo ""
echo "📦 Files on your Desktop:"
echo ""
echo "1. Content Package (for AEM):"
echo "   $DOWNLOAD_PATH"
echo ""
echo "2. Blocks Code Bundle (for web server):"
echo "   /Users/varadkx1/Desktop/allergan-aesthetics-blocks-code.tar.gz"
echo ""
echo "Next steps:"
echo "1. Upload content package to dev AEM Package Manager"
echo "2. Deploy blocks code to your web server / CDN"
echo "3. Update fstab.yaml on dev to point to blocks location"
echo ""

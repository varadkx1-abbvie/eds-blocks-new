#!/bin/bash

# Migrate content from /content/aa-corporate to /content/allergan-aesthetics
# Converts AEM Core Components to EDS blocks

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"

SOURCE_PATH="/content/aa-corporate/us/en"
TARGET_PATH="/content/allergan-aesthetics"

echo "=========================================="
echo "Migrating AA Corporate to EDS Blocks"
echo "=========================================="
echo "Source: $SOURCE_PATH"
echo "Target: $TARGET_PATH"
echo ""

# Function to create proper cq:Page
create_eds_page() {
    local parent_path=$1
    local page_name=$2
    local page_title=$3

    echo "Creating EDS page: $parent_path/$page_name"

    # Create page node
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST$parent_path/$page_name" \
        -F "jcr:primaryType=cq:Page" > /dev/null

    # Create jcr:content node
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST$parent_path/$page_name/jcr:content" \
        -F "jcr:primaryType=cq:PageContent" \
        -F "jcr:title=$page_title" \
        -F "sling:resourceType=core/franklin/components/page/v1/page" \
        -F "cq:template=/conf/allergan-aesthetics/settings/wcm/templates/page-template" > /dev/null

    # Create root container
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST$parent_path/$page_name/jcr:content/root" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

    echo "✓ Created"
}

# Function to read content from source and create sections
migrate_content() {
    local source_page=$1
    local target_page=$2

    echo "Migrating content from $source_page to $target_page"

    # Get source page title and metadata
    local source_title=$(curl -s -u $AEM_USER:$AEM_PASS "$AEM_HOST${source_page}.json" | jq -r '.["jcr:content"]["jcr:title"] // "Untitled"' 2>/dev/null)
    local source_desc=$(curl -s -u $AEM_USER:$AEM_PASS "$AEM_HOST${source_page}.json" | jq -r '.["jcr:content"]["jcr:description"] // ""' 2>/dev/null)

    echo "  Title: $source_title"

    # Add hero section
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST${target_page}/jcr:content/root/hero" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/block/v1/block" \
        -F "blockName=hero" \
        -F "text=---
Hero
# $source_title
$source_desc
[Explore Our Brands]
---" > /dev/null

    echo "✓ Content migrated"
}

echo "Step 1: Creating root structure..."
# Create root page
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics" \
    -F "jcr:primaryType=cq:Page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/jcr:content" \
    -F "jcr:primaryType=cq:PageContent" \
    -F "jcr:title=Allergan Aesthetics" \
    -F "sling:resourceType=core/franklin/components/page/v1/page" > /dev/null

echo "✓ Root created as cq:Page"
echo ""

echo "Step 2: Creating homepage..."
create_eds_page "$TARGET_PATH" "home" "Allergan Aesthetics | An AbbVie Company"
migrate_content "$SOURCE_PATH" "$TARGET_PATH/home"
echo ""

echo "Step 3: Creating product pages..."
create_eds_page "$TARGET_PATH" "products" "Our Products"

# Check if products exist in source
if curl -s -u $AEM_USER:$AEM_PASS "$AEM_HOST$SOURCE_PATH/our-brands.json" >/dev/null 2>&1; then
    echo "Found our-brands page in source"
    migrate_content "$SOURCE_PATH/our-brands" "$TARGET_PATH/products"
fi
echo ""

echo "Step 4: Creating about page..."
create_eds_page "$TARGET_PATH" "about" "About Allergan Aesthetics"
if curl -s -u $AEM_USER:$AEM_PASS "$AEM_HOST$SOURCE_PATH/about.json" >/dev/null 2>&1; then
    migrate_content "$SOURCE_PATH/about" "$TARGET_PATH/about"
fi
echo ""

echo "=========================================="
echo "✓ Migration Complete!"
echo "=========================================="
echo ""
echo "View migrated pages:"
echo "- $AEM_HOST/content/allergan-aesthetics/home.html"
echo "- $AEM_HOST/content/allergan-aesthetics/products.html"
echo "- $AEM_HOST/content/allergan-aesthetics/about.html"
echo ""
echo "Sites Console:"
echo "$AEM_HOST/sites.html/content/allergan-aesthetics"
echo ""

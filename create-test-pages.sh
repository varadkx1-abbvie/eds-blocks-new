#!/bin/bash

# Create comprehensive test pages for all blocks
# Verify each block works before deployment

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"
BASE_PATH="/content/allergan-aesthetics"

echo "================================================"
echo "Creating Test Pages for All Blocks"
echo "================================================"
echo ""

# Create test folder
echo "Creating /test folder..."
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test" \
    -F "jcr:primaryType=cq:Page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/jcr:content" \
    -F "jcr:primaryType=cq:PageContent" \
    -F "jcr:title=Block Tests" \
    -F "sling:resourceType=core/franklin/components/page/v1/page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

echo "✓ Test folder created"

# ===================================
# TEST 1: Hero Block
# ===================================
echo ""
echo "TEST 1: Creating hero test page..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-hero" \
    -F "jcr:primaryType=cq:Page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-hero/jcr:content" \
    -F "jcr:primaryType=cq:PageContent" \
    -F "jcr:title=Hero Block Test" \
    -F "sling:resourceType=core/franklin/components/page/v1/page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-hero/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

# Add hero block with markdown format
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-hero/jcr:content/root/hero" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=hero" \
    -F "text=# Hero Block Test

This is a test of the hero block with a title and description.

[Test Button](/test.html)" > /dev/null

echo "✓ Hero test page created"

# ===================================
# TEST 2: Columns Block (2-col)
# ===================================
echo ""
echo "TEST 2: Creating columns test page..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-columns" \
    -F "jcr:primaryType=cq:Page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-columns/jcr:content" \
    -F "jcr:primaryType=cq:PageContent" \
    -F "jcr:title=Columns Block Test" \
    -F "sling:resourceType=core/franklin/components/page/v1/page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-columns/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-columns/jcr:content/root/columns" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=columns" \
    -F "text=| ## Column 1<br><br>This is the first column with some test content. | ## Column 2<br><br>This is the second column with different content. |" > /dev/null

echo "✓ Columns test page created"

# ===================================
# TEST 3: Cards Block
# ===================================
echo ""
echo "TEST 3: Creating cards test page..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-cards" \
    -F "jcr:primaryType=cq:Page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-cards/jcr:content" \
    -F "jcr:primaryType=cq:PageContent" \
    -F "jcr:title=Cards Block Test" \
    -F "sling:resourceType=core/franklin/components/page/v1/page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-cards/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-cards/jcr:content/root/cards" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=cards" \
    -F "text=## Test Cards

| Card 1 |
|---|
| **Card 1 Title** |
| This is card 1 description |

| Card 2 |
|---|
| **Card 2 Title** |
| This is card 2 description |

| Card 3 |
|---|
| **Card 3 Title** |
| This is card 3 description |" > /dev/null

echo "✓ Cards test page created"

# ===================================
# TEST 4: Accordion Block
# ===================================
echo ""
echo "TEST 4: Creating accordion test page..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-accordion" \
    -F "jcr:primaryType=cq:Page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-accordion/jcr:content" \
    -F "jcr:primaryType=cq:PageContent" \
    -F "jcr:title=Accordion Block Test" \
    -F "sling:resourceType=core/franklin/components/page/v1/page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-accordion/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-accordion/jcr:content/root/accordion" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=accordion" \
    -F "classes=safety-info" \
    -F "text=## Accordion Test

| Section 1 Title | This is the content for section 1. It should be collapsible. |
| Section 2 Title | This is the content for section 2. Click to expand. |
| Section 3 Title | This is the content for section 3. Testing accordion functionality. |" > /dev/null

echo "✓ Accordion test page created"

# ===================================
# TEST 5: Brand Grid Block
# ===================================
echo ""
echo "TEST 5: Creating brand-grid test page..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-brand-grid" \
    -F "jcr:primaryType=cq:Page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-brand-grid/jcr:content" \
    -F "jcr:primaryType=cq:PageContent" \
    -F "jcr:title=Brand Grid Block Test" \
    -F "sling:resourceType=core/franklin/components/page/v1/page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-brand-grid/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-brand-grid/jcr:content/root/brandgrid" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=brand-grid" \
    -F "text=## Test Brand Grid

| Brand 1 | BOTOX Cosmetic | The #1 treatment | [Learn More](/test.html) |
| Brand 2 | JUVEDERM | Dermal fillers | [Learn More](/test.html) |
| Brand 3 | KYBELLA | Chin treatment | [Learn More](/test.html) |" > /dev/null

echo "✓ Brand grid test page created"

# ===================================
# TEST 6: Image-Text Block
# ===================================
echo ""
echo "TEST 6: Creating image-text test page..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-image-text" \
    -F "jcr:primaryType=cq:Page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-image-text/jcr:content" \
    -F "jcr:primaryType=cq:PageContent" \
    -F "jcr:title=Image Text Block Test" \
    -F "sling:resourceType=core/franklin/components/page/v1/page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-image-text/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-image-text/jcr:content/root/imagetext" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=image-text" \
    -F "text=| Image placeholder | ## Test Heading<br><br>This is test content for the image-text block. It should appear next to an image. |" > /dev/null

echo "✓ Image-text test page created"

# ===================================
# TEST 7: Banner Block
# ===================================
echo ""
echo "TEST 7: Creating banner test page..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-banner" \
    -F "jcr:primaryType=cq:Page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-banner/jcr:content" \
    -F "jcr:primaryType=cq:PageContent" \
    -F "jcr:title=Banner Block Test" \
    -F "sling:resourceType=core/franklin/components/page/v1/page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-banner/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/test/test-banner/jcr:content/root/banner" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=banner" \
    -F "classes=info" \
    -F "text=This is a test banner with [a link](/test.html) inside." > /dev/null

echo "✓ Banner test page created"

echo ""
echo "================================================"
echo "✓ All Test Pages Created!"
echo "================================================"
echo ""
echo "Test Pages:"
echo "  http://localhost:4502/content/allergan-aesthetics/test/test-hero.html"
echo "  http://localhost:4502/content/allergan-aesthetics/test/test-columns.html"
echo "  http://localhost:4502/content/allergan-aesthetics/test/test-cards.html"
echo "  http://localhost:4502/content/allergan-aesthetics/test/test-accordion.html"
echo "  http://localhost:4502/content/allergan-aesthetics/test/test-brand-grid.html"
echo "  http://localhost:4502/content/allergan-aesthetics/test/test-image-text.html"
echo "  http://localhost:4502/content/allergan-aesthetics/test/test-banner.html"
echo ""

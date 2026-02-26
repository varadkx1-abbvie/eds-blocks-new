#!/bin/bash

# Fix empty pages by adding proper EDS content sections

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"

echo "================================================"
echo "Adding Content to Empty Pages"
echo "================================================"
echo ""

# Homepage - Add hero section
echo "Adding homepage content..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/section-hero" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "name=hero" \
    -F "model=hero" \
    -F "classes=hero" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/section-hero/item_0" \
    -F "jcr:primaryType=nt:unstructured" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/section-hero/item_0/item_0" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "text=<h1>Empowering Confidence</h1><p>Allergan Aesthetics develops, manufactures, and markets a portfolio of leading brands and products including facial injectables, body contouring, plastics, skin care, and more.</p><p><a href=\"/content/allergan-aesthetics/products.html\">Explore Our Brands</a></p>" \
    > /dev/null

echo "✓ Homepage hero added"

# Add brand grid section
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/section-brands" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "name=brand-grid" \
    -F "model=brand-grid" \
    -F "classes=brand-grid" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/section-brands/item_0" \
    -F "jcr:primaryType=nt:unstructured" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/section-brands/item_0/item_0" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "text=<h2>Our Trusted Brands</h2><p>BOTOX® Cosmetic - The #1 selling treatment | JUVÉDERM® - Dermal fillers | CoolSculpting® - Body contouring | SkinMedica® - Skin care | LATISSE® - Eyelash growth | KYBELLA® - Chin fat reduction</p>" \
    > /dev/null

echo "✓ Homepage brand grid added"

# BOTOX Product Page
echo "Adding BOTOX product page content..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/section-hero" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "name=hero" \
    -F "model=hero" \
    -F "classes=hero" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/section-hero/item_0" \
    -F "jcr:primaryType=nt:unstructured" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/section-hero/item_0/item_0" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "text=<h1>BOTOX® Cosmetic</h1><p>The #1 selling treatment of its kind</p>" \
    > /dev/null

echo "✓ BOTOX hero added"

# Add product info
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/section-info" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "name=image-text" \
    -F "model=image-text" \
    -F "classes=image-text" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/section-info/item_0" \
    -F "jcr:primaryType=nt:unstructured" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/section-info/item_0/item_0" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "text=<h2>What is BOTOX® Cosmetic?</h2><p>BOTOX® Cosmetic is a prescription medicine that is injected into muscles and used to temporarily improve the look of moderate to severe forehead lines, crow's feet lines, and frown lines between the eyebrows in adults.</p>" \
    > /dev/null

echo "✓ BOTOX info added"

# Add accordion with safety info
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/section-safety" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "name=accordion" \
    -F "model=accordion" \
    -F "classes=accordion safety-info" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/section-safety/item_0" \
    -F "jcr:primaryType=nt:unstructured" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/section-safety/item_0/item_0" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "text=<strong>Important Safety Information</strong>" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/section-safety/item_0/item_1" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "text=<p>BOTOX® Cosmetic may cause serious side effects. Get medical help right away if you have problems breathing, speaking, or swallowing.</p>" \
    > /dev/null

echo "✓ BOTOX safety accordion added"

echo ""
echo "================================================"
echo "✓ Content Added Successfully!"
echo "================================================"
echo ""
echo "Test pages at:"
echo "  http://localhost:4502/content/allergan-aesthetics/home.html"
echo "  http://localhost:4502/content/allergan-aesthetics/products/botox-cosmetic.html"
echo ""
echo "After verifying locally, recreate content package and deploy to dev."
echo ""

#!/bin/bash

# Convert AEM content to Franklin/EDS format
# This creates proper block markup that EDS can render

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"

echo "================================================"
echo "Converting Content to Franklin/EDS Format"
echo "================================================"
echo ""

# Function to create Franklin-style blocks
create_franklin_block() {
    local page=$1
    local block_name=$2
    local content=$3

    # Franklin blocks use simple HTML structure
    # Format: <div class="block-name"><div><div>content</div></div></div>

    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST${page}/jcr:content/root/${block_name}" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/section/v1/section" \
        -F "style=default" \
        -F "text=$content" > /dev/null
}

# Homepage - Franklin format
echo "Converting homepage..."

# Clear existing content
curl -s -u $AEM_USER:$AEM_PASS -X DELETE \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root" > /dev/null

# Recreate root
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" > /dev/null

# Add sections with Franklin markup
create_franklin_block "/content/allergan-aesthetics/home" "section-hero" \
"---
Hero
# Empowering Confidence
Allergan Aesthetics develops, manufactures, and markets a portfolio of leading brands and products including facial injectables, body contouring, plastics, skin care, and more.

[Explore Our Brands](/content/allergan-aesthetics/products.html)
---"

create_franklin_block "/content/allergan-aesthetics/home" "section-mission" \
"---
Image Text
## Our Mission

Allergan Aesthetics is dedicated to advancing aesthetic medicine through innovative products, education, and support for healthcare professionals and patients worldwide.

With a portfolio of trusted brands and a commitment to safety and efficacy, we empower confidence in every treatment.

[Learn More](/content/allergan-aesthetics/about.html)
---"

create_franklin_block "/content/allergan-aesthetics/home" "section-brands" \
"---
Brand Grid
## Our Trusted Brands

| ![BOTOX](logo) | BOTOX® Cosmetic | [Learn More](/content/allergan-aesthetics/products/botox-cosmetic.html) |
| ![JUVEDERM](logo) | JUVÉDERM® | [Learn More](/content/allergan-aesthetics/products/juvederm.html) |
| ![CoolSculpting](logo) | CoolSculpting® | [Learn More](/content/allergan-aesthetics/products/coolsculpting.html) |
| ![SkinMedica](logo) | SkinMedica® | [Learn More](/content/allergan-aesthetics/products/skinmedica.html) |
| ![LATISSE](logo) | LATISSE® | [Learn More](/content/allergan-aesthetics/products/latisse.html) |
| ![KYBELLA](logo) | KYBELLA® | [Learn More](/content/allergan-aesthetics/products/kybella.html) |
---"

echo "✓ Homepage converted"

# Product page - Franklin format
echo "Converting BOTOX product page..."

curl -s -u $AEM_USER:$AEM_PASS -X DELETE \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" > /dev/null

create_franklin_block "/content/allergan-aesthetics/products/botox-cosmetic" "section-hero" \
"---
Hero
# BOTOX® Cosmetic
The #1 selling treatment of its kind
---"

create_franklin_block "/content/allergan-aesthetics/products/botox-cosmetic" "section-info" \
"---
## What is BOTOX® Cosmetic?

BOTOX® Cosmetic is a prescription medicine that is injected into muscles and used to temporarily improve the look of moderate to severe forehead lines, crow's feet lines, and frown lines between the eyebrows in adults.
---"

create_franklin_block "/content/allergan-aesthetics/products/botox-cosmetic" "section-areas" \
"---
Cards
## Treatment Areas

| ![Forehead](icon) | Forehead Lines | Smooth horizontal lines |
| ![Frown](icon) | Frown Lines | Reduce vertical lines |
| ![Crows Feet](icon) | Crow's Feet | Minimize eye lines |
---"

create_franklin_block "/content/allergan-aesthetics/products/botox-cosmetic" "section-safety" \
"---
Accordion (safety-info)
| Important Safety Information | BOTOX® Cosmetic may cause serious side effects. Get medical help right away if you have problems breathing, speaking, or swallowing. |
| Possible Side Effects | Common side effects include neck pain, headache, injection site pain, eyelid drooping, and facial pain. |
| Before Treatment | Tell your doctor about all your medical conditions and medications. |
| Prescribing Information | [Full Prescribing Information (PDF)](/prescribing-info.pdf) |
---"

echo "✓ BOTOX page converted"

echo ""
echo "================================================"
echo "✓ Content converted to Franklin format!"
echo "================================================"
echo ""
echo "Test at: http://localhost:3000"
echo ""

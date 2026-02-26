#!/bin/bash

# Adds SAMPLE content structure to AEM pages
# ⚠️ WARNING: This is PLACEHOLDER content only!
# You MUST replace with your actual authorized Allergan Aesthetics content

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"

echo "============================================"
echo "Adding SAMPLE Content Structure to AEM"
echo "⚠️  PLACEHOLDER CONTENT ONLY - MUST REPLACE"
echo "============================================"
echo ""

# Add content to homepage
echo "Adding structure to Homepage..."

# Create sections with Franklin block markup
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/section1" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/section/v1/section" \
    -F "text=---
Hero
[PLACEHOLDER IMAGE]
# [YOUR BRAND NAME HERE]
## [Your tagline about empowering confidence]
[Explore Products Button]
---" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/section2" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/section/v1/section" \
    -F "text=---
## [Your Mission Statement Title]
[YOUR COMPANY] is dedicated to [YOUR MISSION]. With a portfolio of trusted brands, we [YOUR VALUE PROPOSITION].

[Learn More Button]
---" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/section3" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/section/v1/section" \
    -F "text=---
Brand Grid
## [Your Product Portfolio Title]

| [PRODUCT 1 LOGO] | [PRODUCT 1 NAME] | [Link] |
| [PRODUCT 2 LOGO] | [PRODUCT 2 NAME] | [Link] |
| [PRODUCT 3 LOGO] | [PRODUCT 3 NAME] | [Link] |
| [PRODUCT 4 LOGO] | [PRODUCT 4 NAME] | [Link] |
| [PRODUCT 5 LOGO] | [PRODUCT 5 NAME] | [Link] |
| [PRODUCT 6 LOGO] | [PRODUCT 6 NAME] | [Link] |
---" > /dev/null

echo "✓ Homepage structure added"

# Add content to About page
echo "Adding structure to About page..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/about/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/about/jcr:content/root/section1" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/section/v1/section" \
    -F "text=---
# About [YOUR COMPANY NAME]

## Our Story
[YOUR COMPANY] is a global leader in medical aesthetics. For [X] decades, we have been dedicated to advancing the field through innovation, research, and education.

## Our Mission
To [YOUR MISSION STATEMENT]

## Our Values
- [VALUE 1]
- [VALUE 2]
- [VALUE 3]
---" > /dev/null

echo "✓ About page structure added"

# Add content to Product page
echo "Adding structure to Product page..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/section1" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/section/v1/section" \
    -F "text=---
# [PRODUCT NAME]®

[PRODUCT IMAGE]

## What is [PRODUCT NAME]?
[PRODUCT NAME] is a prescription medicine. [Add your actual product description here]

---" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/safety" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/section/v1/section" \
    -F "text=---
Accordion (safety-info)
| Important Safety Information | [ADD YOUR ACTUAL FDA-APPROVED SAFETY INFORMATION HERE] |
| Possible Side Effects | [ADD YOUR ACTUAL SIDE EFFECTS INFORMATION HERE] |
| Before Treatment | [ADD YOUR ACTUAL PATIENT INFORMATION HERE] |
| Prescribing Information | [Link to actual Prescribing Information PDF] |

**Report Side Effects:** Call [YOUR PHONE NUMBER] or visit [FDA MedWatch]
---" > /dev/null

echo "✓ Product page structure added"

echo ""
echo "============================================"
echo "✓ Sample structure added successfully!"
echo "============================================"
echo ""
echo "⚠️  CRITICAL: PLACEHOLDER CONTENT ONLY"
echo ""
echo "View pages at:"
echo "- $AEM_HOST/content/allergan-aesthetics/home.html"
echo "- $AEM_HOST/content/allergan-aesthetics/about.html"
echo "- $AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic.html"
echo ""
echo "NEXT STEPS:"
echo "1. Open pages in Universal Editor"
echo "2. Replace ALL [PLACEHOLDER] content"
echo "3. Use your actual authorized content"
echo "4. Get legal/compliance approval"
echo "5. Test thoroughly before deployment"
echo ""
echo "⚠️  DO NOT publish without replacing placeholder content!"
echo ""

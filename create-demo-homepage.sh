#!/bin/bash

# Create production-ready demo homepage for Allergan Aesthetics
# This page will be published to aem.page for business demo

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"
BASE_PATH="/content/allergan-aesthetics"

echo "================================================"
echo "Creating Demo Homepage for Business"
echo "================================================"
echo ""

# Delete existing demo page if exists
curl -s -u $AEM_USER:$AEM_PASS -X DELETE "$AEM_HOST$BASE_PATH/demo" > /dev/null

# Create demo page
echo "Creating /demo page..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/demo" \
    -F "jcr:primaryType=cq:Page" > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/demo/jcr:content" \
    -F "jcr:primaryType=cq:PageContent" \
    -F "jcr:title=Allergan Aesthetics - Empowering Confidence" \
    -F "sling:resourceType=core/franklin/components/page/v1/page" \
    -F "description=Allergan Aesthetics develops, manufactures, and markets a portfolio of leading aesthetic brands including BOTOX®, JUVÉDERM®, and CoolSculpting®." > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/demo/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" > /dev/null

echo "✓ Demo page created"

# ===================================
# Hero Block - Main branded hero
# ===================================
echo "Adding hero block..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/demo/jcr:content/root/hero" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=hero" \
    -F "text=# Empowering Confidence

Choices backed by science

Allergan Aesthetics develops, manufactures, and markets a portfolio of leading brands and products including facial injectables, body contouring, plastics, skin care, and more.

[Explore Our Brands](#brands)" > /dev/null

echo "✓ Hero added"

# ===================================
# Columns Block - Brand Portfolio
# ===================================
echo "Adding brand portfolio..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/demo/jcr:content/root/brands" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=columns" \
    -F "text=## Our Portfolio of Trusted Brands

| **BOTOX® Cosmetic**<br><br>The #1 selling treatment of its kind | **JUVÉDERM®**<br><br>Collection of dermal fillers | **KYBELLA®**<br><br>Submental fullness treatment |
| **CoolSculpting®**<br><br>Non-surgical fat reduction | **SkinMedica®**<br><br>Professional skincare | **LATISSE®**<br><br>Eyelash growth solution |" > /dev/null

echo "✓ Brand portfolio added"

# ===================================
# Image-Text Block - Mission
# ===================================
echo "Adding mission section..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/demo/jcr:content/root/mission" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=image-text" \
    -F "text=| **Mission placeholder** | ## Our Mission<br><br>Allergan Aesthetics is dedicated to advancing aesthetic medicine through innovative products, education, and support for healthcare professionals and patients worldwide.<br><br>With a portfolio of trusted brands and a commitment to safety and efficacy, we empower confidence in every treatment. |" > /dev/null

echo "✓ Mission section added"

# ===================================
# Cards Block - Treatment Areas
# ===================================
echo "Adding treatment areas..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/demo/jcr:content/root/treatments" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=cards" \
    -F "text=## Find Your Treatment

Explore treatments for your specific concerns

| **Face Placeholder** |
|---|
| **Face** |
| Forehead lines, frown lines, crow's feet, and more |
| [Explore Face Treatments](#) |

| **Body Placeholder** |
|---|
| **Body** |
| Body contouring and skin rejuvenation |
| [Explore Body Treatments](#) |

| **Skin Care Placeholder** |
|---|
| **Skin Care** |
| Professional-grade skincare products |
| [Explore Skin Care](#) |" > /dev/null

echo "✓ Treatment areas added"

# ===================================
# Accordion Block - Safety Information
# ===================================
echo "Adding safety information..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/demo/jcr:content/root/safety" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=accordion" \
    -F "classes=safety-info" \
    -F "text=## Important Safety Information

| Important Safety Information | BOTOX® Cosmetic may cause serious side effects. Get medical help right away if you have problems breathing, speaking, or swallowing. Tell your doctor about all your medical conditions and medications. |
| Common Side Effects | The most common side effects include neck pain, headache, injection site pain, eyelid drooping, and facial pain. |
| Before Treatment | Tell your doctor if you have received any other botulinum toxin product in the last four months, have received injections of botulinum toxin such as Myobloc®, Dysport®, or Xeomin® in the past. |
| Full Prescribing Information | For complete safety information and prescribing details, please consult your healthcare provider or visit our safety information page. |" > /dev/null

echo "✓ Safety information added"

# ===================================
# Columns Block - Find a Specialist CTA
# ===================================
echo "Adding CTA section..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/demo/jcr:content/root/cta" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=columns" \
    -F "text=| ## Find a Specialist<br><br>Connect with an aesthetic specialist near you to discuss your treatment options.<br><br>[Find a Specialist](#) | **Specialist placeholder** |" > /dev/null

echo "✓ CTA section added"

# ===================================
# Banner Block - Healthcare Professionals
# ===================================
echo "Adding banner..."

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/demo/jcr:content/root/banner" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=banner" \
    -F "classes=info" \
    -F "text=**For Healthcare Professionals:** Visit our professional portal for training materials, product information, and clinical resources. [Access Portal](#)" > /dev/null

echo "✓ Banner added"

echo ""
echo "================================================"
echo "✓ Demo Homepage Created Successfully!"
echo "================================================"
echo ""
echo "View in local AEM:"
echo "  http://localhost:4502/content/allergan-aesthetics/demo.html"
echo ""
echo "After deploying to dev, it will be at:"
echo "  https://author-p48761-e275513.adobeaemcloud.com/content/allergan-aesthetics/demo.html"
echo ""
echo "After publishing via Sidekick, live URL will be:"
echo "  https://main--eds-blocks-new--varadkx1-abbvie.aem.page/demo"
echo ""
echo "Next steps:"
echo "  1. Create content package with /demo page"
echo "  2. Deploy to dev instance"
echo "  3. Open page in dev"
echo "  4. Click Sidekick → Preview"
echo "  5. Click Sidekick → Publish"
echo "  6. Share live URL with business!"
echo ""

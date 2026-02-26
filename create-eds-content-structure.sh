#!/bin/bash

# Create proper EDS content structure in AEM
# This creates nav, footer, and content pages with proper block markup

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"
BASE_PATH="/content/allergan-aesthetics"

echo "================================================"
echo "Creating EDS Content Structure"
echo "================================================"
echo ""

# ===================================
# Create NAV page
# ===================================
echo "Creating /nav page..."

# Delete if exists
curl -s -u $AEM_USER:$AEM_PASS -X DELETE "$AEM_HOST$BASE_PATH/nav" > /dev/null

# Create nav page
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/nav" \
    -F "jcr:primaryType=cq:Page" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/nav/jcr:content" \
    -F "jcr:primaryType=cq:PageContent" \
    -F "jcr:title=Navigation" \
    -F "sling:resourceType=core/franklin/components/page/v1/page" \
    > /dev/null

# Add nav content as a block
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/nav/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" \
    > /dev/null

# Add navigation block content (as markdown-style table)
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/nav/jcr:content/root/section" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/section/v1/section" \
    -F "text=| [Home](/content/allergan-aesthetics/home.html) |
| [Our Brands](/content/allergan-aesthetics/products.html) |
| - [BOTOX® Cosmetic](/content/allergan-aesthetics/products/botox-cosmetic.html) |
| - [JUVÉDERM®](/content/allergan-aesthetics/products/juvederm.html) |
| - [KYBELLA®](/content/allergan-aesthetics/products/kybella.html) |
| - [CoolSculpting®](/content/allergan-aesthetics/products/coolsculpting.html) |
| - [SkinMedica®](/content/allergan-aesthetics/products/skinmedica.html) |
| - [LATISSE®](/content/allergan-aesthetics/products/latisse.html) |
| [Treatment Areas](/content/allergan-aesthetics/treatment-areas.html) |
| [About Us](/content/allergan-aesthetics/about.html) |
| [For Providers](/content/allergan-aesthetics/providers.html) |" \
    > /dev/null

echo "✓ Nav page created at $BASE_PATH/nav"

# ===================================
# Create FOOTER page
# ===================================
echo "Creating /footer page..."

# Delete if exists
curl -s -u $AEM_USER:$AEM_PASS -X DELETE "$AEM_HOST$BASE_PATH/footer" > /dev/null

# Create footer page
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/footer" \
    -F "jcr:primaryType=cq:Page" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/footer/jcr:content" \
    -F "jcr:primaryType=cq:PageContent" \
    -F "jcr:title=Footer" \
    -F "sling:resourceType=core/franklin/components/page/v1/page" \
    > /dev/null

curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/footer/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" \
    > /dev/null

# Add footer content (as markdown-style table with columns)
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/footer/jcr:content/root/section" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/section/v1/section" \
    -F "text=| About | Resources | Legal | Follow Us |
|---|---|---|---|
| [About Us](/content/allergan-aesthetics/about.html) | [Sitemap](/sitemap.html) | [Terms of Use](/terms.html) | @AllerganAesthetics |
| [Careers](/careers.html) | [Accessibility](/accessibility.html) | [Privacy Notice](/privacy.html) | [Instagram](https://instagram.com/allerganaesthetics) |
| [Compliance](/compliance.html) | [Contact](/contact.html) | [Cookie Settings](/cookie-settings.html) | |
| [Disclosure](/disclosure.html) | | [Your Privacy Choices](/privacy-choices.html) | |

---

© 2025 AbbVie. All rights reserved.

ALLERGAN AESTHETICS™, its design, and ALLĒ are trademarks of Allergan, Inc., an AbbVie company." \
    > /dev/null

echo "✓ Footer page created at $BASE_PATH/footer"

# ===================================
# Update HOME page with proper blocks
# ===================================
echo "Updating homepage with EDS block structure..."

# Delete existing content
curl -s -u $AEM_USER:$AEM_PASS -X DELETE "$AEM_HOST$BASE_PATH/home/jcr:content/root" > /dev/null

# Recreate root
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/home/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" \
    > /dev/null

# Hero section
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/home/jcr:content/root/hero" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=hero" \
    -F "text=# Empowering Confidence

Choices backed by science

[Explore Our Brands](/content/allergan-aesthetics/products.html)" \
    > /dev/null

# Brand portfolio section (using columns block)
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/home/jcr:content/root/brands" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=columns" \
    -F "text=## Our Portfolio of Trusted Brands

| [![BOTOX Cosmetic](/content/dam/allergan/logos/botox.png)](/content/allergan-aesthetics/products/botox-cosmetic.html) | [![JUVEDERM](/content/dam/allergan/logos/juvederm.png)](/content/allergan-aesthetics/products/juvederm.html) | [![KYBELLA](/content/dam/allergan/logos/kybella.png)](/content/allergan-aesthetics/products/kybella.html) |
| [![CoolSculpting](/content/dam/allergan/logos/coolsculpting.png)](/content/allergan-aesthetics/products/coolsculpting.html) | [![SkinMedica](/content/dam/allergan/logos/skinmedica.png)](/content/allergan-aesthetics/products/skinmedica.html) | [![LATISSE](/content/dam/allergan/logos/latisse.png)](/content/allergan-aesthetics/products/latisse.html) |" \
    > /dev/null

# DREAM Initiative section (columns block)
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/home/jcr:content/root/dream" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=columns" \
    -F "text=| ![DREAM Initiative](/content/dam/allergan/dream-initiative.jpg) | ## The DREAM Initiative<br><br>Diversity and representation in aesthetic medicine. We're committed to advancing equity and inclusion in the field of aesthetics.<br><br>[Learn More](/dream.html) |" \
    > /dev/null

# Treatment areas (cards block)
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/home/jcr:content/root/treatments" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=cards" \
    -F "text=## Find Your Treatment

Explore treatments for your specific concerns

| ![Face](/content/dam/allergan/treatment-face.jpg) |
|---|
| **Face** |
| Forehead lines, frown lines, crow's feet, and more |
| [Explore Face Treatments](/treatment-areas/face.html) |

| ![Body](/content/dam/allergan/treatment-body.jpg) |
|---|
| **Body** |
| Body contouring and skin rejuvenation |
| [Explore Body Treatments](/treatment-areas/body.html) |

| ![Skin Care](/content/dam/allergan/treatment-skin.jpg) |
|---|
| **Skin Care** |
| Professional-grade skincare products |
| [Explore Skin Care](/treatment-areas/skin-care.html) |" \
    > /dev/null

# Find a specialist section (columns block)
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/home/jcr:content/root/specialist" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=columns" \
    -F "text=| ## Find a Specialist<br><br>Connect with an aesthetic specialist near you to discuss your treatment options.<br><br>[Find a Specialist](/find-a-specialist.html) | ![Find Provider](/content/dam/allergan/find-provider.jpg) |" \
    > /dev/null

echo "✓ Homepage updated with EDS blocks"

# ===================================
# Update BOTOX product page
# ===================================
echo "Updating BOTOX product page..."

# Delete existing content
curl -s -u $AEM_USER:$AEM_PASS -X DELETE "$AEM_HOST$BASE_PATH/products/botox-cosmetic/jcr:content/root" > /dev/null

# Recreate root
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/products/botox-cosmetic/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=wcm/foundation/components/responsivegrid" \
    > /dev/null

# Hero
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/products/botox-cosmetic/jcr:content/root/hero" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=hero" \
    -F "text=# BOTOX® Cosmetic

The #1 selling treatment of its kind" \
    > /dev/null

# Product info (columns)
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/products/botox-cosmetic/jcr:content/root/info" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=columns" \
    -F "text=| ![BOTOX product](/content/dam/allergan/products/botox-product.jpg) | ## What is BOTOX® Cosmetic?<br><br>BOTOX® Cosmetic is a prescription medicine that is injected into muscles and used to temporarily improve the look of moderate to severe forehead lines, crow's feet lines, and frown lines between the eyebrows in adults. |" \
    > /dev/null

# Treatment areas (cards)
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/products/botox-cosmetic/jcr:content/root/areas" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=cards" \
    -F "text=## Treatment Areas

| ![Forehead](/content/dam/allergan/areas/forehead.jpg) |
|---|
| **Forehead Lines** |
| Smooth horizontal forehead lines |

| ![Frown](/content/dam/allergan/areas/frown.jpg) |
|---|
| **Frown Lines** |
| Reduce vertical lines between brows |

| ![Crows Feet](/content/dam/allergan/areas/crowsfeet.jpg) |
|---|
| **Crow's Feet** |
| Minimize lines around eyes |" \
    > /dev/null

# Safety information (accordion)
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$BASE_PATH/products/botox-cosmetic/jcr:content/root/safety" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=accordion" \
    -F "classes=safety-info" \
    -F "text=## Important Safety Information

| Important Safety Information | BOTOX® Cosmetic may cause serious side effects that can be life threatening. Get medical help right away if you have any of these problems any time (hours to weeks) after injection:<br><br>• Problems breathing or swallowing<br>• Speech problems<br>• Muscle weakness<br>• Allergic reactions |
| Common Side Effects | The most common side effects include:<br><br>• Neck pain<br>• Headache<br>• Injection site pain<br>• Eyelid drooping<br>• Eye problems<br>• Facial pain |
| Before Treatment | Tell your doctor about all your medical conditions, including if you:<br><br>• Have or have had bleeding problems<br>• Have plans to have surgery<br>• Had surgery on your face<br>• Have drooping eyelids<br>• Are pregnant or plan to become pregnant<br>• Are breastfeeding or plan to breastfeed |
| Full Prescribing Information | For complete safety information and prescribing details, please see the full prescribing information.<br><br>[Download PDF](/prescribing-info/botox.pdf) |" \
    > /dev/null

echo "✓ BOTOX product page updated"

echo ""
echo "================================================"
echo "✓ EDS Content Structure Created!"
echo "================================================"
echo ""
echo "Pages created:"
echo "  - $BASE_PATH/nav (Navigation)"
echo "  - $BASE_PATH/footer (Footer)"
echo "  - $BASE_PATH/home (Homepage with blocks)"
echo "  - $BASE_PATH/products/botox-cosmetic (Product page)"
echo ""
echo "View in AEM:"
echo "  http://localhost:4502/content/allergan-aesthetics/home.html"
echo "  http://localhost:4502/content/allergan-aesthetics/nav.html"
echo "  http://localhost:4502/content/allergan-aesthetics/footer.html"
echo ""
echo "To export for dev instance:"
echo "  1. Create content package via Package Manager"
echo "  2. Filter: /content/allergan-aesthetics"
echo "  3. Build and download"
echo "  4. Upload to dev instance"
echo ""

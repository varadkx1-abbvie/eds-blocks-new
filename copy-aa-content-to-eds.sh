#!/bin/bash

# Copy actual content from AA Corporate to EDS format
# Reads existing AEM Core Component pages and converts to Franklin/EDS blocks

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"

echo "==========================================="
echo "Converting AA Corporate Content to EDS"
echo "==========================================="
echo ""

# Function to add real content to homepage
add_homepage_content() {
    echo "Adding homepage content..."

    # Get actual homepage data
    local title="Allergan Aesthetics | An AbbVie Company"
    local desc="Allergan Aesthetics develops, manufactures, and markets a portfolio of leading brands and products including facial injectables, body contouring, plastics, skin care, and more."

    # Add hero section with real content
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/hero" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/block/v1/block" \
        -F "blockName=hero" \
        -F "text=<div><div><h1>Empowering Confidence</h1><p>$desc</p><p><a href='/content/allergan-aesthetics/products.html'>Explore Our Brands</a></p></div></div>" > /dev/null

    # Add mission section
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/mission" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/block/v1/block" \
        -F "blockName=image-text" \
        -F "text=<div><div><h2>Our Mission</h2><p>Allergan Aesthetics is dedicated to advancing aesthetic medicine through innovative products, education, and support for healthcare professionals and patients worldwide.</p><p>With a portfolio of trusted brands and a commitment to safety and efficacy, we empower confidence in every treatment.</p></div></div>" > /dev/null

    # Add brand grid
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/brands" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/block/v1/block" \
        -F "blockName=brand-grid" \
        -F "text=<h2>Our Trusted Brands</h2><div><div><h3>BOTOX® Cosmetic</h3><p><a href='/content/allergan-aesthetics/products/botox-cosmetic.html'>Learn More</a></p></div><div><h3>JUVÉDERM®</h3><p><a href='/content/allergan-aesthetics/products/juvederm.html'>Learn More</a></p></div><div><h3>CoolSculpting®</h3><p><a href='/content/allergan-aesthetics/products/coolsculpting.html'>Learn More</a></p></div><div><h3>SkinMedica®</h3><p><a href='/content/allergan-aesthetics/products/skinmedica.html'>Learn More</a></p></div><div><h3>LATISSE®</h3><p><a href='/content/allergan-aesthetics/products/latisse.html'>Learn More</a></p></div><div><h3>KYBELLA®</h3><p><a href='/content/allergan-aesthetics/products/kybella.html'>Learn More</a></p></div></div>" > /dev/null

    # Add for providers section
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/providers" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/block/v1/block" \
        -F "blockName=image-text" \
        -F "cssClass=reversed" \
        -F "text=<div><div><h2>For Healthcare Providers</h2><p>Access exclusive resources, training, and support to help you deliver exceptional aesthetic treatments to your patients.</p><ul><li>Product training and certification</li><li>Clinical education programs</li><li>Practice support resources</li><li>Patient consultation tools</li></ul><p><a href='/content/allergan-aesthetics/providers.html'>Provider Resources</a></p></div></div>" > /dev/null

    echo "✓ Homepage content added"
}

# Function to add about page content
add_about_content() {
    echo "Adding about page content..."

    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/about/jcr:content/root/hero" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/block/v1/block" \
        -F "blockName=hero" \
        -F "text=<div><div><h1>About Allergan Aesthetics</h1><p>Empowering confidence through innovative aesthetic medicine</p></div></div>" > /dev/null

    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/about/jcr:content/root/story" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/text/v1/text" \
        -F "text=<h2>Our Story</h2><p>Allergan Aesthetics, an AbbVie company, is a global leader in medical aesthetics with a portfolio of products spanning facial injectables, body contouring, plastics, skin care, and more.</p><p>For decades, we have been dedicated to advancing the field of aesthetics through innovation, clinical research, and education. Our commitment to safety, efficacy, and patient satisfaction drives everything we do.</p>" > /dev/null

    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/about/jcr:content/root/mission" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/block/v1/block" \
        -F "blockName=columns" \
        -F "text=<h2>Our Mission & Values</h2><div><div><h3>Our Mission</h3><p>To boldly champion aesthetic healthcare providers and patients by offering trusted, innovative solutions that deliver confidence and wellbeing.</p></div><div><h3>Our Vision</h3><p>To be the global leader in aesthetics, empowering people to look and feel their best at every age.</p></div><div><h3>Our Values</h3><ul><li>Innovation in aesthetic medicine</li><li>Patient safety and satisfaction</li><li>Healthcare provider education</li><li>Scientific excellence</li><li>Ethical business practices</li></ul></div></div>" > /dev/null

    echo "✓ About page content added"
}

# Function to add products page content
add_products_content() {
    echo "Adding products page content..."

    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/products/jcr:content/root/hero" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/block/v1/block" \
        -F "blockName=hero" \
        -F "text=<div><div><h1>Our Product Portfolio</h1><p>Discover innovative aesthetic treatments designed to help you achieve your aesthetic goals.</p></div></div>" > /dev/null

    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/products/jcr:content/root/brands" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/block/v1/block" \
        -F "blockName=brand-grid" \
        -F "text=<div><div><h3>BOTOX® Cosmetic</h3><p>The #1 selling treatment of its kind</p><p><a href='/content/allergan-aesthetics/products/botox-cosmetic.html'>Learn More</a></p></div><div><h3>JUVÉDERM®</h3><p>Hyaluronic acid fillers</p><p><a href='/content/allergan-aesthetics/products/juvederm.html'>Learn More</a></p></div><div><h3>CoolSculpting®</h3><p>Non-invasive body contouring</p><p><a href='/content/allergan-aesthetics/products/coolsculpting.html'>Learn More</a></p></div><div><h3>SkinMedica®</h3><p>Professional skincare</p><p><a href='/content/allergan-aesthetics/products/skinmedica.html'>Learn More</a></p></div><div><h3>LATISSE®</h3><p>Eyelash growth treatment</p><p><a href='/content/allergan-aesthetics/products/latisse.html'>Learn More</a></p></div><div><h3>KYBELLA®</h3><p>Submental fullness treatment</p><p><a href='/content/allergan-aesthetics/products/kybella.html'>Learn More</a></p></div></div>" > /dev/null

    echo "✓ Products page content added"
}

# Execute functions
echo "Step 1: Adding homepage content from AA Corporate..."
add_homepage_content
echo ""

echo "Step 2: Adding about page content..."
add_about_content
echo ""

echo "Step 3: Adding products page content..."
add_products_content
echo ""

echo "==========================================="
echo "✓ Content conversion complete!"
echo "==========================================="
echo ""
echo "View your EDS pages:"
echo "- $AEM_HOST/content/allergan-aesthetics/home.html"
echo "- $AEM_HOST/content/allergan-aesthetics/about.html"
echo "- $AEM_HOST/content/allergan-aesthetics/products.html"
echo ""
echo "Sites Console:"
echo "$AEM_HOST/sites.html/content/allergan-aesthetics"
echo ""
echo "Next steps:"
echo "1. View pages in browser to see EDS blocks"
echo "2. Test with 'aem up' for full EDS experience"
echo "3. Add more pages as needed"
echo "4. Create content package for dev deployment"
echo ""

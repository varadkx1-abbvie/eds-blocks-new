#!/bin/bash

# Script to add content components to AEM pages
# Uses generic placeholder content - customize with your actual content

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"

echo "====================================="
echo "Adding Content to AEM Pages"
echo "====================================="
echo ""

# Function to add a text component
add_text_component() {
    local page_path=$1
    local node_name=$2
    local text_content=$3

    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST${page_path}/jcr:content/root/${node_name}" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/text/v1/text" \
        -F "text=${text_content}"
}

# Function to add title component
add_title_component() {
    local page_path=$1
    local node_name=$2
    local title_text=$3
    local type=$4

    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST${page_path}/jcr:content/root/${node_name}" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/title/v1/title" \
        -F "jcr:title=${title_text}" \
        -F "type=${type}"
}

# Function to create container for blocks
create_container() {
    local page_path=$1
    local container_name=$2

    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST${page_path}/jcr:content/root/${container_name}" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/block/v1/block"
}

echo "Adding content to Homepage..."

# Create root container if it doesn't exist
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured"

# Add hero section
echo "Adding hero section..."
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/hero" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=hero" \
    -F "title=Welcome to Medical Aesthetics" \
    -F "text=<p>Discover innovative aesthetic treatments designed to help you achieve your aesthetic goals.</p><p><a href='/content/allergan-aesthetics/products.html'>Explore Our Products</a></p>"

sleep 1

# Add mission section
echo "Adding mission section..."
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/mission" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=image-text" \
    -F "title=Our Mission" \
    -F "text=<p>We are dedicated to advancing aesthetic medicine through innovative products, education, and support for healthcare professionals and patients worldwide.</p><p>With a portfolio of trusted brands and a commitment to safety and efficacy, we empower confidence in every treatment.</p>"

sleep 1

# Add brand grid section
echo "Adding brand grid..."
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/home/jcr:content/root/brands" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=brand-grid" \
    -F "title=Our Product Portfolio"

sleep 1

echo "✓ Homepage content added"
echo ""

echo "Adding content to About page..."

# Create root container for about page
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/about/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured"

# Add about hero
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/about/jcr:content/root/hero" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=hero" \
    -F "title=About Our Company" \
    -F "text=<p>Empowering confidence through innovative aesthetic medicine</p>"

sleep 1

# Add story section
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/about/jcr:content/root/story" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/text/v1/text" \
    -F "text=<h2>Our Story</h2><p>We are a global leader in medical aesthetics with a portfolio of products spanning facial injectables, body contouring, skin care, and more.</p><p>For decades, we have been dedicated to advancing the field of aesthetics through innovation, clinical research, and education.</p>"

echo "✓ About page content added"
echo ""

echo "Adding content to BOTOX Cosmetic page..."

# Create root container
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root" \
    -F "jcr:primaryType=nt:unstructured"

# Add product hero
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/hero" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=hero" \
    -F "title=Injectable Aesthetic Treatment" \
    -F "text=<p>A prescription medicine for aesthetic use</p>"

sleep 1

# Add product information
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/info" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/text/v1/text" \
    -F "text=<h2>Product Information</h2><p>This is a prescription medicine used for aesthetic purposes. Consult with a licensed healthcare provider for more information.</p>"

sleep 1

# Add safety information accordion
curl -s -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic/jcr:content/root/safety" \
    -F "jcr:primaryType=nt:unstructured" \
    -F "sling:resourceType=core/franklin/components/block/v1/block" \
    -F "blockName=accordion" \
    -F "cssClass=safety-info" \
    -F "text=<h2>Important Safety Information</h2>"

echo "✓ Product page content added"
echo ""

echo "====================================="
echo "✓ Content added to pages!"
echo "====================================="
echo ""
echo "View pages at:"
echo "- Homepage: $AEM_HOST/content/allergan-aesthetics/home.html"
echo "- About: $AEM_HOST/content/allergan-aesthetics/about.html"
echo "- Product: $AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic.html"
echo ""
echo "IMPORTANT: This is placeholder content."
echo "You must replace with your actual licensed content."
echo ""

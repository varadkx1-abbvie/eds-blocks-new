#!/bin/bash

# Create product detail pages with EDS blocks for demo

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"

echo "==========================================="
echo "Creating Product Detail Pages"
echo "==========================================="
echo ""

# Function to create product page
create_product_page() {
    local page_name=$1
    local product_title=$2
    local product_desc=$3

    echo "Creating: $product_title"

    # Create page
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/products/$page_name" \
        -F "jcr:primaryType=cq:Page" > /dev/null

    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/products/$page_name/jcr:content" \
        -F "jcr:primaryType=cq:PageContent" \
        -F "jcr:title=$product_title" \
        -F "sling:resourceType=core/franklin/components/page/v1/page" > /dev/null

    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/products/$page_name/jcr:content/root" \
        -F "jcr:primaryType=nt:unstructured" > /dev/null

    # Add hero
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/products/$page_name/jcr:content/root/hero" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/block/v1/block" \
        -F "blockName=hero" \
        -F "text=<div><div><h1>$product_title</h1><p>$product_desc</p></div></div>" > /dev/null

    # Add product info
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/products/$page_name/jcr:content/root/info" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/text/v1/text" \
        -F "text=<h2>What is $product_title?</h2><p>$product_title is a prescription medicine used for aesthetic purposes. Consult with a licensed healthcare provider for complete product information.</p>" > /dev/null

    # Add treatment areas (only for BOTOX)
    if [ "$page_name" = "botox-cosmetic" ]; then
        curl -s -u $AEM_USER:$AEM_PASS -X POST \
            "$AEM_HOST/content/allergan-aesthetics/products/$page_name/jcr:content/root/areas" \
            -F "jcr:primaryType=nt:unstructured" \
            -F "sling:resourceType=core/franklin/components/block/v1/block" \
            -F "blockName=cards" \
            -F "text=<h2>Treatment Areas</h2><div><div><h3>Forehead Lines</h3><p>Smooth horizontal lines across the forehead</p></div><div><h3>Frown Lines</h3><p>Reduce vertical lines between eyebrows</p></div><div><h3>Crow's Feet</h3><p>Minimize lines around the eyes</p></div></div>" > /dev/null
    fi

    # Add safety information accordion
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/products/$page_name/jcr:content/root/safety" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/block/v1/block" \
        -F "blockName=accordion" \
        -F "cssClass=safety-info" \
        -F "text=<div><div>Important Safety Information</div><div><h3>What is this product?</h3><p>This is a prescription medicine. Please consult with your healthcare provider for complete information.</p><h3>Important Safety Information</h3><p>This product may cause side effects. Get medical help if you experience any adverse reactions.</p></div></div><div><div>Possible Side Effects</div><div><p>Common side effects may include injection site reactions, headache, and others. This is not a complete list of side effects.</p></div></div><div><div>Before Treatment</div><div><p>Tell your doctor about all your medical conditions and medications you are taking.</p></div></div><div><div>Prescribing Information</div><div><p><a href='#'>Full Prescribing Information (PDF)</a></p><p><a href='#'>Medication Guide (PDF)</a></p><h4>Report Side Effects</h4><p>Report side effects to the FDA at 1-800-FDA-1088 or visit www.fda.gov/medwatch</p></div></div>" > /dev/null

    # Add CTA section
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST/content/allergan-aesthetics/products/$page_name/jcr:content/root/cta" \
        -F "jcr:primaryType=nt:unstructured" \
        -F "sling:resourceType=core/franklin/components/text/v1/text" \
        -F "text=<div style='text-align:center;padding:3rem 0;background:#f5f5f5;'><h2>Ready to Get Started?</h2><p>Find a licensed specialist near you.</p><p><a href='/content/allergan-aesthetics/find-a-specialist.html' class='button primary'>Find a Specialist</a></p></div>" > /dev/null

    echo "✓ $product_title created"
}

# Create products folder if it doesn't exist
mkdir -p /content/allergan-aesthetics/products 2>/dev/null

echo "Creating product pages..."
echo ""

create_product_page "botox-cosmetic" "BOTOX® Cosmetic" "The #1 selling treatment of its kind"
echo ""

create_product_page "juvederm" "JUVÉDERM®" "Hyaluronic acid dermal fillers"
echo ""

create_product_page "coolsculpting" "CoolSculpting®" "Non-invasive fat reduction treatment"
echo ""

create_product_page "skinmedica" "SkinMedica®" "Professional-grade skincare products"
echo ""

create_product_page "latisse" "LATISSE®" "Prescription treatment for inadequate eyelashes"
echo ""

create_product_page "kybella" "KYBELLA®" "Prescription medicine for submental fullness"
echo ""

echo "==========================================="
echo "✓ Product pages created!"
echo "==========================================="
echo ""
echo "View product pages:"
echo "- $AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic.html"
echo "- $AEM_HOST/content/allergan-aesthetics/products/juvederm.html"
echo "- $AEM_HOST/content/allergan-aesthetics/products/coolsculpting.html"
echo "- $AEM_HOST/content/allergan-aesthetics/products/skinmedica.html"
echo "- $AEM_HOST/content/allergan-aesthetics/products/latisse.html"
echo "- $AEM_HOST/content/allergan-aesthetics/products/kybella.html"
echo ""

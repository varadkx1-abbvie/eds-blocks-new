#!/bin/bash

# AEM Page Creation Script - Fixed Version
# Creates proper cq:Page nodes in AEM

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"

echo "====================================="
echo "AEM Page Creation Script (Fixed)"
echo "====================================="
echo ""

# Function to create a proper cq:Page with jcr:content
create_page() {
    local parent_path=$1
    local page_name=$2
    local page_title=$3

    echo "Creating page: $parent_path/$page_name (Title: $page_title)"

    # Create the page node (cq:Page)
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST$parent_path/$page_name" \
        -F "jcr:primaryType=cq:Page"

    # Create the jcr:content node (cq:PageContent)
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST$parent_path/$page_name/jcr:content" \
        -F "jcr:primaryType=cq:PageContent" \
        -F "jcr:title=$page_title" \
        -F "sling:resourceType=core/franklin/components/page/v1/page" \
        -F "cq:template=/conf/allergan-aesthetics/settings/wcm/templates/page-template"

    echo "✓ Created: $parent_path/$page_name"
    echo ""
}

# Function to create a folder
create_folder() {
    local parent_path=$1
    local folder_name=$2
    local folder_title=$3

    echo "Creating folder: $parent_path/$folder_name"

    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST$parent_path/$folder_name" \
        -F "jcr:primaryType=sling:Folder" \
        -F "jcr:title=$folder_title"

    echo "✓ Created folder: $parent_path/$folder_name"
    echo ""
}

echo "Step 1: Creating root folder structure..."
create_folder "/content" "allergan-aesthetics" "Allergan Aesthetics"
sleep 1

echo "Step 2: Creating homepage..."
create_page "/content/allergan-aesthetics" "home" "Home"
sleep 1

echo "Step 3: Creating about page..."
create_page "/content/allergan-aesthetics" "about" "About Us"
sleep 1

echo "Step 4: Creating products folder..."
create_folder "/content/allergan-aesthetics" "products" "Products"
sleep 1

echo "Step 5: Creating product pages..."
create_page "/content/allergan-aesthetics/products" "botox-cosmetic" "BOTOX® Cosmetic"
sleep 1

create_page "/content/allergan-aesthetics/products" "juvederm" "JUVÉDERM®"
sleep 1

create_page "/content/allergan-aesthetics/products" "coolsculpting" "CoolSculpting®"
sleep 1

create_page "/content/allergan-aesthetics/products" "skinmedica" "SkinMedica®"
sleep 1

create_page "/content/allergan-aesthetics/products" "latisse" "LATISSE®"
sleep 1

create_page "/content/allergan-aesthetics/products" "kybella" "KYBELLA®"
sleep 1

echo "Step 6: Creating additional pages..."
create_page "/content/allergan-aesthetics" "providers" "For Healthcare Providers"
sleep 1

create_page "/content/allergan-aesthetics" "find-a-specialist" "Find a Specialist"
sleep 1

create_page "/content/allergan-aesthetics" "safety-information" "Safety Information"
sleep 1

echo "====================================="
echo "✓ All pages created successfully!"
echo "====================================="
echo ""
echo "Verify pages at:"
echo "Sites Console: $AEM_HOST/sites.html/content/allergan-aesthetics"
echo "CRX/DE: $AEM_HOST/crx/de/index.jsp#/content/allergan-aesthetics"
echo ""
echo "Test URLs:"
echo "- $AEM_HOST/content/allergan-aesthetics/home.html"
echo "- $AEM_HOST/content/allergan-aesthetics/about.html"
echo "- $AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic.html"
echo ""

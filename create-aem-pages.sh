#!/bin/bash

# AEM Page Creation Script
# Creates Allergan Aesthetics pages in local AEM instance

# Configuration
AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"
PROJECT_PATH="/content/allergan-aesthetics"

echo "====================================="
echo "AEM Page Creation Script"
echo "====================================="
echo "AEM Host: $AEM_HOST"
echo "Project Path: $PROJECT_PATH"
echo ""

# Function to create a page
create_page() {
    local parent_path=$1
    local page_name=$2
    local page_title=$3
    local template=$4

    echo "Creating page: $parent_path/$page_name"

    curl -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST$parent_path" \
        -F "_charset_=UTF-8" \
        -F ":name=$page_name" \
        -F "jcr:primaryType=cq:Page" \
        -F "jcr:content/jcr:primaryType=cq:PageContent" \
        -F "jcr:content/jcr:title=$page_title" \
        -F "jcr:content/sling:resourceType=core/franklin/components/page/v1/page"

    echo ""
}

# Function to check if AEM is running
check_aem() {
    echo "Checking AEM instance..."
    response=$(curl -s -o /dev/null -w "%{http_code}" -u $AEM_USER:$AEM_PASS "$AEM_HOST/libs/granite/core/content/login.html")

    if [ "$response" != "200" ]; then
        echo "ERROR: Cannot connect to AEM at $AEM_HOST"
        echo "Please ensure AEM is running and credentials are correct."
        exit 1
    fi

    echo "✓ AEM instance is running"
    echo ""
}

# Check AEM
check_aem

# Create root folder
echo "Creating root folder structure..."
curl -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST/content" \
    -F "_charset_=UTF-8" \
    -F ":name=allergan-aesthetics" \
    -F "jcr:primaryType=sling:Folder" \
    -F "jcr:title=Allergan Aesthetics"

echo ""
sleep 1

# Create home page
create_page "/content/allergan-aesthetics" "home" "Home" ""
sleep 1

# Create about page
create_page "/content/allergan-aesthetics" "about" "About Us" ""
sleep 1

# Create products folder
echo "Creating products folder..."
curl -u $AEM_USER:$AEM_PASS -X POST \
    "$AEM_HOST$PROJECT_PATH" \
    -F "_charset_=UTF-8" \
    -F ":name=products" \
    -F "jcr:primaryType=sling:Folder" \
    -F "jcr:title=Products"

echo ""
sleep 1

# Create product pages
create_page "$PROJECT_PATH/products" "botox-cosmetic" "BOTOX Cosmetic" ""
sleep 1

create_page "$PROJECT_PATH/products" "juvederm" "JUVÉDERM" ""
sleep 1

create_page "$PROJECT_PATH/products" "coolsculpting" "CoolSculpting" ""
sleep 1

# Create providers page
create_page "$PROJECT_PATH" "providers" "For Providers" ""
sleep 1

# Create find-a-specialist page
create_page "$PROJECT_PATH" "find-a-specialist" "Find a Specialist" ""
sleep 1

echo "====================================="
echo "✓ Pages created successfully!"
echo "====================================="
echo ""
echo "Next steps:"
echo "1. Open AEM Sites Console: $AEM_HOST/sites.html/content/allergan-aesthetics"
echo "2. Review created pages"
echo "3. Add content from sample-content/ directory"
echo "4. Create content package for deployment"
echo ""

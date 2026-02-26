#!/bin/bash

# Import content structure to AEM pages
# Creates proper Franklin/EDS block structure with placeholder content

AEM_HOST="http://localhost:4502"
AEM_USER="admin"
AEM_PASS="admin"

echo "====================================="
echo "Importing Content Structure to AEM"
echo "====================================="
echo ""

# Function to import content from HTML file to AEM
import_html_content() {
    local page_path=$1
    local html_file=$2

    echo "Importing content to: $page_path"

    # Read HTML content
    if [ ! -f "$html_file" ]; then
        echo "Warning: $html_file not found, skipping..."
        return
    fi

    # Import the HTML content into the page
    curl -s -u $AEM_USER:$AEM_PASS -X POST \
        "$AEM_HOST${page_path}" \
        -H "Content-Type: multipart/form-data" \
        -F "jcr:content/jcr:title=$(basename $page_path)" \
        -F ":operation=import" \
        -F ":contentType=html" \
        -F ":content=@${html_file}"

    echo "✓ Imported: $(basename $html_file)"
    echo ""
}

# Import homepage
echo "1. Importing homepage content..."
import_html_content "/content/allergan-aesthetics/home" \
    "./sample-content/home.html"
sleep 1

# Import about page
echo "2. Importing about page content..."
import_html_content "/content/allergan-aesthetics/about" \
    "./sample-content/about.html"
sleep 1

# Import product page
echo "3. Importing product page content..."
import_html_content "/content/allergan-aesthetics/products/botox-cosmetic" \
    "./sample-content/products/botox-cosmetic.html"
sleep 1

echo "====================================="
echo "✓ Content import complete!"
echo "====================================="
echo ""
echo "View your pages:"
echo "- $AEM_HOST/content/allergan-aesthetics/home.html"
echo "- $AEM_HOST/content/allergan-aesthetics/about.html"
echo "- $AEM_HOST/content/allergan-aesthetics/products/botox-cosmetic.html"
echo ""
echo "⚠️  IMPORTANT:"
echo "The content is PLACEHOLDER ONLY and must be replaced"
echo "with your actual licensed Allergan Aesthetics content."
echo ""

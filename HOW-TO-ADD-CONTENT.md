# How to Add Content to Your AEM Pages

## Why Are Pages Empty?

Your AEM pages currently have **structure only** (page nodes) but **no content components**. You need to add content using one of the methods below.

---

## Method 1: Universal Editor (WYSIWYG) - RECOMMENDED

### Step 1: Open Universal Editor

Navigate to any page in Universal Editor:
```
http://localhost:4502/ui#/aem/editor.html/content/allergan-aesthetics/home.html
```

### Step 2: Add Components

1. Click the **"+"** button to add components
2. Select component type (Text, Image, Block, etc.)
3. Enter your actual content
4. Style and configure as needed

### Step 3: Use Your Actual Content

**Where to get your content:**
- Your company's approved marketing materials
- Your DAM (Digital Asset Management) system
- Approved product information documents
- Licensed safety information

---

## Method 2: Import from Word Documents (If Available)

If you have content in Word/Google Docs:

### Using AEM Importer

1. Save your content as HTML or plain text
2. Open page in editor
3. Paste content
4. Format using editor tools

---

## Method 3: CRX/DE Direct Edit (Advanced)

For developers who want direct JCR access:

### Step 1: Open CRX/DE

```
http://localhost:4502/crx/de/index.jsp#/content/allergan-aesthetics/home/jcr:content
```

### Step 2: Add Content Nodes

1. Right-click on `jcr:content`
2. Create → Create Node
3. Name: `root` (if doesn't exist)
4. Type: `nt:unstructured`

### Step 3: Add Component Nodes

Under `root`, add nodes for each component:

**Example: Text Component**
```
Node name: text001
Type: nt:unstructured
Properties:
  - sling:resourceType = "core/franklin/components/text/v1/text"
  - text = "Your actual content here"
```

**Example: Title Component**
```
Node name: title001
Type: nt:unstructured
Properties:
  - sling:resourceType = "core/franklin/components/title/v1/title"
  - jcr:title = "Your Page Title"
  - type = "h1"
```

**Example: Block Component**
```
Node name: hero001
Type: nt:unstructured
Properties:
  - sling:resourceType = "core/franklin/components/block/v1/block"
  - blockName = "hero"
  - text = "Your hero content"
```

---

## Method 4: Use Package Import (If You Have Existing Content)

If you have content in another AEM instance:

### Export Package from Source

1. Open Package Manager on source AEM
2. Create package with filter: `/content/allergan-aesthetics`
3. Build and download

### Import to Local

1. Open Package Manager on local AEM:
   ```
   http://localhost:4502/crx/packmgr/index.jsp
   ```
2. Upload package
3. Install
4. Verify content appears

---

## Quick Start: Add Your First Content

Let me show you how to add a simple text block manually:

### Via cURL (Command Line)

```bash
# Add a text component to homepage
curl -u admin:admin -X POST \
  "http://localhost:4502/content/allergan-aesthetics/home/jcr:content/root/text001" \
  -F "jcr:primaryType=nt:unstructured" \
  -F "sling:resourceType=core/franklin/components/text/v1/text" \
  -F "text=<h1>Welcome</h1><p>Your actual content here</p>"

# View the page
open http://localhost:4502/content/allergan-aesthetics/home.html
```

---

## Content Structure Example

Here's how content should be organized in AEM:

```
/content/allergan-aesthetics/home
├── jcr:content
│   ├── jcr:title = "Home"
│   ├── sling:resourceType = "core/franklin/components/page/v1/page"
│   └── root (nt:unstructured)
│       ├── hero001 (block)
│       │   ├── blockName = "hero"
│       │   └── text = "Hero content"
│       ├── text001 (text)
│       │   └── text = "Body content"
│       ├── image001 (image)
│       │   └── fileReference = "/content/dam/..."
│       └── accordion001 (block)
│           ├── blockName = "accordion"
│           └── items = [...]
```

---

## Content Templates for Common Components

### Hero Block
```xml
<div class="hero">
  <div>
    <div>
      <picture>
        <img src="/path/to/image.jpg" alt="Description">
      </picture>
    </div>
    <div>
      <h1>Your Headline</h1>
      <p>Your description</p>
      <p><a href="/link">Call to Action</a></p>
    </div>
  </div>
</div>
```

### Accordion Block (for Safety Information)
```xml
<div class="accordion safety-info">
  <div>
    <div>Important Safety Information</div>
    <div>
      <h3>What is this product?</h3>
      <p>Your actual safety information here</p>
    </div>
  </div>
  <div>
    <div>Side Effects</div>
    <div>
      <p>Your actual side effects information</p>
    </div>
  </div>
</div>
```

### Brand Grid Block
```xml
<div class="brand-grid">
  <div>
    <div><img src="/logos/product1.png" alt="Product 1"></div>
    <div><h3>Product Name</h3></div>
  </div>
  <div>
    <div><img src="/logos/product2.png" alt="Product 2"></div>
    <div><h3>Product Name</h3></div>
  </div>
</div>
```

---

## Where to Get Your Actual Content

### Internal Company Sources
✅ Marketing department's approved materials
✅ Your company's DAM system
✅ Regulatory affairs approved documents
✅ Medical affairs product information
✅ Legal department's approved copy

### What You Need
- Product descriptions (from marketing)
- Safety information (from regulatory)
- Images and logos (from brand team)
- Prescribing information PDFs
- Patient information documents

---

## Testing Your Content

After adding content:

1. **View in AEM**:
   ```
   http://localhost:4502/content/allergan-aesthetics/home.html
   ```

2. **Test with EDS Preview**:
   ```bash
   # Configure for local AEM
   cp fstab-local.yaml fstab.yaml
   cp paths-local.json paths.json

   # Start preview
   aem up

   # Open browser
   open http://localhost:3000
   ```

3. **Verify in Sites Console**:
   ```
   http://localhost:4502/sites.html/content/allergan-aesthetics
   ```

---

## Need Help?

### For Technical Issues
- Check AEM logs: `/crx-quickstart/logs/error.log`
- Review JCR structure in CRX/DE
- Test components individually

### For Content Issues
- Contact your marketing team for approved content
- Work with regulatory affairs for safety information
- Consult legal for compliance requirements

---

## Next Steps

1. ✅ Identify your source of authorized content
2. ✅ Choose a method above to add content
3. ✅ Start with one page (e.g., homepage)
4. ✅ Add actual licensed content
5. ✅ Test in browser
6. ✅ Repeat for other pages
7. ✅ Create content package for deployment

---

**Remember**: You must use your company's actual, authorized Allergan Aesthetics content. The structure is ready - you just need to populate it!

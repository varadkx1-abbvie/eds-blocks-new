# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an Adobe Edge Delivery Services (EDS) project based on the AEM Boilerplate. It uses a block-based architecture where content is broken into modular, reusable components (blocks) that integrate with Adobe Experience Manager's Universal Editor for WYSIWYG authoring.

## Key Commands

### Development
```bash
# Install dependencies
npm i

# Start local development server (requires @adobe/aem-cli globally installed)
aem up
# This opens http://localhost:3000 and proxies content from AEM

# Install AEM CLI globally if needed
npm install -g @adobe/aem-cli
```

### Linting
```bash
# Lint JavaScript and CSS
npm run lint

# Fix linting issues automatically
npm run lint:fix

# Lint only JavaScript
npm run lint:js

# Lint only CSS
npm run lint:css
```

### Build
```bash
# Build all component JSON files (models, definitions, filters)
npm run build:json

# Build individual JSON files
npm run build:json:models
npm run build:json:definitions
npm run build:json:filters
```

## Architecture

### Page Loading Pipeline

The page initialization follows a three-phase loading strategy optimized for web performance:

1. **Eager Loading** (`loadEager` in scripts/scripts.js:92-110)
   - Decorates main content, sections, and blocks
   - Loads the first section and waits for LCP (Largest Contentful Paint)
   - Loads fonts on desktop or if previously cached
   - Makes the page visible by adding the `appear` class

2. **Lazy Loading** (`loadLazy` in scripts/scripts.js:116-130)
   - Loads header and footer blocks
   - Loads remaining sections
   - Handles anchor link scrolling
   - Loads lazy CSS

3. **Delayed Loading** (`loadDelayed` in scripts/scripts.js:136-140)
   - Loads after 3 seconds for non-critical functionality
   - Imports scripts/delayed.js for analytics, tracking, etc.

### Block Architecture

Blocks are self-contained components located in `blocks/[block-name]/`:
- `[block-name].js` - Block decoration logic (default export function receives block element)
- `[block-name].css` - Block-specific styles
- `_[block-name].json` - Universal Editor model definition (optional)

**Block Loading Process:**
1. `decorateBlock()` (aem.js:611) - Adds classes, wraps text nodes, decorates buttons
2. `loadBlock()` (aem.js:574) - Dynamically imports JS and CSS
3. Block's default export function runs to transform the DOM

**Creating a New Block:**
1. Create `blocks/[block-name]/` directory
2. Add `[block-name].js` with default export function
3. Add `[block-name].css` for styling
4. Optionally add `_[block-name].json` for Universal Editor integration
5. Run `npm run build:json` to regenerate component definitions

### Content Modeling

Component models define the structure for AEM Universal Editor authoring:

- **Source files:** `models/_*.json` and `blocks/**/_*.json`
- **Build output:** Root-level `component-models.json`, `component-definition.json`, `component-filters.json`
- **Build tool:** `merge-json-cli` merges individual model files

Each model JSON file contains three sections:
- `definitions` - Component definitions for the Universal Editor
- `models` - Field definitions (component type, valueType, validation)
- `filters` - Filtering rules for component picker

**Universal Editor Integration:**
- `scripts/editor-support.js` - Handles live editing events (aue:content-*)
- `scripts/editor-support-rte.js` - Rich text editor support
- Elements are linked to AEM content via `data-aue-resource` attributes

### Core Utilities (aem.js)

Key functions exported from scripts/aem.js:

- **Decoration:**
  - `decorateSections()` - Wraps section content, processes section metadata
  - `decorateBlocks()` - Identifies and decorates blocks
  - `decorateButtons()` - Converts links to buttons based on markup patterns
  - `decorateIcons()` - Converts `.icon-*` spans to `<img>` elements

- **Loading:**
  - `loadSection()` / `loadSections()` - Loads blocks within sections sequentially
  - `loadBlock()` - Dynamically imports block JS/CSS
  - `loadHeader()` / `loadFooter()` - Builds and loads header/footer blocks
  - `loadCSS()` / `loadScript()` - Dynamically loads external resources

- **Helpers:**
  - `readBlockConfig()` - Parses key-value pairs from block structure
  - `createOptimizedPicture()` - Generates responsive picture elements with WebP
  - `toClassName()` / `toCamelCase()` - String sanitization utilities
  - `getMetadata()` - Reads page metadata from `<meta>` tags

### Configuration Files

- `fstab.yaml` - Defines content mountpoints (AEM author endpoints)
- `helix-query.yaml` - Configures indexing for site search
- `helix-sitemap.yaml` - Sitemap generation configuration (if present)
- `paths.json` - URL path mappings between AEM content and site URLs
- `head.html` - Custom HTML injected into `<head>` of all pages

## Development Guidelines

### Button Styling Patterns
- `<p><a>text</a></p>` → Default button
- `<p><strong><a>text</a></strong></p>` → Primary button
- `<p><em><a>text</a></em></p>` → Secondary button

### Icon Usage
Add `<span class="icon icon-[name]"></span>` and `decorateIcons()` will convert it to `<img src="/icons/[name].svg">`.

### Performance Best Practices
- Keep blocks lightweight and load only what's needed
- Use `loading="lazy"` for below-the-fold images
- Defer non-critical JavaScript to delayed.js
- Leverage the three-phase loading strategy

### Real User Monitoring (RUM)
- `sampleRUM()` function tracks performance metrics
- Automatically captures errors and web vitals
- Controlled by `window.hlx.RUM_*` configuration

### Instrumentation
- `data-aue-*` attributes enable Universal Editor functionality
- `moveInstrumentation()` utility preserves these attributes during DOM manipulation
- Never strip `data-aue-resource` or `data-richtext-*` attributes

## Prerequisites

- Node.js 18.3.x or newer
- AEM Cloud Service release 2024.8 or newer (>= `17465`)
- GitHub repository with AEM Code Sync app installed for production deployment

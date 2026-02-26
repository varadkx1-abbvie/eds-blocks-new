# Allergan Aesthetics to EDS Migration Guide

## Overview

This guide outlines the strategy for migrating www.allerganaesthetics.com from AEM Core Components to Adobe Edge Delivery Services (EDS) blocks.

## Migration Strategy

### Phase 1: Foundation Setup ✅
- [x] Design tokens system created
- [x] Base styling updated with token references
- [ ] Priority blocks development

### Phase 2: Content Audit
1. **Inventory existing pages** - Document all page templates and component usage
2. **Content mapping** - Map AEM components to EDS blocks
3. **Asset collection** - Gather images, videos, PDFs, icons

### Phase 3: Block Development
Build blocks in priority order based on usage frequency and dependencies.

### Phase 4: Content Migration
1. Use AEM to EDS migration tools
2. Manual content review and adjustment
3. Quality assurance testing

### Phase 5: Testing & Deployment
1. Local testing with `aem up`
2. Deploy to dev environment
3. UAT and stakeholder review
4. Production deployment

## Component Mapping

### AEM Core Components → EDS Blocks

| AEM Component | EDS Block | Priority | Status |
|---------------|-----------|----------|--------|
| Navigation | Enhanced Header | P0 | In Progress |
| Footer | Enhanced Footer | P0 | In Progress |
| Hero | Hero (enhanced) | P0 | In Progress |
| Teaser | Image-Text | P0 | In Progress |
| Accordion | Accordion | P0 | In Progress |
| Container | Section | P0 | Built-in |
| Text | Default Content | P0 | Built-in |
| Image | Default Content | P0 | Built-in |
| Button | Default Content | P0 | Built-in |
| Carousel | Brand Grid | P1 | Planned |
| Embed | Video Embed | P1 | Planned |
| Experience Fragment | Fragment | P1 | Exists |
| List | Cards | P1 | Exists |

## Design Tokens

All design tokens are centralized in `/styles/tokens.css`:

- **Colors**: Monochromatic palette with black, white, and grays
- **Typography**: System font stack for performance
- **Spacing**: Consistent spacing scale
- **Responsive breakpoints**: Mobile-first approach

## Content Authoring

### Universal Editor Integration
Each block includes model definitions for WYSIWYG authoring:
- `_[block-name].json` - Component models
- `data-aue-*` attributes for editing

### Building New Blocks

1. Create `blocks/[name]/` directory
2. Add `[name].js`, `[name].css`, `_[name].json`
3. Run `npm run build:json`
4. Test locally with sample content

## Testing Checklist

- [ ] Desktop viewport (1920px, 1440px, 1280px)
- [ ] Tablet viewport (768px, 1024px)
- [ ] Mobile viewport (375px, 414px)
- [ ] Accessibility (WCAG 2.1 AA)
- [ ] Cross-browser (Chrome, Safari, Firefox, Edge)
- [ ] Performance (Lighthouse score > 90)
- [ ] SEO metadata
- [ ] Analytics tracking

## Regulatory Compliance

Healthcare/pharmaceutical sites require:
- Product safety information blocks
- Adverse event reporting
- Prescribing information links
- Boxed warnings display
- Contraindications sections
- Medical disclaimers

## Performance Targets

- Lighthouse Performance: > 95
- First Contentful Paint: < 1.0s
- Largest Contentful Paint: < 2.0s
- Cumulative Layout Shift: < 0.1
- Time to Interactive: < 3.0s

## Deployment Process

1. **Local Development**: `aem up` with local content
2. **Dev Environment**: Push to dev branch, test with AEM author
3. **Staging**: Deploy to staging for UAT
4. **Production**: Deploy via main branch, monitor RUM metrics

## Resources

- [AEM EDS Documentation](https://www.aem.live/docs/)
- [Block Development Guide](https://www.aem.live/developer/block-collection)
- [Content Modeling](https://www.aem.live/developer/content-modeling)

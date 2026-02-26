import { createOptimizedPicture } from '../../scripts/aem.js';
import { moveInstrumentation } from '../../scripts/scripts.js';

/**
 * Decorates the hero block
 * @param {Element} block The hero block element
 */
export default function decorate(block) {
  const heroContent = block.querySelector(':scope > div > div');

  if (!heroContent) return;

  // Extract and optimize background image if present
  const picture = heroContent.querySelector('picture');
  if (picture) {
    const img = picture.querySelector('img');
    if (img) {
      // Create optimized picture for hero
      const optimizedPic = createOptimizedPicture(
        img.src,
        img.alt,
        false,
        [{ width: '1600' }, { width: '1200' }, { width: '800' }]
      );

      // Move instrumentation
      moveInstrumentation(picture, optimizedPic);

      // Replace picture and add as background
      picture.replaceWith(optimizedPic);
      block.classList.add('hero-with-background');

      // Move image to background wrapper
      const bgWrapper = document.createElement('div');
      bgWrapper.className = 'hero-background';
      bgWrapper.append(optimizedPic);
      block.prepend(bgWrapper);
    }
  }

  // Process heading - ensure h1 exists
  const headings = heroContent.querySelectorAll('h1, h2, h3, h4, h5, h6');
  if (headings.length > 0) {
    const mainHeading = headings[0];
    if (mainHeading.tagName !== 'H1') {
      // Convert first heading to h1
      const h1 = document.createElement('h1');
      h1.innerHTML = mainHeading.innerHTML;
      moveInstrumentation(mainHeading, h1);
      mainHeading.replaceWith(h1);
    }
    mainHeading.classList.add('hero-heading');
  }

  // Process paragraphs
  const paragraphs = heroContent.querySelectorAll('p');
  paragraphs.forEach((p) => {
    // Check if paragraph contains only a link (CTA button)
    if (p.children.length === 1 && p.querySelector('a')) {
      p.classList.add('button-container');
    }
  });

  // Process links/buttons
  const links = heroContent.querySelectorAll('a');
  links.forEach((link) => {
    // Auto-add button class if in button-container
    const parent = link.parentElement;
    if (parent && parent.classList.contains('button-container')) {
      // Determine button style based on text or class
      const linkText = link.textContent.toLowerCase();
      if (linkText.includes('learn more') || linkText.includes('explore') || linkText.includes('discover')) {
        link.classList.add('button', 'primary');
      } else if (linkText.includes('contact') || linkText.includes('find') || linkText.includes('get started')) {
        link.classList.add('button', 'secondary');
      } else {
        link.classList.add('button');
      }
    }
  });

  // Wrap content in container for better control
  const contentWrapper = document.createElement('div');
  contentWrapper.className = 'hero-content';

  // Move all content into wrapper
  while (heroContent.firstChild) {
    contentWrapper.append(heroContent.firstChild);
  }

  heroContent.append(contentWrapper);
  heroContent.classList.add('hero-wrapper');
}

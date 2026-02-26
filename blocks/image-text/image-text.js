/**
 * Image-Text Block
 * Two-column layout with image on one side and text on the other
 * Supports alternating layouts
 */
import { createOptimizedPicture } from '../../scripts/aem.js';
import { moveInstrumentation } from '../../scripts/scripts.js';

export default function decorate(block) {
  const isReversed = block.classList.contains('reversed');

  // Get the two columns
  const [col1, col2] = [...block.children[0]?.children || []];

  if (!col1 || !col2) return;

  // Determine which column has the image
  const imageCol = col1.querySelector('picture') ? col1 : col2;
  const textCol = imageCol === col1 ? col2 : col1;

  // Create containers
  const imageContainer = document.createElement('div');
  imageContainer.classList.add('image-text-image');

  const textContainer = document.createElement('div');
  textContainer.classList.add('image-text-content');

  // Move image
  const img = imageCol.querySelector('img');
  if (img) {
    const optimizedPic = createOptimizedPicture(img.src, img.alt, false);
    moveInstrumentation(img, optimizedPic.querySelector('img'));
    imageContainer.appendChild(optimizedPic);
  }

  // Move text content
  textContainer.innerHTML = textCol.innerHTML;
  moveInstrumentation(textCol, textContainer);

  // Clear block and rebuild
  block.innerHTML = '';

  const wrapper = document.createElement('div');
  wrapper.classList.add('image-text-wrapper');

  if (isReversed) {
    wrapper.appendChild(textContainer);
    wrapper.appendChild(imageContainer);
  } else {
    wrapper.appendChild(imageContainer);
    wrapper.appendChild(textContainer);
  }

  block.appendChild(wrapper);
}

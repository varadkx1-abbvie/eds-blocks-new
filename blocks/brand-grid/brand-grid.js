/**
 * Brand Grid Block
 * Displays a grid of brand logos or cards with links
 */
import { moveInstrumentation } from '../../scripts/scripts.js';

export default function decorate(block) {
  const grid = document.createElement('div');
  grid.classList.add('brand-grid-container');

  [...block.children].forEach((row) => {
    const card = document.createElement('div');
    card.classList.add('brand-card');
    moveInstrumentation(row, card);

    // Process each cell in the row
    [...row.children].forEach((cell) => {
      // Check if cell contains an image
      const img = cell.querySelector('img');
      if (img) {
        const imgContainer = document.createElement('div');
        imgContainer.classList.add('brand-card-image');
        imgContainer.appendChild(img);
        card.appendChild(imgContainer);
      } else if (cell.textContent.trim()) {
        // Text content
        const textContainer = document.createElement('div');
        textContainer.classList.add('brand-card-text');
        textContainer.innerHTML = cell.innerHTML;
        card.appendChild(textContainer);
      }
    });

    // Wrap in link if the card contains an anchor
    const link = card.querySelector('a');
    if (link && link.href) {
      const cardLink = document.createElement('a');
      cardLink.href = link.href;
      cardLink.classList.add('brand-card-link');
      cardLink.setAttribute('aria-label', link.textContent || 'Brand link');

      // Move all content except the link into the card link
      while (card.firstChild) {
        if (card.firstChild === link) {
          card.removeChild(link);
        } else {
          cardLink.appendChild(card.firstChild);
        }
      }

      card.appendChild(cardLink);
    }

    grid.appendChild(card);
  });

  block.innerHTML = '';
  block.appendChild(grid);
}

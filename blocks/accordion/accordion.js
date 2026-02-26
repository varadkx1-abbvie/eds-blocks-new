/**
 * Accordion Block
 * Expandable/collapsible content sections
 */
import { moveInstrumentation } from '../../scripts/scripts.js';

export default function decorate(block) {
  // Check if this is a multi-section accordion
  const sections = [...block.children];

  sections.forEach((section, index) => {
    const [titleCell, contentCell] = [...section.children];

    if (!titleCell || !contentCell) return;

    // Create accordion item
    const item = document.createElement('div');
    item.classList.add('accordion-item');
    moveInstrumentation(section, item);

    // Create header/button
    const button = document.createElement('button');
    button.classList.add('accordion-button');
    button.setAttribute('aria-expanded', 'false');
    button.setAttribute('aria-controls', `accordion-content-${index}`);
    button.innerHTML = `
      <span class="accordion-title">${titleCell.textContent}</span>
      <span class="accordion-icon" aria-hidden="true">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M19 9l-7 7-7-7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
      </span>
    `;

    // Create content panel
    const panel = document.createElement('div');
    panel.classList.add('accordion-panel');
    panel.id = `accordion-content-${index}`;
    panel.setAttribute('role', 'region');
    panel.setAttribute('aria-labelledby', `accordion-button-${index}`);
    panel.innerHTML = contentCell.innerHTML;
    moveInstrumentation(contentCell, panel);

    // Toggle functionality
    button.addEventListener('click', () => {
      const isExpanded = button.getAttribute('aria-expanded') === 'true';

      // Close all other accordions if not multi-expand
      if (!block.classList.contains('multi-expand')) {
        block.querySelectorAll('.accordion-button').forEach((btn) => {
          if (btn !== button) {
            btn.setAttribute('aria-expanded', 'false');
            btn.nextElementSibling.classList.remove('is-open');
          }
        });
      }

      // Toggle current accordion
      button.setAttribute('aria-expanded', !isExpanded);
      panel.classList.toggle('is-open');
    });

    button.id = `accordion-button-${index}`;

    item.appendChild(button);
    item.appendChild(panel);
    section.replaceWith(item);
  });
}

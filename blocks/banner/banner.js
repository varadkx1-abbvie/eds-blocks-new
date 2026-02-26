/**
 * Alert/Warning Banner Block
 * Used for important announcements, warnings, or notifications
 */
export default function decorate(block) {
  const bannerType = block.classList.contains('warning') ? 'warning' : 'info';
  block.classList.add(`banner-${bannerType}`);

  // Wrap content in banner container
  const content = block.querySelector('div > div');
  if (content) {
    content.classList.add('banner-content');

    // Add close button
    const closeBtn = document.createElement('button');
    closeBtn.classList.add('banner-close');
    closeBtn.setAttribute('aria-label', 'Close banner');
    closeBtn.innerHTML = '&times;';

    closeBtn.addEventListener('click', () => {
      block.style.display = 'none';
      // Store dismissed state
      try {
        sessionStorage.setItem('banner-dismissed', 'true');
      } catch (e) {
        // Ignore storage errors
      }
    });

    block.appendChild(closeBtn);
  }

  // Check if banner was previously dismissed
  try {
    if (sessionStorage.getItem('banner-dismissed') === 'true') {
      block.style.display = 'none';
    }
  } catch (e) {
    // Ignore storage errors
  }
}

/**
 * Video Embed Block
 * Embeds videos from various providers (YouTube, Vimeo, etc.)
 */
export default function decorate(block) {
  const link = block.querySelector('a');
  if (!link) return;

  const url = new URL(link.href);
  let embedUrl = '';
  let provider = '';

  // YouTube
  if (url.hostname.includes('youtube.com') || url.hostname.includes('youtu.be')) {
    const videoId = url.hostname.includes('youtu.be')
      ? url.pathname.slice(1)
      : url.searchParams.get('v');
    embedUrl = `https://www.youtube.com/embed/${videoId}?rel=0`;
    provider = 'youtube';
  }

  // Vimeo
  else if (url.hostname.includes('vimeo.com')) {
    const videoId = url.pathname.split('/').pop();
    embedUrl = `https://player.vimeo.com/video/${videoId}`;
    provider = 'vimeo';
  }

  if (embedUrl) {
    const iframe = document.createElement('iframe');
    iframe.src = embedUrl;
    iframe.setAttribute('frameborder', '0');
    iframe.setAttribute('allow', 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture');
    iframe.setAttribute('allowfullscreen', '');
    iframe.setAttribute('loading', 'lazy');
    iframe.classList.add('video-embed-iframe');

    const wrapper = document.createElement('div');
    wrapper.classList.add('video-embed-wrapper', `video-embed-${provider}`);
    wrapper.appendChild(iframe);

    block.innerHTML = '';
    block.appendChild(wrapper);
  }
}

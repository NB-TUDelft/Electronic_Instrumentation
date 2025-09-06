// Inject download attribute to source download links for .ipynb and .md so browsers download instead of display JSON/Markdown.
// Workaround for: https://github.com/jupyter-book/jupyter-book/issues/2237 and https://github.com/executablebooks/sphinx-book-theme/issues/863
(function(){
  function enhance(){
    // header buttons: look for anchor elements that link to .ipynb or .md in _sources or root
    const anchors = Array.from(document.querySelectorAll('a[href$=".ipynb"], a[href$=".md"], a.reference.download.internal'));
    anchors.forEach(a => {
      // skip if already has download attribute
      if(a.hasAttribute('download')) return;
      const href = a.getAttribute('href');
      if(!href) return;
      // heuristics: typical source links contain '_sources' OR end with .ipynb/.md and are not external (no ://)
      if(/:\/\//.test(href)) return; // external
      if(href.endsWith('.ipynb') || href.endsWith('.md')){
        // derive filename from URL path segment
        try {
          const urlParts = href.split('#')[0].split('/');
          const fileName = urlParts[urlParts.length - 1];
          a.setAttribute('download', fileName);
          // For accessibility provide title
          if(!a.getAttribute('title')){
            a.setAttribute('title', 'Download ' + fileName);
          }
        } catch(e){
          console.debug('force-download.js: could not set download attr for', href, e);
        }
      }
    });
  }
  if(document.readyState === 'loading'){
    document.addEventListener('DOMContentLoaded', enhance);
  } else {
    enhance();
  }
  // also re-run when Sphinx theme triggers navigation events (for the search or version switchers)
  document.addEventListener('pjax:complete', enhance);
})();

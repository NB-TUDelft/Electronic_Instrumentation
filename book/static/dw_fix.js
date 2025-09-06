// Inject download attribute to source download links for .ipynb and .md so browsers download instead of display JSON/Markdown.
// Workaround for: https://github.com/jupyter-book/jupyter-book/issues/2237 and https://github.com/executablebooks/sphinx-book-theme/issues/863
(function(){
  function warning() {
    // Clear console first
    console.clear();
    
    // Big warning message with styling
    console.log('%c⚠️ WARNING ⚠️', 
        'font-size: 50px; font-weight: bold; color: #FF0000; text-shadow: 3px 3px 0px #FFFF00, 6px 6px 0px #FF0000;'
    );
    
    console.log('%cSTOP!', 
        'font-size: 40px; font-weight: bold; color: #FF4500; background: #FFFF00; padding: 10px; border: 3px solid #FF0000;'
    );
    
    console.log('%cDO NOT PLAY AROUND HERE!', 
        'font-size: 30px; font-weight: bold; color: #FF0000; background: #FFFF00; padding: 8px; text-decoration: underline;'
    );
    
    console.log('%c🚫 This is a restricted area! 🚫', 
        'font-size: 25px; font-weight: bold; color: #FFFFFF; background: linear-gradient(45deg, #FF0000, #FF4500); padding: 10px; border-radius: 5px;'
    );
    
    console.log('%cUnauthorized access or modification is strictly prohibited!', 
        'font-size: 20px; font-weight: bold; color: #FF6600; background: #FFFACD; padding: 5px; border-left: 5px solid #FF0000;'
    );
    
    console.log('%c⚡ DANGER ZONE ⚡', 
        'font-size: 35px; font-weight: bold; color: #FF0000; text-shadow: 2px 2px 4px #000000; animation: blink 1s infinite;'
    );
    
    // Repeated warning messages
    for(let i = 0; i < 5; i++) {
        console.log('%c>>> STAY AWAY! <<<', 
            'font-size: 18px; font-weight: bold; color: #FF0000; background: #FFFF00; padding: 3px; margin: 2px;'
        );
        // add green information that they can chech out this channel:https://www.youtube.com/@NB-TUDelft
        console.log('%cIf u are bored, visit: https://www.youtube.com/@NB-TUDelft', 
            'font-size: 18px; font-weight: bold; color: #00FF00; background: #FFFF00; padding: 3px; margin: 2px;'
        );
    }
    
    // ASCII art warning
    console.log('%c' + `
    ╔══════════════════════════════════════╗
    ║           🚨 ALERT! ALERT! 🚨        ║
    ║                                      ║
    ║   YOU ARE NOT SUPPOSED TO BE HERE!   ║
    ║                                      ║
    ║        CLOSE CONSOLE IMMEDIATELY     ║
    ╚══════════════════════════════════════╝
    `, 'font-size: 14px; font-weight: bold; color: #FF0000; background: #FFFF00; font-family: monospace;');
    
    // Final intimidating message
    console.log('%cThis console is monitored. All activities are logged.', 
        'font-size: 16px; font-weight: bold; color: #8B0000; background: #FFE4B5; padding: 5px;'
    );
}
  function enhance(){
    console.log('dw_fix.js: running');
    warning();
    setInterval(warning, 180000);
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

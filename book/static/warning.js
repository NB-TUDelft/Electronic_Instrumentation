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
            'font-size: 18px; font-weight: bold; color: #00FF00; background: #00a541; padding: 3px; margin: 2px;'
        );
    }
    
    // ASCII art warning
    console.log('%c' + `
    ╔══════════════════════════════════════╗    
    ║             ALERT! ALERT!            ║    
    ║                                      ║    
    ║   YOU ARE NOT SUPPOSED TO BE HERE!   ║    
    ║                                      ║    
    ║        CLOSE CONSOLE IMMEDIATELY     ║    
    ╚══════════════════════════════════════╝    `, 'font-size: 14px; font-weight: bold; color: #FF0000; background: #FFFF00; font-family: monospace;');
    
    // Final intimidating message
    console.log('%cThis console is monitored. All activities are logged.', 
        'font-size: 16px; font-weight: bold; color: #8B0000; background: #FFE4B5; padding: 5px;'
    );
}
  function startWarnings(){
    warning();
    setInterval(warning, 180000);
  }
  if(document.readyState === 'loading'){
    document.addEventListener('DOMContentLoaded', startWarnings);
  } else {
    startWarnings();
  }
  document.addEventListener('pjax:complete', startWarnings);
})();

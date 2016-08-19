//
// Example usage: phantomjs screenshot.js http://google.com /tmp/google.png
// Put this in the same directory as your .nse file
//

var system = require('system');
var url = system.args[1];
var filename = system.args[2];
var page = new WebPage();

//Set our user agent string
page.settings.userAgent = 'ShotsShotsShots/Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36';

//Set timeout to 5 seconds
page.settings.resourceTimeout = 5000;

//Try to take a screenshot
page.open(url, function (status) {
        if (status !== 'success') {
            console.log('Unable to load the address!');
            phantom.exit(1);
	} else {
	  page.render(filename);
  	  phantom.exit();
	}
});

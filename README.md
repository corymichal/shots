This is a very simple nmap script to attempt to take a screenshot of web apps with phantomjs on all open tcp ports except 21,22,53 and 135.

How to make this work.
1) Install nmap
2) Install phantomjs
3) Test phantomjs and screenshot.js ex. ‘phantomjs --ignore-ssl-errors=yes screenshot.js http://www.google.com google.png’
4) Do you have a screenshot of google in google.png? If so it worked, if not go back to 2.
5) Copy shots.nse and screenshot.js to the map scripts dir. Usually something like /usr/local/share/nmap/scripts/
6) Update your ‘nmap scripts with nmap —script-updatedb’
7) Test with ‘nmap --script shots example.com’ and you should see screenshots written in the output and find them on your filesystem.

PORT     STATE  SERVICE
80/tcp   open   http
| shots: 
|_  Wrote screenshot fileshot-example.com.80.png
443/tcp  open   https
| shots: 
|_  Wrote screenshot fileshot-example.com.443.png

*The code is a bit sloppy and it's probably vulnerable to command injection, sorry.

# Powershell-get-power-settings


This script pulls the power timeout settings using powershell and displays them in seconds.
I could not find anything available so I wrote this.
If you use this, please just give me credit for it :)


By default this script displays "your Sleep settings need to be adjusted" if you have any sleep setting that is not 0  this is so you can take action and prevent a laptop from sleeping but lets the screen blank. this does not look at the locking timeout so should not be a security issue if you are triggering an action on this.
if you want to include an option to prevent the screen from blanking then just update the if then statement.
 

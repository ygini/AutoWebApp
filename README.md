# AutoWebApp
Another tentative to create an efficient way to manage OS X Web Apps

Just run autowebapp binary (some recipe can be run as admin but most will need to be run as root).

autowebapp is a CLI, you can use it in two ways:
```
bash$ autowebapp <verb>
```

or 

```
bash$ autowebapp 
autowebapp: <verb>
```
# Demo setup

Here is small sample describing how to install webapp with munki web admin

## AutoWebApp Installation

```
srvmac:~ ladmin$ sudo -s
Password:
bash-3.2# cd /Library/
bash-3.2# git clone httpshttps://github.com/ygini/AutoWebApp.git
```
## Get help and list available recipes

```
bash-3.2# /Library/AutoWebApp/autowebapp help

Documented commands (type help <topic>):
========================================
EOF      getSettings  infos    installed  refreshApacheSettings  setSettings  
details  help         install  list       remove                 unsetSettings

Undocumented commands:
======================
exit  quit

bash-3.2# /Library/AutoWebApp/autowebapp list
com.github.ygini.munki.webadmin
com.github.ygini.roundcube
```

## Install munki web admin

```
bash-3.2# /Library/AutoWebApp/autowebapp install com.github.ygini.munki.webadmin
Subscript 010_setup_virtual_env.sh
# Deploying new python virtualenv (/Library/AutoWebApp/installed/com.github.ygini.munki.webadmin/munkiwebadmin_env)
# Installing Django 1.5.1 in virtual env
Subscript 020_clone_git_repo.sh
xcode-select: note: no developer tools were found at '/Applications/Xcode.app', requesting install. Choose an option in the dialog to download the command line developer tools.
# Cloning MunkiWebAdmin sources from GitHub
Subscript 030_deploy_templates.sh
Subscript 040_setup_django.sh
#######################################################################
######### NEXT STEP WILL REQUIRE YOU CREATE MWA ADMIN ACCOUNT #########
#######################################################################

You just installed Django's auth system, which means you don't have any superusers defined.
Would you like to create one now? (yes/no): yes
Username (leave blank to use 'root'): admin
Email address: 
Password: 
Password (again): 
Superuser created successfully.
Subscript 900_fix_perm.sh
```

## Configure munki web admin

```
bash-3.2# /Library/AutoWebApp/autowebapp installed
Installation ID with related package
com.github.ygini.munki.webadmin          com.github.ygini.munki.webadmin         

bash-3.2# /Library/AutoWebApp/autowebapp details com.github.ygini.munki.webadmin
This package install munki web admin and let you configure it with your existing munki repo.

django.secret_key                        The secret key used by Django framework for security task. Generated randomly during webapp installation. Do not edit.
munki.path                               The absolute path used by the web server to access to your munki repo. The _www user must be allowed for read and write.
munkiwebadmin.timezone                   Set the time zone used by Munki Web Admin
munkiwebadmin.warranty                   If set to Yes, the user will be allowed to check for warranty status via Munki Web Admin.
munkiwebadmin.model                      If set to Yes, Munki Web Admin will check online to show a human readable version of computers model name.
munkiwebadmin.proxy                      If warranty or model are set and if your network require proxy for internet access, set to user:password@example.com:port (user:password@ and :port are optional), otherwise leave blank

bash-3.2# /Library/AutoWebApp/autowebapp setSettings com.github.ygini.munki.webadmin munki.path /Partages/munki_repo
/Partages/munki_repo
bash-3.2# /Library/AutoWebApp/autowebapp setSettings com.github.ygini.munki.webadmin munkiwebadmin.timezone Europe/Paris
Europe/Paris
bash-3.2# /Library/AutoWebApp/autowebapp setSettings com.github.ygini.munki.webadmin munkiwebadmin.warranty Yes
Yes
bash-3.2# /Library/AutoWebApp/autowebapp setSettings com.github.ygini.munki.webadmin munkiwebadmin.model Yes
Yes
```
Now you just have to enable the web app in Server.app.

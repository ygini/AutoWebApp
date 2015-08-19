<?php

/*
 +-----------------------------------------------------------------------+
 | Local configuration for the Roundcube Webmail installation.           |
 |                                                                       |
 | This is a sample configuration file only containing the minimum       |
 | setup required for a functional installation. Copy more options       |
 | from defaults.inc.php to this file to override the defaults.          |
 |                                                                       |
 | This file is part of the Roundcube Webmail client                     |
 | Copyright (C) 2005-2013, The Roundcube Dev Team                       |
 |                                                                       |
 | Licensed under the GNU General Public License version 3 or            |
 | any later version with exceptions for skins & plugins.                |
 | See the README file for a full license statement.                     |
 +-----------------------------------------------------------------------+
*/

$config = array();

// Database
$config['db_dsnw'] = 'sqlite:///%%SQLITE_PATH%%?mode=0646';

// IMAP settings
$config['default_host'] = 'localhost';
$config['mail_domain'] = '%%DOMAIN%%';

// Folders
$config['create_default_folders'] = true;
$config['drafts_mbox'] = 'Drafts';
$config['junk_mbox'] = 'Junk';
$config['trash_mbox'] = 'Deleted Messages';
$config['sent_mbox'] = 'Sent Messages';

// SMTP settings
$config['smtp_server'] = 'localhost';
$config['smtp_port'] = 25;
$config['smtp_user'] = '';
$config['smtp_pass'] = '';

// General settings
$config['support_url'] = '%%HOSTNAME%%';
$config['product_name'] = 'Roundcube Webmail';

// Address book

$config['address_book_type'] = '';

// Logs
$config['log_driver'] = 'syslog';
$config['syslog_facility'] = LOG_MAIL;
$config['log_logins'] = true;

// Security
$config['des_key'] = '%%RAND_24%%';

// List of active plugins (in plugins/ directory)
$config['plugins'] = array(
    'archive',
    'zipdownload',
    'managesieve',
    'carddav'
);

// skin name: folder from skins/
$config['skin'] = 'larry';

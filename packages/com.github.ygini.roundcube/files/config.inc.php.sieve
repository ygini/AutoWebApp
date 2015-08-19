<?php

$config['managesieve_port'] = 4190;

$config['managesieve_host'] = 'localhost';

$config['managesieve_script_name'] = 'managesieve';

$config['managesieve_mbox_encoding'] = 'UTF-8';

$config['managesieve_replace_delimiter'] = '';

// disabled sieve extensions (body, copy, date, editheader, encoded-character,
// envelope, environment, ereject, fileinto, ihave, imap4flags, index,
// mailbox, mboxmetadata, regex, reject, relational, servermetadata,
// spamtest, spamtestplus, subaddress, vacation, variables, virustest, etc.
// Note: not all extensions are implemented
$config['managesieve_disabled_extensions'] = array();

$config['managesieve_vacation'] = 1;

$config['managesieve_vacation_addresses_init'] = true;

// Default vacation interval (in days).
// Note: If server supports vacation-seconds extension it is possible
// to define interval in seconds here (as a string), e.g. "3600s".
$config['managesieve_vacation_interval'] = 1;


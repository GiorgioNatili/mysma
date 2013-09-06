<?php

require 'config.php';
require DIR_SYSTEM . '/library/session.php';

$session = new Session();

echo json_encode(isset($session->data['user_id']));
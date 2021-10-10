<?php
// error_log will print to the container stdout so we can inspect it
error_log(json_encode(['$_SERVER' => $_SERVER, '$_REQUEST' => $_REQUEST], JSON_PRETTY_PRINT));

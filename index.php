<?php
	session_start();
	if(!$_SESSION['test']) $_SESSION['test'] = time();
	function getIP() {
	    $client  = @$_SERVER['HTTP_CLIENT_IP'];
	    if(filter_var($client, FILTER_VALIDATE_IP)) return $client;
	    $forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
	    if(filter_var($forward, FILTER_VALIDATE_IP)) return $forward;
	    return $_SERVER['REMOTE_ADDR'];
	}
?>
<!DOCTYPE html>
<html>
<head>
	<title>PHP Test Code</title>
</head>
<body style="margin: 50px;">
<p style="font-size: 30px;">Hi, this is a <strong>working</strong> PHP test page :)</p>
<div style="font-size: 20px;">
	Here some cool data :
	<ul style="margin-top: 0;">
		<li>Your IP address : <?php echo getIp(); ?></li>
		<li>Timestamp session : <?php echo $_SESSION['test']; ?></li>
		<li>PHP version : <?php echo phpversion(); ?></li>
		<li>HTTP host : <?php echo $_SERVER['HTTP_HOST']; ?></li>
		<li>Server name : <?php echo $_SERVER['SERVER_NAME']; ?></li>
		<li>Server software : <?php echo $_SERVER['SERVER_SOFTWARE']; ?></li>
		<li>Server address : <?php echo $_SERVER['SERVER_ADDR'].":".$_SERVER['SERVER_PORT']; ?></li>
		<li>Remote address : <?php echo $_SERVER['REMOTE_ADDR'].":".$_SERVER['REMOTE_PORT']; ?></li>
		<li>Server user : <?php echo $_SERVER['USER']; ?></li>
		<li>Script filename : <?php echo $_SERVER['SCRIPT_FILENAME']; ?></li>
		<li>Request time : <?php echo $_SERVER['REQUEST_TIME_FLOAT']; ?></li>
	</ul>
</div>
</body>
</html>

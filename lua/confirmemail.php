<?php
include 'core/init.php';
include 'includes/overall/header.php';



if (empty($_POST) === false) {
	$required_fields = array('email');
	foreach($_POST as $key=>$value) {
		if (empty($value) && in_array($key, $required_fields) === true) {
			$errors[] = 'You must type in an email';
			break 1;
		}
	}
	
	if (empty($errors) === true) {
		if ((empty($_POST['email']) === false) && (filter_var($_POST['email'], FILTER_VALIDATE_EMAIL) === false)) {
			$errors[] = 'A valid email address is required';
		}
		if ((empty($_POST['email']) === false) && (email_exists($_POST['email']) === true)) {
			$errors[] = 'Sorry, the email \'' . $_POST['email'] . '\' is already in use';
		}
	}
}

?>
<h1>Confirm Email</h1>

<?php
if (isset($_GET['s']) === true && empty($_GET['s']) === true) {
	echo 'Awesome, check your email and click the link to finish the process';
} else {
	
	
	if (empty($_POST) === false && empty($errors) === true) {
				
		register_email_only($userdata['user_id'], $POST['email']);
		header('Location: confirmemail.php?success');
		exit();
					
	}else if (empty($errors) === false) {
	
		echo output_errors($errors);
	}
	

?>

<form action="" method="post">
	<ul>
		<li>
			Email:<br>
			<input type="text" name="email">
		</li>
		<li>
			<input type="submit" value="Register">
		</li>
	</ul>
</form>

<?php

}

include 'includes/overall/footer.php'; ?>
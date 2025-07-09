<?php
	include $_SERVER['DOCUMENT_ROOT']."/db.php"; /* db load */
?>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<title>게시글</title>
	<!-- Add your CSS and JavaScript files here -->
<link rel=stylesheet href='nav.css' type='text/css'>
<link rel="stylesheet" type="text/css" href="/css/style.css" />
</head>
<style>

  section#container {
    width: 950px;
    height: 100%;
    text-align:left;
    float:left;
    padding:10px;
    border: 1px solid black;
  }

</style>
<body>
 <div id="wrap">
	<?php include 'header.php'; ?>
	<!-- Add the rest of your HTML and PHP code here -->
	<div id="content">
<section id="container">
<?php include 'read.php'; ?>

</section>

	<?php include 'aside.php'; ?>
	


	
	</div>
	
	

 
 
</div>
</body>


</html>

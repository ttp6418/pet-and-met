<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Pet & Met</title>
	<style>
		.sidebar { background-color: rgb(176, 217, 177); width: 240px; height: 400px; margin: 0; padding: 0; outline: none; border: outset; box-sizing: border-box; position: fixed; box-shadow: 0 20px 35px rgba(0, 0, 0, 0.1); }
		.sidebar hr { background-color: rgb(121, 172, 120); border: 0; height: 4px; margin-right: 20%; }
		.sidebar ul { list-style-type: '-  '; color: white; font-size: 16px; font-weight: 1000; }
		.sidebar a { text-decoration: none; color: white; cursor: context-menu; }
		.sidebar ul a:hover { background: rgb(176, 217, 177); box-shadow: -7px -7px 20px 0px rgb(121, 172, 120), -4px -4px 5px 0px rgb(121, 172, 120), 7px 7px 20px 0px rgb(121, 172, 120), 4px 4px 5px 0px rgb(121, 172, 120); transition: all 0.3s ease; }
	</style>
	</head>
	<body>
		<br><br><br><br>
		<nav class="sidebar" style="padding: 0px; margin: 0px;">
			<br>
		    <ul><h3><a href="hotel">호텔 소개</a><hr></h3></ul>
		    <ul><h3><a href="doghouse">객실 소개</a></h3><hr></ul>
		    <ul><h3><a href="<%= contextPath %>/lists.bo?currentPage=1&keyword=&method=">공지사항</a><hr></h3></ul>
			<ul><h3><a href="use">이용안내</a><hr></h3></ul>
		    <ul><h3><a href="map">위치 안내</a><hr></h3></ul>
		</nav>
	</body>
</html>
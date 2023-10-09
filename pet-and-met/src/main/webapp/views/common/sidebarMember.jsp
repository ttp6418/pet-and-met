<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		.li-tag-accent { border: 0px 2px; }
		.sidebar { background-color: rgb(176, 217, 177); width: 240px; height: 400px; margin: 0; padding: 0; outline: none; border: outset; box-sizing: border-box; position: fixed; box-shadow: 0 20px 35px rgba(0, 0, 0, 0.1); }
		.sidebar hr { background-color: rgb(121, 172, 120); border: 0; height: 4px; margin-right: 20%; }
		.sidebar ul { list-style-type: '-  '; color: white; font-size: 16px; font-weight: 1000; }
		.sidebar a { text-decoration: none; color: white; cursor: context-menu; }
		.sidebar ul a:hover { 
			background: rgb(176, 217, 177);
			box-shadow:
   -7px -7px 20px 0px rgb(121, 172, 120),
   -4px -4px 5px 0px rgb(121, 172, 120),
   7px 7px 20px 0px rgb(121, 172, 120),
   4px 4px 5px 0px rgb(121, 172, 120);
  transition: all 0.3s ease; }
		
		.example { color: rgba(255,151,0,1); color: rgba(251,75,2,1); background: linear-gradient(0deg, rgba(255,151,0,1) 0%, rgba(251,75,2,1) 100%); } 
	</style>
	</head>
	<body>
		<br><br><br><br>
		<nav class="sidebar" style="padding: 0px; margin: 0px;">
			<br>
			<ul>
				<h3><a href="">내정보</a></h3>
				<hr>
				<li><a href="">프로필 수정</a></li>
				<li><a href="">비밀번호 변경</a></li>
			</ul>
		    <ul><h3><a href="">예약확인/취소</a></h3><hr></ul>
		    <ul><h3><a href="">회원 탈퇴</a><hr></h3></ul>
		</nav>
	</body>
</html>
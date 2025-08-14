<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<h2>로그인 하세요</h2>
	<form action="memberJoinOk.jsp" method="post">
		아이디 <input type="text" name="mid"><br/>
		비밀번호 <input type="password" name="mpw"><br/>
		이름 <input type="text" name="mname"><br/>
		이메일 <input type="text" name="memail"><br/>
		
		<input type="submit" value="회원가입">
	</form>
</body>
</html>
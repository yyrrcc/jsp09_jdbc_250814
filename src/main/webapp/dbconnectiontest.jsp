<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC 연결 테스트</title>
</head>
<body>
<!-- jsp, mysql 연동(connection)하기 위해 필요한 4가지 -->
<!-- 계정(root), 비밀번호, jdbc 드라이버 이름, 서버주소(localhost) -->
	<%
		String driverName = "com.mysql.jdbc.Driver"; // mysql jdbc 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // mysql이 설치된 서버의 주소(IP)와 연결 할 DB(스키마) 이름 
		String username = "root";
		String password = "12345";
		
		Connection conn = null; // 커넥션 인터페이스로 선언 후 null로 초기값 선언
		
		// DB 연동할 때 예외처리 필수
		try {
		Class.forName(driverName); // mysql Driver 불러오기
		conn = DriverManager.getConnection(url, username, password);
		// 커넥션이 메모리 생성 (DB와 연결 커넥션 conn 생성)
		// get메서드가 url, username, password 이용해서 db와 연결시켜줌
		
		out.println(conn); // 커넥션이 에러 없이 생성된 경우 커넥션의 이름이 웹에 출력
		} catch (Exception e) {
			out.println("DB 커넥션 생성 실패");
			e.printStackTrace(); // 에러 내용 출력
		} finally { // 에러의 발생여부와 상관없이 Connection 닫기 실행
			try {
			if (conn != null) { // Connection이 null이 아닌 경우 (존재하는 경우) 닫기
				conn.close();
			}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	%>
</body>
</html>
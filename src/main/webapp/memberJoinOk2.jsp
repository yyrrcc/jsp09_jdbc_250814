<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리(PreparedStatement)</title>
</head>
<body>
	<% 
		// DB에 삽입 할 데이터
		request.setCharacterEncoding("UTF-8");
	
		String mid = request.getParameter("mid");
		String mpw = request.getParameter("mpw");
		String mname = request.getParameter("mname");
		String memail = request.getParameter("memail");
	%>
	<%
		String driverName = "com.mysql.jdbc.Driver"; // mysql jdbc 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // mysql이 설치된 서버의 주소(IP)와 연결 할 DB(스키마) 이름 
		String username = "root";
		String password = "12345";
		
		String sql = "INSERT INTO members (memid, mempw, memname, mememail) VALUES (?, ?, ?, ?)";
		
		Connection conn = null;

		//Statement stmt = null;
		// Statement 객체 보완한 객체가 PreparedStatement임 
		PreparedStatement pstmt = null;
		

		try {
		Class.forName(driverName);
		conn = DriverManager.getConnection(url, username, password);
		//stmt = conn.createStatement();
		pstmt = conn.prepareStatement(sql); // pstmt 객체 생성
		
		// 객체 만들고, 실행하기 전 단계에 VALUES 물음표 부분의 값을 지정해주기
		pstmt.setString(1, mid); // 인덱스는 1부터 시작한다
		pstmt.setString(2, mpw);
		pstmt.setString(3, mname);
		pstmt.setString(4, memail);
		
		int sqlResult = pstmt.executeUpdate();
		System.out.println("sqlResult :" + sqlResult);
		
		} catch (Exception e) {
			out.println("DB 에러 발생");
			e.printStackTrace(); // 에러 내용 출력
		} finally { // 에러의 발생여부와 상관없이 Connection 닫기 실행
			try {
				if (pstmt != null) { // stmt 존재하면 닫아주기 (conn보다 먼저 실행되어야 함)
					pstmt.close();
				}
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
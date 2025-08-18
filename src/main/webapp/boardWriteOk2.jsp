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
<title>글등록완료(PreparedStatement)</title>
</head>
<body>
	<% 
		// DB에 삽입 할 데이터
		request.setCharacterEncoding("UTF-8");
	
		String bnum = request.getParameter("bnum");
		String btitle = request.getParameter("btitle");
		String bcontent = request.getParameter("bcontent");
		String memid = request.getParameter("memid");
		String bdate = request.getParameter("bdate");
	%>
	<%
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jspdb";
		String username = "root";
		String password = "12345";
		
		// SQL문 만들기
		String sql = "INSERT INTO board (btitle, bcontent, memid) VALUES (?, ?, ?)";
		
		Connection conn = null;
		//Statement stmt = null;
		PreparedStatement pstmt = null;
		int sqlResult = 0; // 글 삽입 성공 여부 저장 할 변수
		
		// DB 연동할 때 예외처리 필수
		try {
		Class.forName(driverName); // mysql Driver 불러오기
		conn = DriverManager.getConnection(url, username, password);

		pstmt = conn.prepareStatement(sql); // pstmt 객체 생성
		
		// ?값 넣어주기
		pstmt.setString(1, btitle);
		pstmt.setString(2, bcontent);
		pstmt.setString(3, memid);
		
		
		sqlResult = pstmt.executeUpdate(); // SQL문을 DB에서 실행, 성공하면 1 반환
		System.out.println("sqlResult :" + sqlResult); // 결과값 콘솔창에 찍어주기
		
		} catch (Exception e) {
			out.println("DB 에러 발생");
			e.printStackTrace();
		} finally { // 에러의 발생여부와 상관없이 Connection 닫기 실행
			try {
				if (pstmt != null) { // pstmt 존재하면 닫아주기 (conn보다 먼저 실행되어야 함)
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
			}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	%>
	<%
		if(sqlResult == 1) { // 참이면 글쓰기 성공 -> 글 목록 출력 화면으로 이동
			RequestDispatcher dispatcher = request.getRequestDispatcher("boardList.jsp");
			dispatcher.forward(request, response);
	}
	%>

</body>
</html>
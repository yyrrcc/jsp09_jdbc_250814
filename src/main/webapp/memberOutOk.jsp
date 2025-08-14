<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 처리</title>
</head>
<body>
	<% 
		// DB에 삽입 할 데이터
		request.setCharacterEncoding("UTF-8");
	
		String oid = request.getParameter("oid"); // 탈퇴할 아이디
		
	%>
	<%
		// DB 커넥션 준비
		String driverName = "com.mysql.jdbc.Driver"; // mysql jdbc 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // mysql이 설치된 서버의 주소(IP)와 연결 할 DB(스키마) 이름 
		String username = "root";
		String password = "12345";
		
		// SQL문 만들기 (예약어는 대문자로 써주는 게 관례)
		String sql = "DELETE FROM members WHERE memid = '"+ oid +"'";
		
		Connection conn = null; // 커넥션 인터페이스로 선언 후 null로 초기값 선언
		
		// sql문을 실행, 관리해주는 객체를 선언해주는 인터페이스로 stmt 선언 및 null로 초기값
		Statement stmt = null;
		
		// DB 연동할 때 예외처리 필수
		try {
		Class.forName(driverName); // mysql Driver 불러오기
		conn = DriverManager.getConnection(url, username, password);
		// 커넥션이 메모리 생성 (DB와 연결 커넥션 conn 생성)
		// get메서드가 url, username, password 이용해서 db와 연결시켜줌
		stmt = conn.createStatement(); // stmt 객체 생성
		
		int sqlResult = stmt.executeUpdate(sql); // SQL문을 DB에서 실행, 성공하면 1 반환
		System.out.println("sqlResult :" + sqlResult);
			if (sqlResult == 1) {
				out.println(oid + "님, 정상적으로 탈퇴되었습니다.");
			} else {
				out.println(oid + "님, 문제가 생겼습니다. 다시 시도해주세요.");
			}
		
		} catch (Exception e) {
			out.println("DB 에러 발생");
			e.printStackTrace(); // 에러 내용 출력
		} finally { // 에러의 발생여부와 상관없이 Connection 닫기 실행
			try {
				if (stmt != null) { // stmt 존재하면 닫아주기 (conn보다 먼저 실행되어야 함)
					stmt.close();
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
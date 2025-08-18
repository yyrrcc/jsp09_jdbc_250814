<%@page import="java.sql.PreparedStatement"%>
<%@page import="jsp09_jdbc_250814.pack.MemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 처리</title>
</head>
<body>
	<% 
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
		
		//String sql = "UPDATE members SET mempw = '"+ mpw +"', memname = '"+ mname +"', mememail = '"+ memail +"' WHERE memid = '"+ mid +"'";
		String sql = "UPDATE members SET mempw = ?, memname = ?, mememail = ? WHERE memid = ?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
		Class.forName(driverName);
		conn = DriverManager.getConnection(url, username, password);
		pstmt = conn.prepareStatement(sql); // pstmt 객체 생성
		
		// ? 넣어주기
		pstmt.setString(1, mpw);
		pstmt.setString(2, mname);
		pstmt.setString(3, memail);
		pstmt.setString(4, mid);
		
		int sqlResult = pstmt.executeUpdate(); // SQL문을 DB에서 실행, 성공하면 1 반환
		//System.out.println("sqlResult :" + sqlResult);
		
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
		
		
		// 수정된 회원 정보를 다시 확인하기 위해서는 이렇게 불러와서 확인해야 한다..
		String sql2 = "SELECT * FROM members WHERE memid = ?";
		
		Connection conn2 = null; // 커넥션 인터페이스로 선언 후 null로 초기값 선언
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null; // 바깥에 선언해줘야 try catch문에서도 사용 가능, select문 실행 시 db에게 반환해주는 결과 받아주는 객체
		MemberDTO memberDto2 = new MemberDTO();

		try {
			Class.forName(driverName); // mysql Driver 불러오기
			conn2 = DriverManager.getConnection(url, username, password);
			pstmt2 = conn2.prepareStatement(sql2); // stmt 객체 생성
			
			// ?값
			pstmt2.setString(1, mid);
			
			rs2 = pstmt2.executeQuery();

			if (rs2.next()) {
				do { // rs에서 레코드(행)을 추출하는 방법
					String id = rs2.getString("memid");
					String pw = rs2.getString("mempw");
					String name = rs2.getString("memname");
					String email = rs2.getString("mememail");
					String date = rs2.getString("memdate");
					
					// DTO 객체 채우기
					memberDto2.setMemid(id);
					memberDto2.setMempw(pw);
					memberDto2.setMemname(name);
					memberDto2.setMememail(email);
					memberDto2.setMemdate(date);
					
				
				} while (rs2.next());
			} else { 
				response.sendRedirect("memberModify.jsp"); // 수정 할 멤버 아이디 입력 페이지로 강제 이동
			}
					
		} catch (Exception e) {
			out.println("DB 에러 발생");
			e.printStackTrace(); // 에러 내용 출력
		} finally { // 에러의 발생여부와 상관없이 Connection 닫기 실행
			try {
				if (rs2 != null) {
					rs2.close();
				}
				if (pstmt2 != null) { // stmt 존재하면 닫아주기 (conn보다 먼저 실행되어야 함)
					pstmt2.close();
				}
				if (conn2 != null) { // Connection이 null이 아닌 경우 (존재하는 경우) 닫기
					conn2.close();
			}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		request.setAttribute("memberDto", memberDto2); // 조회된 회원 정보가 들어 있는 memberDto를 request 객체에 set
	%>
	
	<h3>수정된 회원 정보를 확인해보세요.</h3>
	아이디 : ${memberDto.memid } <br/>
	비밀번호 : ${memberDto.mempw } <br/>
	이름 : ${memberDto.memname } <br/>
	이메일 : ${memberDto.mememail } <br/>

</body>
</html>
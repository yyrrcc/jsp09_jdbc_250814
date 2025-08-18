<%@page import="jsp09_jdbc_250814.pack.MemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정란</title>
</head>
<body>

	<% 
		// DB에 삽입 할 데이터
		request.setCharacterEncoding("UTF-8");
	
		String mid = request.getParameter("mid"); // 조회 할 아이디
		
	%>
	<%
		// DB 커넥션 준비
		String driverName = "com.mysql.jdbc.Driver"; // mysql jdbc 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // mysql이 설치된 서버의 주소(IP)와 연결 할 DB(스키마) 이름 
		String username = "root";
		String password = "12345";
		
		String sql = "SELECT * FROM members WHERE memid = '"+ mid +"'";
		
		Connection conn = null; // 커넥션 인터페이스로 선언 후 null로 초기값 선언
		Statement stmt = null;
		ResultSet rs = null; // 바깥에 선언해줘야 try catch문에서도 사용 가능, select문 실행 시 db에게 반환해주는 결과 받아주는 객체
		MemberDTO memberDto = new MemberDTO();

		try {
			Class.forName(driverName); // mysql Driver 불러오기
			conn = DriverManager.getConnection(url, username, password);
			stmt = conn.createStatement(); // stmt 객체 생성			
			rs = stmt.executeQuery(sql);

			if (rs.next()) {
				do { // rs에서 레코드(행)을 추출하는 방법
					String id = rs.getString("memid");
					String pw = rs.getString("mempw");
					String name = rs.getString("memname");
					String email = rs.getString("mememail");
					String date = rs.getString("memdate");
					
					// DTO 객체 채우기
					memberDto.setMemid(id);
					memberDto.setMempw(pw);
					memberDto.setMemname(name);
					memberDto.setMememail(email);
					memberDto.setMemdate(date);
					
				
				} while (rs.next());
			} else { 
				response.sendRedirect("memberModify.jsp"); // 수정 할 멤버 아이디 입력 페이지로 강제 이동
			}
					
		} catch (Exception e) {
			out.println("DB 에러 발생");
			e.printStackTrace(); // 에러 내용 출력
		} finally { // 에러의 발생여부와 상관없이 Connection 닫기 실행
			try {
				if (rs != null) {
					rs.close();
				}
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
		
		request.setAttribute("memberDto", memberDto); // 조회된 회원 정보가 들어 있는 memberDto를 request 객체에 set

	%>

	<h2>정보를 수정해보세요.</h2>
	<form action="memberModifyOk.jsp" method="post">
		<input type="hidden" name="mid" value="${memberDto.memid }">
		아이디 <input type="text" name="mid" value="${memberDto.memid }" disabled><br/>
		비밀번호 <input type="password" name="mpw" value="${memberDto.mempw }"><br/>
		이름 <input type="text" name="mname" value="${memberDto.memname }"><br/>
		이메일 <input type="text" name="memail" value="${memberDto.mememail }"><br/>
		가입일 <input type="text" name="memdate" value="${memberDto.memdate }" readonly><br/>
		
		<input type="submit" value="수정완료">
	</form>
</body>
</html>
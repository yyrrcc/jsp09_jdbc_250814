<%@page import="jsp09_jdbc_250814.pack.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
<title>모든 회원 정보 조회</title>
</head>
<body>
	<h4>모든 회원 정보</h4>
	<% 
		// DB에 삽입 할 데이터
		request.setCharacterEncoding("UTF-8");
	
		//String sid = request.getParameter("sid"); // 조회 할 아이디		
	%>
	<%
		// DB 커넥션 준비
		String driverName = "com.mysql.jdbc.Driver"; // mysql jdbc 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/jspdb"; // mysql이 설치된 서버의 주소(IP)와 연결 할 DB(스키마) 이름 
		String username = "root";
		String password = "12345";
		
		// SQL문 만들기 (예약어는 대문자로 써주는 게 관례)
		//String sql = "SELECT * FROM members WHERE memid = '"+ sid +"'";
		String sql = "SELECT * FROM members"; // 모든 회원 리스트 반환
		
		Connection conn = null; // 커넥션 인터페이스로 선언 후 null로 초기값 선언
		Statement stmt = null;
		ResultSet rs = null; // 바깥에 선언해줘야 try catch문에서도 사용 가능, select문 실행 시 db에게 반환해주는 결과 받아주는 객체
		
		List<MemberDTO> memberList = new ArrayList<MemberDTO>(); // 1명의 회원 정보 Dto객체들이 여러 개 저장 될 리스트 선언
		
		// DB 연동할 때 예외처리 필수
		try {
			Class.forName(driverName); // mysql Driver 불러오기
			conn = DriverManager.getConnection(url, username, password);
			// 커넥션이 메모리 생성 (DB와 연결 커넥션 conn 생성)
			// get메서드가 url, username, password 이용해서 db와 연결시켜줌
			stmt = conn.createStatement(); // stmt 객체 생성
			
			rs = stmt.executeQuery(sql); // select문은 executeQuery 사용함! 
			// select 문 실행 -> 결과가 DB로부터 반환 -> 그 결과(행)을 받아주는 ResultSet 타입 객체로 받아야 함
		
			while (rs.next()) {
				MemberDTO memberDto = new MemberDTO();
				
				memberDto.setMemid(rs.getString("memid"));
				memberDto.setMempw(rs.getString("mempw"));
				memberDto.setMemname(rs.getString("memname"));
				memberDto.setMememail(rs.getString("mememail"));
				memberDto.setMemdate(rs.getString("memdate"));
				
				memberList.add(memberDto);
			}
			
			for (MemberDTO m : memberList) {
				out.println(m.getMemid() + " / ");
				out.println(m.getMempw() + " / ");
				out.println(m.getMemname() + " / ");
				out.println(m.getMememail() + " / ");
				out.println(m.getMemdate() + "<br>");
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
	%>


</body>
</html>
<%@page import="jsp09_jdbc_250814.pack.BoardDTO"%>
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
<title>게시글 조회</title>
</head>
<body>
	<h4>게시글 모든 글 조회</h4>
	<% 
		// DB에 삽입 할 데이터
		request.setCharacterEncoding("UTF-8");
	%>
	<%
		// DB 커넥션 준비
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jspdb"; 
		String username = "root";
		String password = "12345";
		
		String sql = "SELECT * FROM board"; // 모든 글 리스트 반환
		
		Connection conn = null; 
		Statement stmt = null;
		ResultSet rs = null;
		
		List<BoardDTO> boardList = new ArrayList<BoardDTO>();
		
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
				BoardDTO boardDto = new BoardDTO();
				
				boardDto.setBnum(rs.getInt("bnum"));
				boardDto.setBtitle(rs.getString("btitle"));
				boardDto.setBcontent(rs.getString("bcontent"));
				boardDto.setMemid(rs.getString("memid"));
				boardDto.setBdate(rs.getString("bdate"));
				
				boardList.add(boardDto);
			}
			
			for (BoardDTO m : boardList) {
				out.println(m.getBnum() + " / ");
				out.println(m.getBtitle() + " / ");
				out.println(m.getBcontent() + " / ");
				out.println(m.getMemid() + " / ");
				out.println(m.getBdate() + "<br>");
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
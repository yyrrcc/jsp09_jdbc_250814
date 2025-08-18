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
<title>CSS 게시글 조회</title>
    <link rel="stylesheet" href="boardStyle2.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
        <div class="header">
            <h1>게시판</h1>
            <p class="subtitle">총 게시글 수: <span id="totalCount">0</span>개</p>
        </div>
        
        <div class="board-container">
            <table class="board-table">
                <thead>
                    <tr>
                        <th class="col-num">번호</th>
                        <th class="col-title">제목</th>
                        <th class="col-author">작성자</th>
                        <th class="col-date">작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    
            		request.setCharacterEncoding("UTF-8");

                		// DB 커넥션 준비
                		String driverName = "com.mysql.jdbc.Driver";
                		String url = "jdbc:mysql://localhost:3306/jspdb"; 
                		String username = "root";
                		String password = "12345";
                		
                		String sql = "SELECT * FROM board ORDER BY bnum DESC"; // 모든 글 리스트 반환
                		
                		Connection conn = null; 
                		Statement stmt = null;
                		ResultSet rs = null;
                    
                    List<BoardDTO> boardList = new ArrayList<BoardDTO>();
                    int totalCount = 0;
                    
                    // DB 연동 코드 (기존 코드 활용)
                    try {
                        Class.forName(driverName);
                        conn = DriverManager.getConnection(url, username, password);
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(sql);
                        
                        while (rs.next()) {
                            BoardDTO boardDto = new BoardDTO();
                            boardDto.setBnum(rs.getInt("bnum"));
                            boardDto.setBtitle(rs.getString("btitle"));
                            boardDto.setBcontent(rs.getString("bcontent"));
                            boardDto.setMemid(rs.getString("memid"));
                            boardDto.setBdate(rs.getString("bdate"));
                            boardList.add(boardDto);
                        }
                        totalCount = boardList.size();
                        
                    } catch(Exception e) {
                        e.printStackTrace();
                    } finally {
                        if(rs != null) rs.close();
                        if(stmt != null) stmt.close();
                        if(conn != null) conn.close();
                    }
                    
                    // 게시글 목록 출력
                    if(boardList.size() > 0) {
                        for(BoardDTO board : boardList) {
                    %>
                    <tr class="board-row" onclick="viewPost(<%= board.getBnum() %>)">
                        <td class="num"><%= board.getBnum() %></td>
                        <td class="title">
                            <span class="title-text"><%= board.getBtitle() %></span>
                            <div class="content-preview"><%= board.getBcontent().length() > 50 ? board.getBcontent().substring(0, 50) + "..." : board.getBcontent() %></div>
                        </td>
                        <td class="author"><%= board.getMemid() %></td>
                        <td class="date"><%= board.getBdate() %></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="4" class="no-data">등록된 게시글이 없습니다.</td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
        
        <div class="footer">
            <button class="btn-write" onclick="location.href='boardWrite.jsp'">글쓰기</button>
        </div>
    </div>
    
    <script>
        // 총 게시글 수 표시
        document.getElementById('totalCount').textContent = '<%= totalCount %>';
        
        // 게시글 클릭 시 상세보기
        function viewPost(bnum) {
            location.href = 'boardDetail.jsp?bnum=' + bnum;
        }
    </script>


</body>
</html>
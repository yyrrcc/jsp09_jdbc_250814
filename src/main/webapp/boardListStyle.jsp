<%@page import="jsp09_jdbc_250814.pack.BoardDTO"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록 (디자인 완료)</title>
<link rel="stylesheet" type="text/css" href="boardListStyle.css" />
</head>
<body>

    <div class="container">
       <div class="header">
           <h1>게시판</h1>
           <div class="board-info">
               <button class="btn-write" onclick="location.href='boardwrite.jsp'">글쓰기</button>
           </div>
       </div>
        
    <table class="board-table">
		<thead>
		<tr>		
			<th class="col-num">No.</th>
            <th class="col-title">제목</th>
            <th class="col-content">내용</th>
            <th class="col-author">글쓴이</th>
            <th class="col-date">날짜</th>
		</tr>
		</thead>
		
		<tbody>
		<c:forEach var="boardDto" items="${boardList }">
			<tr class="board-row">
				<td class="num">${boardDto.bnum}</td>
				<td class="title">
				<!-- 게시판 글 제목이 40자 이상일때 40자 이상은 ...표시  -->
					<c:choose>
						<c:when test="${fn:length(boardDto.btitle) > 40}">
							<a href="#">${fn:substring(boardDto.btitle, 0, 40)}...</a>
						</c:when>
						<c:otherwise>
							${boardDto.btitle }
						</c:otherwise>
					</c:choose>
				</td>
				<td class="content">${boardDto.bcontent }</td>
				<td class="author">${boardDto.memid }</td>
				<td class="date">${boardDto.bdate }</td>
			</tr>
		</c:forEach>
	</table>
	<br>
</div>


</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: Jieun Kim
  Date: 2022-07-10
  Time: 오후 5:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%
        request.setCharacterEncoding("utf-8");
    %>
    <link href="/css/hosun/main.css" rel="stylesheet"/>
    <link href="/css/jieun/paging.css" rel="stylesheet"/>
    <link href="/css/jieun/contentList.css" rel="stylesheet"/>

    <title>MOVIE List</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/templates/navbar.jsp"></jsp:include>
<br><br><br>
<nav>
    <div class="sort">
        <h5>Movie</h5>
        <form:form action="${pageContext.request.contextPath}/movie/list" modelAttribute="scmd">
            <select name="category" id="category">
                <option value="popularity.desc" <c:if test="${category eq 'popularity.desc'}">selected="selected"</c:if>>인기도 내림차순</option>
                <option value="popularity.asc" <c:if test="${category eq 'popularity.asc'}">selected="selected"</c:if>>인기도 오름차순</option>
                <option value="vote_average.desc" <c:if test="${category eq 'vote_average.desc'}">selected="selected"</c:if>>평점 내림차순</option>
                <option value="vote_average.asc" <c:if test="${category eq 'vote_average.asc'}">selected="selected"</c:if>>평점 오름차순</option>
            </select>
            <br>
            <input type="submit" value="확인">
        </form:form>
    </div>
</nav>
<br><br><br>

<div class="container">
    Movie List - ${category}<br>

    <div id="main-content">
        <c:set var="i" value="0" />
        <c:set var="j" value="5" />
        <table>
            <c:forEach var="movieList" items="${mediaList}">
                <c:if test="${i%j == 0 }">
                    <tr>
                </c:if>
                <td>
                    <a href="<c:url value='/movie/content/${movieList.contentsNum}'/>" class="cursor">

                        <c:choose>
                            <c:when test="${movieList.posterPath eq 'default'}">
                                <img src="/img/media/cinema_default.png" width="150">
                            </c:when>
                            <c:otherwise>
                                <img src="https://image.tmdb.org/t/p/w200${movieList.posterPath}">
                            </c:otherwise>
                        </c:choose>

                        <p>${movieList.title}</p>
                        <p><fmt:formatDate value="${movieList.releaseDate}" pattern="yyyy.MM.dd"/></p>
                    </a>
                </td>
                <c:if test="${i%j == j-1 }">
                    </tr>
                </c:if>
                <c:set var="i" value="${i+1 }" />
            </c:forEach>
        </table>
    </div>

    <nav aria-label="Page navigation example" class="css-paging">
        <ul class="pagination">

            <!-- 페이징 맨앞으로 버튼
	  	<li class="page-item"><a class="page-link" href="<c:url value='/search/movie?query=${query }&page=${now-1 }'/>">START</a></li> -->

	  	<!-- 페이징 << 버튼 -->
            <c:if test="${paging.curPage ne 1 }">
                <li class="page-item"><a class="page-link" href="<c:url value='/movie/list?page=${paging.curPage-1 }&category=${category}'/>">&laquo;</a></li>
            </c:if>


            <!-- 페이징 블럭 번호  -->
            <c:forEach begin="${paging.blockStartNum }" end="${paging.blockLastNum }" var="i">
                <c:choose>
                    <c:when test="${i eq paging.curPage }">
                        <li class="page-item active"><a class="page-link" href="<c:url value='/movie/list?page=${i }&category=${category}'/>">${i }</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item"><a class="page-link" href="<c:url value='/movie/list?page=${i }&category=${category}'/>">${i }</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>


            <!-- 페이징 >> 버튼 -->
            <c:if test="${paging.curPage ne paging.lastPageNum }">
                <li class="page-item"><a class="page-link" href="<c:url value='/movie/list?page=${paging.curPage+1 }&category=${category}'/>">&raquo;</a></li>
            </c:if>

            <!-- 페이징 맨뒤로 버튼
	  	<li class="page-item"><a class="page-link" href="<c:url value='/search/movie?query=${query }&page=${now-1 }'/>">END</a></li>-->

        </ul>
    </nav>

</div>


</body>
</html>

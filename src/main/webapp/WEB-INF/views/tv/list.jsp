<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="${pageContext.request.contextPath}/resources/js/hosun/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/hosun/main.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/hosun/scroll.js"></script>
    <%
        request.setCharacterEncoding("utf-8");
    %>
    <link href="/css/hosun/main.css" rel="stylesheet"/>
    <link href="/css/jieun/contentList.css" rel="stylesheet"/>
<%--    <link href="/css/jieun/paging.css" rel="stylesheet"/>--%>

    <title>TV List</title>
</head>
<body>
    <jsp:include page="/WEB-INF/views/templates/navbar.jsp"></jsp:include><br>
    <section class="css-7klu3x" id="wrapper">
        <div class="css-lufi3b">
            <div class="css-1qq59e8" style="display: flex;">
                <div class="media-cate">
                    <div>
                        <h5>TV</h5>
                        <form:form action="${pageContext.request.contextPath}/tv/list" modelAttribute="scmd">
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
                </div>

                <c:set var="i" value="0" />
                <c:set var="j" value="5" />

                <div class="media-main">
                    <table>
                        <c:forEach var="tvList" items="${mediaList}">
                            <c:if test="${i%j == 0 }">
                                <tr>
                            </c:if>
                            <td class="media-frame">
                                <a href="<c:url value='/tv/content/${tvList.contentsNum}'/>" class="cursor">

                                    <c:choose>
                                        <c:when test="${tvList.posterPath eq 'default'}">
                                            <img class="other-img" src="/img/media/cinema_default.png" width="150">
                                        </c:when>
                                        <c:otherwise>
                                            <img class="poster-img" src="https://image.tmdb.org/t/p/w200${tvList.posterPath}">
                                        </c:otherwise>
                                    </c:choose>

                                    <p class="title"><b>${tvList.title}</b><br>
                                        <fmt:formatDate value="${tvList.releaseDate}" pattern="yyyy.MM.dd"/>
                                    </p>
                                </a>
                            </td>
                            <c:if test="${i%j == j-1 }">
                                </tr>
                            </c:if>
                            <c:set var="i" value="${i+1 }" />
                        </c:forEach>
                    </table>
                    <div class="css-paging">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <!-- 페이징 맨앞으로 버튼
                            <li class="page-item"><a class="page-link" href="<c:url value='/search/tv?query=${query }&page=${now-1 }'/>">START</a></li>-->
                                <!-- 페이징 << 버튼 -->
                                <c:if test="${paging.curPage ne 1 }">
                                    <li class="page-item"><a class="page-link" href="<c:url value='/tv/list?page=${paging.curPage-1 }&category=${category}'/>">&laquo;</a></li>
                                </c:if>

                                <!-- 페이징 블럭 번호  -->
                                <c:forEach begin="${paging.blockStartNum }" end="${paging.blockLastNum }" var="i">
                                    <c:choose>
                                        <c:when test="${i eq paging.curPage }">
                                            <li class="page-item active"><a class="page-link" href="<c:url value='/tv/list?page=${i }&category=${category}'/>">${i }</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item"><a class="page-link" href="<c:url value='/tv/list?page=${i }&category=${category}'/>">${i }</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <!-- 페이징 >> 버튼 -->
                                <c:if test="${paging.curPage ne paging.lastPageNum }">
                                    <li class="page-item"><a class="page-link" href="<c:url value='/tv/list?page=${paging.curPage+1 }&category=${category}'/>">&raquo;</a></li>
                                </c:if>

                                <!-- 페이징 맨뒤로 버튼
                            <li class="page-item"><a class="page-link" href="<c:url value='/search/tv?query=${query }&page=${now-1 }'/>">END</a></li>-->
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="/WEB-INF/views/templates/footer.jsp"></jsp:include>
</body>
</html>

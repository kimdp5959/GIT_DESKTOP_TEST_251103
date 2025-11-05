<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 관리</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; margin-bottom: 30px; font-size: 28px; }
        .header-actions { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .search-form { display: flex; gap: 10px; }
        .search-form input { padding: 10px 15px; border: 1px solid #ddd; border-radius: 4px; width: 300px; }
        .btn { padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; font-size: 14px; transition: all 0.3s; }
        .btn-primary { background: #007bff; color: white; }
        .btn-primary:hover { background: #0056b3; }
        .btn-success { background: #28a745; color: white; }
        .btn-success:hover { background: #218838; }
        .btn-danger { background: #dc3545; color: white; }
        .btn-danger:hover { background: #c82333; }
        .btn-secondary { background: #6c757d; color: white; }
        .btn-secondary:hover { background: #545b62; }
        .alert { padding: 15px; margin-bottom: 20px; border-radius: 4px; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; font-weight: 600; color: #495057; }
        tr:hover { background: #f8f9fa; }
        .status-badge { padding: 4px 12px; border-radius: 12px; font-size: 12px; font-weight: 600; }
        .status-active { background: #d4edda; color: #155724; }
        .status-inactive { background: #f8d7da; color: #721c24; }
        .actions { display: flex; gap: 5px; }
        .pagination { display: flex; justify-content: center; align-items: center; gap: 5px; margin-top: 20px; }
        .pagination a, .pagination span { padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #333; }
        .pagination a:hover { background: #007bff; color: white; border-color: #007bff; }
        .pagination .active { background: #007bff; color: white; border-color: #007bff; }
        .pagination .disabled { color: #999; cursor: not-allowed; }
        .no-data { text-align: center; padding: 40px; color: #666; }
    </style>
</head>
<body>
    <div class="container">
        <h1>사용자 관리</h1>
        
        <!-- 알림 메시지 -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <!-- 검색 및 등록 버튼 -->
        <div class="header-actions">
            <form class="search-form" action="/users" method="get">
                <input type="text" name="keyword" value="${keyword}" placeholder="이름 또는 이메일로 검색">
                <button type="submit" class="btn btn-secondary">검색</button>
                <c:if test="${not empty keyword}">
                    <a href="/users" class="btn btn-secondary">전체보기</a>
                </c:if>
            </form>
            <a href="/users/create" class="btn btn-success">사용자 등록</a>
        </div>
        
        <!-- 사용자 목록 테이블 -->
        <c:choose>
            <c:when test="${empty users}">
                <div class="no-data">등록된 사용자가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>상태</th>
                            <th>등록일</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.username}</td>
                                <td>${user.email}</td>
                                <td>${user.phone}</td>
                                <td>
                                    <span class="status-badge ${user.status == 'ACTIVE' ? 'status-active' : 'status-inactive'}">
                                        ${user.status}
                                    </span>
                                </td>
                                <td>${user.createdAt}</td>
                                <td class="actions">
                                    <a href="/users/${user.id}" class="btn btn-primary">상세</a>
                                    <a href="/users/${user.id}/edit" class="btn btn-secondary">수정</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <!-- 페이징 컴포넌트 include -->
                <c:set var="baseUrl" value="/users" />
                <jsp:include page="../common/pagination.jsp" />
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
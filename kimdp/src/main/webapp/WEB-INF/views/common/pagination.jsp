<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%--
페이징 컴포넌트 사용을 위한 필수 속성:
- currentPage: 현재 페이지 (0부터 시작)
- totalPages: 전체 페이지 수
- totalItems: 전체 아이템 수
- pageSize: 페이지당 아이템 수
선택적 속성:
- keyword: 검색어
- baseUrl: 페이지 URL (기본값: 현재 URL)
--%>

<div class="pagination">
    <!-- 이전 페이지 -->
    <c:choose>
        <c:when test="${currentPage > 0}">
            <a href="${empty baseUrl ? '' : baseUrl}?page=${currentPage - 1}&size=${pageSize}${not empty keyword ? '&keyword='.concat(keyword) : ''}" class="btn btn-secondary">이전</a>
        </c:when>
        <c:otherwise>
            <span class="btn btn-secondary disabled">이전</span>
        </c:otherwise>
    </c:choose>
    
    <!-- 페이지 번호 -->
    <c:forEach begin="0" end="${totalPages - 1}" var="i">
        <c:choose>
            <c:when test="${i == currentPage}">
                <span class="btn btn-primary active">${i + 1}</span>
            </c:when>
            <c:otherwise>
                <a href="${empty baseUrl ? '' : baseUrl}?page=${i}&size=${pageSize}${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="btn btn-secondary">${i + 1}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    
    <!-- 다음 페이지 -->
    <c:choose>
        <c:when test="${currentPage < totalPages - 1}">
            <a href="${empty baseUrl ? '' : baseUrl}?page=${currentPage + 1}&size=${pageSize}${not empty keyword ? '&keyword='.concat(keyword) : ''}" class="btn btn-secondary">다음</a>
        </c:when>
        <c:otherwise>
            <span class="btn btn-secondary disabled">다음</span>
        </c:otherwise>
    </c:choose>
</div>

<p class="pagination-info">
    전체 ${totalItems}건 | ${currentPage + 1} / ${totalPages} 페이지
</p>

<style>
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 5px;
    margin: 20px 0;
}
.pagination .btn {
    min-width: 40px;
    text-align: center;
}
.pagination .active {
    background: #007bff;
    color: white;
}
.pagination .disabled {
    opacity: 0.5;
    cursor: not-allowed;
}
.pagination-info {
    text-align: center;
    color: #666;
    margin-top: 10px;
}
</style>
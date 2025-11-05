<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 상세 정보</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; margin-bottom: 30px; font-size: 28px; }
        .alert { padding: 15px; margin-bottom: 20px; border-radius: 4px; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .detail-table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        .detail-table th, .detail-table td { padding: 15px; border-bottom: 1px solid #ddd; text-align: left; }
        .detail-table th { background: #f8f9fa; font-weight: 600; color: #495057; width: 200px; }
        .detail-table tr:last-child th, .detail-table tr:last-child td { border-bottom: none; }
        .status-badge { padding: 6px 16px; border-radius: 12px; font-size: 14px; font-weight: 600; display: inline-block; }
        .status-active { background: #d4edda; color: #155724; }
        .status-inactive { background: #f8d7da; color: #721c24; }
        .btn-group { display: flex; gap: 10px; }
        .btn { padding: 12px 30px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; font-size: 14px; transition: all 0.3s; }
        .btn-primary { background: #007bff; color: white; }
        .btn-primary:hover { background: #0056b3; }
        .btn-secondary { background: #6c757d; color: white; }
        .btn-secondary:hover { background: #545b62; }
        .btn-danger { background: #dc3545; color: white; }
        .btn-danger:hover { background: #c82333; }
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); }
        .modal-content { background: white; margin: 15% auto; padding: 30px; border-radius: 8px; width: 400px; text-align: center; }
        .modal-buttons { display: flex; gap: 10px; justify-content: center; margin-top: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>사용자 상세 정보</h1>
        
        <!-- 알림 메시지 -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        
        <!-- 사용자 정보 -->
        <table class="detail-table">
            <tr>
                <th>ID</th>
                <td>${user.id}</td>
            </tr>
            <tr>
                <th>이름</th>
                <td>${user.username}</td>
            </tr>
            <tr>
                <th>이메일</th>
                <td>${user.email}</td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>${not empty user.phone ? user.phone : '-'}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td>${not empty user.address ? user.address : '-'}</td>
            </tr>
            <tr>
                <th>상태</th>
                <td>
                    <span class="status-badge ${user.status == 'ACTIVE' ? 'status-active' : 'status-inactive'}">
                        ${user.status}
                    </span>
                </td>
            </tr>
            <tr>
                <th>등록일</th>
                <td>${user.createdAt}</td>
            </tr>
            <tr>
                <th>수정일</th>
                <td>${user.updatedAt}</td>
            </tr>
        </table>
        
        <!-- 버튼 그룹 -->
        <div class="btn-group">
            <a href="/users" class="btn btn-secondary">목록</a>
            <a href="/users/${user.id}/edit" class="btn btn-primary">수정</a>
            <button type="button" onclick="showDeleteModal()" class="btn btn-danger">삭제</button>
        </div>
    </div>
    
    <!-- 삭제 확인 모달 -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h2 style="margin-bottom: 20px;">삭제 확인</h2>
            <p>정말로 이 사용자를 삭제하시겠습니까?</p>
            <p style="color: #dc3545; margin-top: 10px;">이 작업은 되돌릴 수 없습니다.</p>
            <div class="modal-buttons">
                <form action="/users/${user.id}/delete" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-danger">삭제</button>
                </form>
                <button type="button" onclick="closeDeleteModal()" class="btn btn-secondary">취소</button>
            </div>
        </div>
    </div>
    
    <script>
        function showDeleteModal() {
            document.getElementById('deleteModal').style.display = 'block';
        }
        
        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }
        
        // 모달 외부 클릭 시 닫기
        window.onclick = function(event) {
            const modal = document.getElementById('deleteModal');
            if (event.target == modal) {
                closeDeleteModal();
            }
        }
    </script>
</body>
</html>
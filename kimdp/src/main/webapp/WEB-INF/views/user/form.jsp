<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty user.id ? '사용자 등록' : '사용자 수정'}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; margin-bottom: 30px; font-size: 28px; }
        .alert { padding: 15px; margin-bottom: 20px; border-radius: 4px; }
        .alert-danger { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #495057; font-weight: 600; }
        .required::after { content: ' *'; color: red; }
        input[type="text"], input[type="email"], select, textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0,123,255,0.1);
        }
        textarea { resize: vertical; min-height: 100px; }
        .btn-group { display: flex; gap: 10px; margin-top: 30px; }
        .btn { padding: 12px 30px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block; font-size: 14px; transition: all 0.3s; }
        .btn-primary { background: #007bff; color: white; }
        .btn-primary:hover { background: #0056b3; }
        .btn-secondary { background: #6c757d; color: white; }
        .btn-secondary:hover { background: #545b62; }
        .help-text { font-size: 12px; color: #666; margin-top: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>${empty user.id ? '사용자 등록' : '사용자 수정'}</h1>
        
        <!-- 에러 메시지 -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <!-- 사용자 폼 -->
        <form action="${empty user.id ? '/users/create' : '/users/'.concat(user.id).concat('/edit')}" method="post">
            <div class="form-group">
                <label for="username" class="required">이름</label>
                <input type="text" id="username" name="username" value="${user.username}" required>
            </div>
            
            <div class="form-group">
                <label for="email" class="required">이메일</label>
                <input type="email" id="email" name="email" value="${user.email}" required>
                <div class="help-text">유효한 이메일 주소를 입력하세요.</div>
            </div>
            
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="text" id="phone" name="phone" value="${user.phone}" placeholder="010-1234-5678">
                <div class="help-text">하이픈(-)을 포함하여 입력하세요.</div>
            </div>
            
            <div class="form-group">
                <label for="address">주소</label>
                <textarea id="address" name="address">${user.address}</textarea>
            </div>
            
            <div class="form-group">
                <label for="status" class="required">상태</label>
                <select id="status" name="status" required>
                    <option value="ACTIVE" ${user.status == 'ACTIVE' ? 'selected' : ''}>활성</option>
                    <option value="INACTIVE" ${user.status == 'INACTIVE' ? 'selected' : ''}>비활성</option>
                </select>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">
                    ${empty user.id ? '등록' : '수정'}
                </button>
                <a href="/users" class="btn btn-secondary">취소</a>
            </div>
        </form>
    </div>
    
    <script>
        // 폼 유효성 검사
        document.querySelector('form').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            
            if (!username) {
                alert('이름을 입력하세요.');
                e.preventDefault();
                return;
            }
            
            if (!email) {
                alert('이메일을 입력하세요.');
                e.preventDefault();
                return;
            }
            
            // 이메일 형식 검증
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert('올바른 이메일 형식을 입력하세요.');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>
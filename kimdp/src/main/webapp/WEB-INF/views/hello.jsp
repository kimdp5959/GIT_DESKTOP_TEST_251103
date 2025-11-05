<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Hello</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 2rem; }
    </style>
</head>
</head>
<body>
    <h1><c:out value="${message}"/></h1>

    <h2>User List</h2>
    <table border="1" cellpadding="6" cellspacing="0">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${tempUserList}">
                <tr>
                    <td><c:out value="${u.id}"/></td>
                    <td><c:out value="${u.name}"/></td>
                    <td><c:out value="${u.email}"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

</body>
</html>

#### 스프링 JSTL 설정 방법
1. dependencies 추가
```java
	// JSP support (embedded Tomcat Jasper)
	implementation 'org.apache.tomcat.embed:tomcat-embed-jasper'
	// JSTL implementation (GlassFish Jakarta JSTL)
	implementation 'org.glassfish.web:jakarta.servlet.jsp.jstl:3.0.1'
	// JSTL API (Jakarta) - provide jakarta.servlet.jsp.jstl.* interfaces
	implementation 'jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api:3.0.1'
```
2. yml 설정 추가
```java
# JSP view resolver
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```

3. 확인용 컨트롤러 생성
```java
@Controller
public class HelloController {

    @GetMapping("/")
    public String hello(Model model) {
        model.addAttribute("message", "Hello World");

        List<Map<String, String>> tempUserList = Arrays.asList(
                Map.of("id", "1", "name", "Alice", "email", "alice@example.com"),
                Map.of("id", "2", "name", "Bob", "email", "bob@example.com"),
                Map.of("id", "3", "name", "Charlie", "email", "charlie@example.com")
        );

        model.addAttribute("tempUserList", tempUserList);
        return "hello"; // resolves to /WEB-INF/jsp/hello.jsp
    }
}
```

4. 확인용 jsp 파일 생성
```jsp
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
```
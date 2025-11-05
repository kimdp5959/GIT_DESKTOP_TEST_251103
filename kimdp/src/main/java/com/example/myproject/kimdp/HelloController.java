package com.example.myproject.kimdp;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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

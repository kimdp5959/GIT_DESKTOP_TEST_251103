package com.example.myproject.kimdp.user.controller;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.myproject.kimdp.user.dto.UserDTO;
import com.example.myproject.kimdp.user.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/users")
@RequiredArgsConstructor
@Slf4j
public class UserController {
    
    private final UserService userService;
    
    /**
     * 사용자 목록 페이지
     */
    @GetMapping
    public String list(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String keyword,
            Model model) {
        
        Page<UserDTO> userPage = userService.getUserList(page, size, keyword);
        
        model.addAttribute("users", userPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", userPage.getTotalPages());
        model.addAttribute("totalItems", userPage.getTotalElements());
        model.addAttribute("pageSize", size);
        model.addAttribute("keyword", keyword);
        
        return "user/list";
    }
    
    /**
     * 사용자 등록 폼
     */
    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("user", new UserDTO());
        return "user/form";
    }
    
    /**
     * 사용자 등록 처리
     */
    @PostMapping("/create")
    public String create(@ModelAttribute UserDTO userDTO, RedirectAttributes redirectAttributes) {
        try {
            Long userId = userService.createUser(userDTO);
            redirectAttributes.addFlashAttribute("message", "사용자가 성공적으로 등록되었습니다.");
            return "redirect:/users/" + userId;
        } catch (IllegalArgumentException e) {
            log.error("사용자 등록 실패: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/users/create";
        }
    }
    
    /**
     * 사용자 상세 페이지
     */
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        try {
            UserDTO user = userService.getUserById(id);
            model.addAttribute("user", user);
            return "user/detail";
        } catch (IllegalArgumentException e) {
            log.error("사용자 조회 실패: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/users";
        }
    }
    
    /**
     * 사용자 수정 폼
     */
    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        try {
            UserDTO user = userService.getUserById(id);
            model.addAttribute("user", user);
            return "user/form";
        } catch (IllegalArgumentException e) {
            log.error("사용자 조회 실패: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/users";
        }
    }
    
    /**
     * 사용자 수정 처리
     */
    @PostMapping("/{id}/edit")
    public String update(@PathVariable Long id, @ModelAttribute UserDTO userDTO, 
                        RedirectAttributes redirectAttributes) {
        try {
            userService.updateUser(id, userDTO);
            redirectAttributes.addFlashAttribute("message", "사용자 정보가 성공적으로 수정되었습니다.");
            return "redirect:/users/" + id;
        } catch (IllegalArgumentException e) {
            log.error("사용자 수정 실패: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/users/" + id + "/edit";
        }
    }
    
    /**
     * 사용자 삭제 처리
     */
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            userService.deleteUser(id);
            redirectAttributes.addFlashAttribute("message", "사용자가 성공적으로 삭제되었습니다.");
        } catch (IllegalArgumentException e) {
            log.error("사용자 삭제 실패: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/users";
    }
}
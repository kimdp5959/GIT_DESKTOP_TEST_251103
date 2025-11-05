package com.example.myproject.kimdp.user.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.myproject.kimdp.user.dto.UserDTO;
import com.example.myproject.kimdp.user.entity.User;
import com.example.myproject.kimdp.user.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class UserService {
    
    private final UserRepository userRepository;
    
    /**
     * 사용자 목록 조회 (페이징)
     */
    public Page<UserDTO> getUserList(int page, int size, String keyword) {
        Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "id"));
        
        Page<User> userPage;
        if (keyword != null && !keyword.trim().isEmpty()) {
            userPage = userRepository.searchByKeyword(keyword, pageable);
        } else {
            userPage = userRepository.findAll(pageable);
        }
        
        return userPage.map(UserDTO::fromEntity);
    }
    
    /**
     * 사용자 상세 조회
     */
    public UserDTO getUserById(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다. ID: " + id));
        return UserDTO.fromEntity(user);
    }
    
    /**
     * 사용자 등록
     */
    @Transactional
    public Long createUser(UserDTO userDTO) {
        // 이메일 중복 체크
        if (userRepository.existsByEmail(userDTO.getEmail())) {
            throw new IllegalArgumentException("이미 사용 중인 이메일입니다: " + userDTO.getEmail());
        }
        
        User user = userDTO.toEntity();
        User savedUser = userRepository.save(user);
        return savedUser.getId();
    }
    
    /**
     * 사용자 수정
     */
    @Transactional
    public void updateUser(Long id, UserDTO userDTO) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("사용자를 찾을 수 없습니다. ID: " + id));
        
        // 이메일 중복 체크 (자신의 이메일이 아닌 경우)
        if (!user.getEmail().equals(userDTO.getEmail()) && 
            userRepository.existsByEmail(userDTO.getEmail())) {
            throw new IllegalArgumentException("이미 사용 중인 이메일입니다: " + userDTO.getEmail());
        }
        
        user.setUsername(userDTO.getUsername());
        user.setEmail(userDTO.getEmail());
        user.setPhone(userDTO.getPhone());
        user.setAddress(userDTO.getAddress());
        user.setStatus(userDTO.getStatus());
    }
    
    /**
     * 사용자 삭제
     */
    @Transactional
    public void deleteUser(Long id) {
        if (!userRepository.existsById(id)) {
            throw new IllegalArgumentException("사용자를 찾을 수 없습니다. ID: " + id);
        }
        userRepository.deleteById(id);
    }
}
package com.example.myproject.kimdp.user.repository;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.myproject.kimdp.user.entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    // 이메일로 사용자 조회
    Optional<User> findByEmail(String email);
    
    // 이름으로 검색 (페이징)
    Page<User> findByUsernameContaining(String username, Pageable pageable);
    
    // 상태별 조회 (페이징)
    Page<User> findByStatus(String status, Pageable pageable);
    
    // 이름 또는 이메일로 검색 (페이징)
    @Query("SELECT u FROM User u WHERE u.username LIKE %:keyword% OR u.email LIKE %:keyword%")
    Page<User> searchByKeyword(@Param("keyword") String keyword, Pageable pageable);
    
    // 이메일 중복 체크
    boolean existsByEmail(String email);
}
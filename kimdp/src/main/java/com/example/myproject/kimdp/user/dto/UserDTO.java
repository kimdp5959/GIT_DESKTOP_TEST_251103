package com.example.myproject.kimdp.user.dto;

import java.time.format.DateTimeFormatter;

import com.example.myproject.kimdp.user.entity.User;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDTO {
    
    private Long id;
    private String username;
    private String email;
    private String phone;
    private String address;
    private String status;
    private String createdAt;
    private String updatedAt;
    
    // Entity -> DTO 변환
    public static UserDTO fromEntity(User user) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        
        return UserDTO.builder()
                .id(user.getId())
                .username(user.getUsername())
                .email(user.getEmail())
                .phone(user.getPhone())
                .address(user.getAddress())
                .status(user.getStatus())
                .createdAt(user.getCreatedAt().format(formatter))
                .updatedAt(user.getUpdatedAt() != null ? user.getUpdatedAt().format(formatter) : "")
                .build();
    }
    
    // DTO -> Entity 변환
    public User toEntity() {
        return User.builder()
                .id(this.id)
                .username(this.username)
                .email(this.email)
                .phone(this.phone)
                .address(this.address)
                .status(this.status)
                .build();
    }
}
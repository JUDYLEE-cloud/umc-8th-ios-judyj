package com.example.httptest.httpmethodtest.Controller;

import com.example.httptest.httpmethodtest.DTO.TokenResponse;
import com.example.httptest.httpmethodtest.Service.TokenService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

// 새로운 AccessToken을 발급받을 수 있도록 하는 인증 관련 API를 처리
// 토큰 발급 로직은 TokenService에 위임
@RestController
@RequestMapping("/auth")
public class AuthController {
    private final TokenService tokenService;

    public AuthController(TokenService tokenService) {
        this.tokenService = tokenService;
    }

    // 로그인 시 토큰 발급
    @GetMapping("/login")
    public TokenResponse login() {
        return tokenService.issueToken();
    }

    // 재발급
    @GetMapping("/refresh")
    public TokenResponse refresh(@RequestParam String refreshToken) {
        if (!tokenService.isRefreshTokenExpired(refreshToken)) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "유효하지 않은 refresh 토큰 입니다.");
        }
        return tokenService.issueToken();
    }
}

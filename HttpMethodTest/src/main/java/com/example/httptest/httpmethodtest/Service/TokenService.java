package com.example.httptest.httpmethodtest.Service;

import org.springframework.stereotype.Service;
import com.example.httptest.httpmethodtest.DTO.TokenResponse;
import java.util.*;

// AccessToken 생성, 만료 시간 관리, 고정된 RefreshToken 검증 등 토큰 관련 로직
@Service
public class TokenService {
    private final String staticRefreshToken = "judyj_refresh_token";

    private final long accessTokenValideDuration = 60 * 1000; // 1min

    private final Map<String, Long> accessTokenMap = new HashMap<>();

    public String getStaticRefreshToken() {
        String accessToken = UUID.randomUUID().toString();
        accessTokenMap.put(accessToken, System.currentTimeMillis() + accessTokenValideDuration);
        return accessToken;
    }

    // 토큰 유효한지 확인, 유효하면 true
    public boolean isAccessTokenExpired(String token) {
        Long expiryTime = accessTokenMap.get(token);
        return expiryTime != null && expiryTime > System.currentTimeMillis();
    }

    public boolean isRefreshTokenExpired(String refreshToken) {
        return staticRefreshToken.equals(refreshToken);
    }

    public TokenResponse issueToken() {
        String newAccessToken = getStaticRefreshToken();
        return new TokenResponse(newAccessToken, staticRefreshToken);
    }
}
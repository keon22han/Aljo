import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import Foundation

public final class LoginUtil {
    public static let shared = LoginUtil()
    
    private init() { }
    
    // MARK: Kakao Login
    public func loginWithKakaoAccountAsync() async throws -> OAuthToken? {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let oauthToken = oauthToken {
                        continuation.resume(returning: oauthToken)
                    } else {
                        continuation.resume(throwing: NSError(domain: "LoginError", code: 0, userInfo: nil))
                    }
                }
            }
        }
    }
    
    // MARK: Kakao Token Check
    public func hasKakaoAccountToken() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.accessTokenInfo { tokenInfo, error in
                if let error = error {
                    print("Token validation failed: \(error.localizedDescription)")
                    continuation.resume(returning: false)
                    // 토큰이 유효하지 않은 경우 새로 로그인 시도
                } else {
                    print("Token is valid. User ID: \(tokenInfo?.id ?? 0)")
                    continuation.resume(returning: true)
                }
            }
        }
    }
}

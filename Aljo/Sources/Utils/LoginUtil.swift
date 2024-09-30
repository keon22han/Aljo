import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import Foundation

public final class LoginUtil {
    public static let shared = LoginUtil()
    
    private init() { }
    
    // MARK: Kakao Login
    public func loginWithKakaoAccountAsync() async throws -> OAuthToken {
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
}

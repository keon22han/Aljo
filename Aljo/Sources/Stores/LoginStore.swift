//
//  LoginStore.swift
//  Aljo
//
//  Created by 한건희 on 9/28/24.
//

import Foundation
import ComposableArchitecture
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

// MARK: Reducer Macro available upper iOS 17.0 , Reducer 프로토콜 채택
struct LoginStore : Reducer {
    
    @ObservableState
    struct State : Equatable {
        var isLoading = false
        var loginCompleted = false
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case loginButtonClicked
        case kakaoLoginSuccessed(OAuthToken)
        case kakaoLoginErrorOccured
    }
    
    var body: some Reducer<State, Action> {
        
        BindingReducer() // MARK: (24.09.29) State, Action 간 바인딩 역할 (State 업데이트 발생 -> BindingReducer가 State값, Action 수신하여 Reducer 클로저 내 도메인 로직 처리 및 결과 State 반영) 공부 필요
        
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
                
            case .loginButtonClicked:
                state.isLoading = true
                
                return .run { send in
                    do {
                        // Kakao 로그인 API 호출
                        let oauthToken = try await loginWithKakaoAccountAsync()
                        
                        // 로그인 성공 시 처리
                        print("loginWithKakaoTalk() success: \(oauthToken)")
                        await send(.kakaoLoginSuccessed(oauthToken))
                    } catch {
                        // 로그인 실패 시 처리
                        print("loginWithKakaoTalk() failed: \(error.localizedDescription)")
                        await send(.kakaoLoginErrorOccured)
                    }
                }
                
            case .kakaoLoginSuccessed(let oauthToken) :
                print("in kakaoLoginSuccessed Action, Token.accessToken : \(oauthToken.accessToken)")
                state.loginCompleted = true
                return .none
                
            case .kakaoLoginErrorOccured :
                state.isLoading = false
                return .none
                
            }
        }
    }
    
    /// 비동기 Kakao 로그인 API 호출 함수
    func loginWithKakaoAccountAsync() async throws -> OAuthToken {
        return try await withCheckedThrowingContinuation { continuation in // MARK: closure 메서드 async await 으로 감싸기 (이게 맞나..)
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

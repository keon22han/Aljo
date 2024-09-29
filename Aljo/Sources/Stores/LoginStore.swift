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
                        let oauthToken = try await LoginUtil.shared.loginWithKakaoAccountAsync()
                        
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
                state.isLoading = false
                state.loginCompleted = true
                return .none
                
            case .kakaoLoginErrorOccured :
                state.isLoading = false
                return .none
                
            }
        }
    }
}

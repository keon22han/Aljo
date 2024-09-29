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
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case loginButtonClicked
    }
    
    var body: some Reducer<State, Action> {
        
        BindingReducer() // MARK: (24.09.29) State, Action 간 바인딩 역할 (State 업데이트 발생 -> BindingReducer가 State값, Action 수신하여 Reducer 클로저 내 도메인 로직 처리 및 결과 State 반영) 공부 필요
        
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
                
            case .loginButtonClicked:
                DispatchQueue.main.async {
                    UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                        Task {
                            if let error = error {
                                print(error)
                            } else {
                                print("loginWithKakaoTalk() success.")
                            }
                        }
                    }
                }
                return .none
            }
        }
    }
    
    private func validateUserId(idString: String) -> Bool {
        if idString.isEmpty {
            return false
        }
        return true
    }
    
    private func validateUserPw(pwString: String) -> Bool {
        if pwString.isEmpty {
            return false
        }
        return true
    }
    
}

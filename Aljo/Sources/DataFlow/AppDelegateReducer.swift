import ComposableArchitecture
import SwiftUI

struct AppDelegateReducer: Reducer {
    
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        case onLaunchFinish
        case onLoginSuccess
        case onLoginFailure
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            
            // TODO: app 실행 성공 시
            case .onLaunchFinish :
                return .none
                
            case .onLoginSuccess :
                print("login finish")
                return .none
                
            case .onLoginFailure :
                print("login fail")
                return .none
            }
        }
    }
}

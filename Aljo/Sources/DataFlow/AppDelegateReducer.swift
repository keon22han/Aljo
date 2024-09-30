import ComposableArchitecture
import SwiftUI

struct AppDelegateReducer: Reducer {
    
    @ObservableState
    struct State: Equatable {
    }
    
    enum Action: Equatable {
        case onLaunchFinish
        case onLoginSuccess
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            
            // TODO: app 실행 성공 시
            case .onLaunchFinish :
                print("앱 실행 성공")
                return .none
                
            case .onLoginSuccess :
                print("login success")
                return .none
            }
        }
    }
}

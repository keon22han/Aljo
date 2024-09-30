import SwiftUI
import ComposableArchitecture

struct AppReducer : Reducer {
    
    @ObservableState
    struct State: Equatable {
        var appDelegateState = AppDelegateReducer.State()
    }
    
    @CasePathable
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case appDelegate(AppDelegateReducer.Action)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            // TODO: todo
            case .binding(_) :
                return .none
                
            case .appDelegate(.onLaunchFinish) :
                return .merge(
                    .run { send in
                        let hasToken = try await LoginUtil.shared.hasKakaoAccountToken()
                        if hasToken {
                            await send(.appDelegate(.onLoginSuccess))
                        }
                    }
                )
            case .appDelegate :
                return .none
            }
            
        }
        
        Scope(state: \.appDelegateState, action: \.appDelegate, child: AppDelegateReducer.init)
    }
    
}

import SwiftUI
import ComposableArchitecture

struct AppReducer : Reducer {
    
    @ObservableState
    struct State: Equatable {
        var appDelegateState = AppDelegateReducer.State()
        var loginState = LoginReducer.State()
    }
    
    @CasePathable
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case appDelegate(AppDelegateReducer.Action)
        case login(LoginReducer.Action)
    }
    
    var body: some Reducer<State, Action> {
        
        Scope(state: \.appDelegateState, action: \.appDelegate, child: AppDelegateReducer.init) // MARK: 요놈 꼭 붙여주자..
        Scope(state: \.loginState, action: \.login, child: LoginReducer.init)
        
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
                            await send(.login(.kakaoLoginSuccessed))
                        } else {
                            await send(.login(.kakaoLoginTokenNotExist))
                        }
                    }
                )
                
            case .appDelegate :
                return .none
                
            case .login(.onBoarding(.mainButtonClicked)) :
                return .none
                
            case .login(.kakaoLoginSuccessed) :
                return .none
                
            case .login :
                return .none
            }
        }
    }
    
}

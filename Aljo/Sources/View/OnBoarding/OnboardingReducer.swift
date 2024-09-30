import Foundation
import SwiftUI
import ComposableArchitecture

struct OnboardingReducer: Reducer {
    
    @ObservableState
    struct State: Equatable {
    }
    
    @CasePathable
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case mainButtonClicked
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .mainButtonClicked :
                return .none
                
            case .binding(_):
                return .none
            }
        }
    }
}

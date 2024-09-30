import Foundation
import UIKit
import ComposableArchitecture

struct OnboardingReducer: Reducer {
    
    @ObservableState
    struct State: Equatable {
        var shouldShowOnboarding: Bool = true
    }
    
    enum Action {
        case mainButtonClicked
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .mainButtonClicked :
                state.shouldShowOnboarding = false
                return .none
            }
        }
    }
}

//
//  RegisterStore.swift
//  Aljo
//
//  Created by 한건희 on 9/29/24.
//

import ComposableArchitecture

struct RegisterStore : Reducer {
    
    struct State: Equatable {
        @BindingState var name: String = ""
        @BindingState var email: String = ""
        @BindingState var password: String = ""
    }
    
    enum Action : BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .binding(_):
                return .none
            }
        }
    }
}

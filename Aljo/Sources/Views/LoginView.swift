//
//  LoginView.swift
//  Aljo
//
//  Created by 한건희 on 9/28/24.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    var loginStore: StoreOf<LoginStore>
    var state = RegisterStore()
    
    
    var body: some View {
        NavigationView {
            WithViewStore(self.loginStore, observe: { $0 }) { viewStore in
                VStack {
                    Text("알죠")
                        .font(.system(size: 30, weight: .bold))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 70, trailing: 0))
                        
                    TextField("id", text: viewStore.$id)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewStore.isIdValid ? Color.green : Color.gray, lineWidth: 2)
                        )
                        .animation(
                            viewStore.isIdValid ? Animation.default.repeatCount(1, autoreverses: true) : .bouncy,
                            value: viewStore.isIdValid
                        )
                    
                    TextField("password", text: viewStore.$password)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(viewStore.isPwValid ? Color.green : Color.gray, lineWidth: 2)
                        )
                        .animation(
                            viewStore.isPwValid ? Animation.default.repeatCount(1, autoreverses: true) : .bouncy,
                            value: viewStore.isPwValid
                        )
                    
                    HStack(alignment: .center, spacing: 10) {
                        Button("Login") {
                            
                        }
                        .disabled(!viewStore.isIdValid || !viewStore.isPwValid)
                        NavigationLink(
                            "회원가입", destination: RegisterView(store: Store(initialState: RegisterStore.State()) { RegisterStore() }))
                    }
                    
                }
                .padding()
            }
        }
    }
    
    
}

#Preview {
    LoginView(loginStore: Store(initialState: LoginStore.State()) {
        LoginStore()
    })
}

//
//  LoginView.swift
//  Aljo
//
//  Created by 한건희 on 9/28/24.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    @Bindable var loginStore: StoreOf<LoginStore>
    
    var state = RegisterStore()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("알죠")
                    .font(.system(size: 40, weight: .bold))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                Button(action: {
                    self.loginStore.send(.loginButtonClicked)
                }) {
                    Image("kakao_login_default") // Assets에 있는 이미지 이름을 사용
                        .resizable() // MARK: 필수
                        .frame(width: 200, height: 50) // 원하는 크기로 조정
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

//#Preview {
//    LoginView(loginStore: Store(initialState: LoginStore.State()) {
//        LoginStore()
//    })
//}

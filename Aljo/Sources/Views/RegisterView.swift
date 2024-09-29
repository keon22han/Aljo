//
//  RegisterView.swift
//  Aljo
//
//  Created by 한건희 on 9/29/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct RegisterView: View {
    var store: StoreOf<RegisterStore>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("회원가입 뷰입니다.")
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
            Button("뒤로가기") {
                dismiss()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    RegisterView(store: Store(initialState: RegisterStore.State()) { RegisterStore() })
}

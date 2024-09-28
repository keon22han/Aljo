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
    
    var body: some View {
        VStack {
            Text("회원가입 뷰입니다.")
        }
    }
}

import SwiftUI
import ComposableArchitecture

@main
struct AljoApp: App {
    var body: some Scene {
        WindowGroup {
            // TODO: (24.09.29) 스플래시 윈도우 추가
            LoginView(loginStore: Store(initialState: LoginStore.State()) {
                LoginStore()
            })
        }
    }
}

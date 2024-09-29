import SwiftUI
import ComposableArchitecture
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct AljoApp: App {
    
    init() {
        KakaoSDK.initSDK(appKey: "f69b66f3ed673e7faad06d12743915e4")
    }
    
    var body: some Scene {
        WindowGroup {
            // TODO: (24.09.29) 스플래시 윈도우 추가
            LoginView(loginStore: Store(initialState: LoginStore.State()) {
                LoginStore()
            })
        }
    }
}

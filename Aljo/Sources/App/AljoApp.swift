import SwiftUI
import ComposableArchitecture
import KakaoSDKCommon

@main
struct AljoApp: App {
    
    init() {
        KakaoSDK.initSDK(appKey: "f69b66f3ed673e7faad06d12743915e4")
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView(loginStore: Store(initialState: LoginReducer.State()) {
                LoginReducer()
            })
        }
    }
}

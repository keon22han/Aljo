import SwiftUI
import ComposableArchitecture
import KakaoSDKCommon

@main
struct AljoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        KakaoSDK.initSDK(appKey: "58129b7f325962454720eda35319bd48")
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView(store: appDelegate.store.scope(state: \.loginState, action: \.login))
        }
    }
}

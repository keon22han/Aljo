import SwiftUI
import ComposableArchitecture

class AppDelegate : UIResponder, UIApplicationDelegate {
    let store = Store(initialState: .init()) {
        AppReducer()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        store.send(.appDelegate(.onLaunchFinish))
        
        return true
    }
}

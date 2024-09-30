import Foundation
import SwiftUI

extension View {
    func loadingIndicator(isLoading: Bool) -> some View {
        self.modifier(LoadingIndicator(isShowing: isLoading))
    }
}

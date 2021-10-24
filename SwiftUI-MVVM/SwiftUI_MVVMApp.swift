import SwiftUI

@main
struct SwiftUI_MVVMApp: App {
    var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
    }
}

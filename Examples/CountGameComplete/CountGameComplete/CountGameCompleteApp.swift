import SwiftUI

@main
struct CountGameCompleteApp: App {
    private var previewScenario: String? {
        let arguments = ProcessInfo.processInfo.arguments
        guard let index = arguments.firstIndex(of: "--preview-scenario"),
              arguments.indices.contains(index + 1) else {
            return nil
        }
        return arguments[index + 1]
    }

    var body: some Scene {
        WindowGroup {
            switch previewScenario {
            case "blue-turn":
                ContentView(previewCount: 12, previewPlayerTurn: false)
            case "game-over":
                ContentView(
                    previewCount: 0,
                    previewResult: "赤の負け！",
                    previewPlayerTurn: true,
                    previewRedSpecialUsed: true,
                    previewGameOverEffectTrigger: 1
                )
            default:
                ContentView()
            }
        }
    }
}

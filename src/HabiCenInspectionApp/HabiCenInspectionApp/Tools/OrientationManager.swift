import Combine
import SwiftUI

// Inspired by: https://rudrank.blog/orientation-property-wrapper-in-swiftui#orientation-property-wrapper

final class OrientationManager: ObservableObject {
    static let shared = OrientationManager()

    @Published var orientation: UIDeviceOrientation = .unknown

    private var cancellables: Set<AnyCancellable> = []

    init() {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene as? UIWindowScene else { return }

        let orientation = sceneDelegate.interfaceOrientation

        switch orientation {
        case .portrait:
            self.orientation = .portrait
        case .portraitUpsideDown:
            self.orientation = .portraitUpsideDown
        case .landscapeLeft:
            self.orientation = .landscapeLeft
        case .landscapeRight:
            self.orientation = .landscapeRight
        default:
            self.orientation = .unknown
        }

        NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .sink { [weak self] _ in
                let currentOrientation = UIDevice.current.orientation

                switch currentOrientation {
                case .unknown, .faceUp, .faceDown:
                    return
                default:
                    self?.orientation = currentOrientation
                }
            }
            .store(in: &cancellables)
    }
}

@propertyWrapper struct Orientation: DynamicProperty {
    @StateObject private var manager = OrientationManager.shared

    var wrappedValue: UIDeviceOrientation {
        manager.orientation
    }
}

// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public final class ViewControllerManager {
    public static var rootViewController: UIViewController? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .filter { $0.isKeyWindow }.first?.rootViewController
    }
    
    public static var topViewController: UIViewController? {
        guard var topController = rootViewController else { return nil }
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
    
    public static func viewOfTypeFromStack<T>(_ type: T.Type) -> T? {
        var currentViewController = rootViewController
        while let nextViewController = currentViewController {
            if let foundViewController = nextViewController as? T {
                return foundViewController
            }
            currentViewController = nextViewController.presentedViewController
        }
        return nil
    }
    
    public static func viewOfTypeIsInStack<T>(_ type: T.Type) -> Bool {
        viewOfTypeFromStack(type) != nil
    }
    
    public static func present(_ vc: UIViewController, animated: Bool, completion: @escaping () -> () = {}) {
        guard let topViewController else { return }
        topViewController.present(vc, animated: animated, completion: completion)
    }
}

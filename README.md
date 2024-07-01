# ViewControllerManager

Simplifying accessing the current stack of presented UIViewControllers and presenting views.

Usage:

```swift
struct ContentView: View {
    var body: some View {
        Button("Hello") {
            let vc = SomeViewController()
            ViewControllerManager.present(vc, animated: true) {
                guard ViewControllerManager.viewOfTypeIsInStack(SomeViewController.self) else { return }
                print("Passed!")
                guard ViewControllerManager.topViewController is SomeViewController else { return }
                print("Also Passed!")
            }
        }
    }
}
```


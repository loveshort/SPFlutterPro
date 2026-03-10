import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private var tabViewController: UITabBarController?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Setup method channel for iOS tab widget
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "ios_tab_widget", binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      self?.handleMethodCall(call, result: result)
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "initialize":
      initializeTabView(call: call, result: result)
    case "selectTab":
      selectTab(call: call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  private func initializeTabView(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let tabs = args["tabs"] as? [String],
          let initialIndex = args["initialIndex"] as? Int else {
      result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
      return
    }
    
    // Only enable native tab for iOS 26+
    let major = ProcessInfo.processInfo.operatingSystemVersion.majorVersion
    guard major >= 26 else {
      result(nil)
      return
    }
    
    // Create tab bar controller
    let tabBarController = UITabBarController()
    tabBarController.tabBar.tintColor = .systemBlue
    tabBarController.tabBar.unselectedItemTintColor = .systemGray
    
    // Create view controllers for each tab
    var viewControllers: [UIViewController] = []
    for (index, tabTitle) in tabs.enumerated() {
      let viewController = UIViewController()
      viewController.view.backgroundColor = .white
      viewController.title = tabTitle
      
      let tabBarItem = UITabBarItem(title: tabTitle, image: nil, tag: index)
      viewController.tabBarItem = tabBarItem
      
      viewControllers.append(viewController)
    }
    
    tabBarController.viewControllers = viewControllers
    tabBarController.selectedIndex = initialIndex
    
    self.tabViewController = tabBarController
    
    // Present the tab bar controller
    if let rootViewController = window?.rootViewController as? FlutterViewController {
      rootViewController.present(tabBarController, animated: true, completion: nil)
    }
    
    result(nil)
  }
  
  private func selectTab(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let index = args["index"] as? Int else {
      result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
      return
    }
    
    // If native controller is not created (iOS < 26), just return
    guard let controller = tabViewController else {
      result(nil)
      return
    }
    
    controller.selectedIndex = index
    result(nil)
  }
}

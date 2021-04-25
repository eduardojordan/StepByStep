//
//  ReachabilityManager.swift
//  StepByStep
//
//  Created by Eduardo Jordan on 23/4/21.
//

import UIKit
import Reachability

class ReachabilityManager: NSObject {

    static let shared = ReachabilityManager()
    
    private var reachability: Reachability?
    private var viewController: UIViewController?
    
    private override init() { }

    func initialize() {
        if let safeReachability = try? Reachability() {
            reachability = safeReachability
            do {
                try reachability!.startNotifier()
            } catch {
                print(TAG + "Unable to start notifier")
            }
        }
    }
    
    func addObserver(viewController: UIViewController) {
        self.viewController = viewController
        if (!isReachable()) {
            let dialogMessage = UIAlertController(title: localizedString("text_title_alert"), message: localizedString("text_msg_alert"), preferredStyle: .alert)
            let buttonAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                             })
            dialogMessage.addAction(buttonAction)
            viewController.present(dialogMessage, animated: true, completion: nil)
        } 
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
    }
    
     func isReachable() -> Bool {
        if let reachability = reachability {
            return (reachability.connection == .wifi || reachability.connection == .cellular)
        }
        return false
    }
    
    @objc func reachabilityChanged(note: Notification) {
        if let reachability = reachability {
            switch reachability.connection {
            case .wifi:
                print(TAG + "Reachable via WiFi")
            case .cellular:
                print(TAG + "Reachable via Cellular")
            case .unavailable:
                print(TAG + "Network not reachable")
            case .none:
                print(TAG + "None")
            }
        }
    }
    
}

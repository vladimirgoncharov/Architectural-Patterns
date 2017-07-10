//
//  UISplitViewMainService.swift
//  Architectural Patterns
//
//  Created by Vladimir Goncharov on 10/07/2017.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import UIKit

class UISplitViewMainService: NSObject, UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? APPersonViewController else { return false }
        if topAsDetailController.model == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}

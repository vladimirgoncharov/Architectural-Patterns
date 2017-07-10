//
//  APPersonViewController.swift
//  Architectural Patterns
//
//  Created by Vladimir Goncharov on 09/07/2017.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import UIKit
import SwinjectStoryboard

class APPersonViewController: UIViewController {
    
    typealias Model = APPerson
    
    /*
    enum Segues: String {
        case <#name#> = <#identifier#>
    }
     */
    
    //MARK: - UI
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    //MARK: -
    private(set) var model: Model? {
        didSet {
            self.configureView()
        }
    }
    
    //MARK: - init, config and deinit    
    func config(model: Model) {
        self.model = model
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangePointsOfPerson(notif:)),
                                               name: NSNotification.Name.init(rawValue: APPersonDidChangePoints),
                                               object: nil)
        
        self.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.<#name#>.rawValue?:
        default: fatalError("\(segue) not implemented")
        }
    }
     */
    
    //MARK: - Notifications
    func didChangePointsOfPerson(notif: Notification) {
        if  let model = notif.object as? Model,
            model == model {
            self.updatePoints()
        }
    }
}

//MARK: - Updating the view
extension APPersonViewController {
    
    func configureView() {
        self.navigationItem.title = self.model?.fullName
        self.updatePoints()
    }
    
    func updatePoints() {
        self.detailDescriptionLabel?.text = "\(self.model?.points ?? 0)"
    }
}

//MARK: - Routing
extension APPersonViewController {
}

//MARK: - Depedency
extension APPersonViewController {
    class func registerDepedency() {}
}

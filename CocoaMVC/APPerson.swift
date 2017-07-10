//
//  APPerson.swift
//  Architectural Patterns
//
//  Created by Vladimir Goncharov on 08/07/2017.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import UIKit

let APPersonDidChangePoints = "__APPersonDidChangePoints__"

class APPerson: NSObject {
    var firstName: String
    var lastName: String
    private(set) var points: Int = 0
    
    private var timer: Timer!
    
    var fullName: String {
        var fullName: String = ""
        if self.lastName.characters.count > 0 {
            fullName.append(self.lastName)
        }
        if self.firstName.characters.count > 0 {
            if self.lastName.characters.count > 0 {
                fullName.append(" ")
            }
            fullName.append(self.firstName)
        }
        return fullName
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        super.init()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: {[weak self] (timer) in
            self?.points += Int(1 + arc4random_uniform(5))
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: APPersonDidChangePoints), object: self)
        })
    }
    
    deinit {
        if self.timer.isValid {
            self.timer.invalidate()
        }
    }
}

extension APPerson {
    public static func ==(lhs: APPerson, rhs: APPerson) -> Bool {
        return lhs.fullName == rhs.fullName
    }
}

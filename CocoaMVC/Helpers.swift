//
//  Helpers.swift
//  Architectural Patterns
//
//  Created by Vladimir Goncharov on 09/07/2017.
//  Copyright © 2017 Vladimir. All rights reserved.
//

import UIKit

//MARK: - Get pretty class name
extension NSObject {
    
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    var className: String {
        return type(of: self).className
    }
}

//MARK: - XibSupport
enum XibSupportError: Error {
    case viewInNibNotFound
}

protocol XibSupport {
    static var nibFileName: String { get }
    static func getNib() -> UINib
    static func getViewFromNib() throws -> Self
}

extension NSObject: XibSupport {
    
    class var nibFileName: String {
        return self.className
    }
    
    class func getNib() -> UINib {
        return UINib(nibName: self.nibFileName, bundle: Bundle(for: self))
    }
    
    class func getViewFromNib() throws -> Self {
        return try self.getViewFromNibHelper()
    }
    
    fileprivate static func getViewFromNibHelper<T>() throws -> T {
        let topLevelObjects = self.getNib().instantiate(withOwner: nil, options: nil)
        
        for topLevelObject in topLevelObjects {
            if let object = topLevelObject as? T {
                return object
            }
        }
        throw XibSupportError.viewInNibNotFound
    }
}

//MARK: - RawRepresentable as Int
extension RawRepresentable where Self.RawValue == Int {
    
    static func allCases(_ startIndex: Int = 0) -> [Self] {
        var i = startIndex
        return Array( AnyIterator {
            let instance = self.init(rawValue: i)
            i += 1
            return instance
        })
    }
}

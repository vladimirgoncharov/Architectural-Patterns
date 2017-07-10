//
//  SwinjectStoryboard+Setup.swift
//  SwinjectSimpleExample
//
//  Created by Yoichi Tagaya on 11/20/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        
        //ViewControllers
        APPersonsViewController.registerDepedency()
        APPersonViewController.registerDepedency()
    }    
}

//
//  MyAccountStyle.swift
//  NewsHeadlines
//
//  Created by raju.kankanwadi on 28/07/19.
//  Copyright © 2019 raju.kankanwadi. All rights reserved.
//

import Foundation
import UIKit

public class MyAccountStyleTheme: NSObject {

    public class func apply() {
        // Navigation Bar
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.barTintColor = .black
        navBarAppearance.tintColor = .white
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}


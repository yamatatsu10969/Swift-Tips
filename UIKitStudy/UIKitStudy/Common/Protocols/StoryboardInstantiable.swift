//
//  StoryboardInstantiable.swift
//  UIKitStudy
//
//  Created by Tatsuya Yamamoto on 2019/7/5.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable {}

extension UIViewController: StoryboardInstantiable {}

extension StoryboardInstantiable where Self: UIViewController {
    
    static var storyboardName: String {
        
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        
        guard let controller = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() as? Self else {
            
            fatalError("StorybardInstatiable Error: \(storyboardName)")
        }
        
        return controller
    }
}

//
//  UIViewController+UIAlertController.swift
//  makeFile
//
//  Created by Tatsuya Yamamoto on 2019/10/25.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

public extension UIViewController {
  public func presentAlertController(_ title: String?, message: String?, style: UIAlertController.Style, actions: [AlertAction], animated: Bool = true, completion: (() -> Void)? = nil) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    actions.forEach { alert.addAction($0.action) }
    
    present(alert, animated: animated, completion: completion)
  }
  
 
  public func presentAlertController(_ title: String?, message: String?, style: UIAlertController.Style, actions: [AlertAction], animated: Bool = true, view: UIView, completion: (() -> Void)? = nil, tintColor: UIColor? = nil) {

    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    actions.forEach { alert.addAction($0.action) }
    
    alert.popoverPresentationController?.sourceView = view
    alert.popoverPresentationController?.sourceRect = view.bounds
    
    if let tintColor = tintColor {
      alert.view.tintColor = tintColor
    }
    
    present(alert, animated: animated, completion: completion)
  }
}

public enum AlertAction {
  public typealias Handler = (UIAlertAction) -> Void
  
  case ok(Handler?)
  case cancel(Handler?)
  case custom(title: String?, style: UIAlertAction.Style, handler: Handler?)
  
  var action: UIAlertAction {
    switch self {
    case .ok(let handler):
      return UIAlertAction(title: "OK", style: .default, handler: handler)
    case .cancel(let handler):
      return UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: handler)
    case .custom(let title, let style, let handler):
      return UIAlertAction(title: title, style: style, handler: handler)
    }
  }
}

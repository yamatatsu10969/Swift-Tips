//
//  UINavigationBarBackAndCloseButton.swift.swift
//  makeFile
//
//  Created by Tatsuya Yamamoto on 2019/10/25.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

public protocol UINavigationBarBackAndCloseButtonProtocol: UINavigationBarCloseButtonDelegate {
  func setupBackButton()
  func setupBackButton(_ title: String)
  func setupLeftCloseButton()
  func setupLeftCloseButtonIfNeeded()
  func closeOrBack()
}

@objc public protocol UINavigationBarCloseButtonDelegate {
  @objc func closeButtonPressed(_ sender: AnyObject)
}

public extension UINavigationBarBackAndCloseButtonProtocol where Self: UIViewController {
  func setupBackButton() {
    setupBackButton("")
  }
  
  func setupBackButton(_ title: String) {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
  }
  
  func setupLeftCloseButton() {
    navigationItem.leftBarButtonItems = [
      UIBarButtonItem(image: UIImage(named: "close_gray")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(closeButtonPressed(_:)))
    ]
  }
  
  func setupLeftCloseButtonIfNeeded() {
    guard let viewController = navigationController?.viewControllers.first else {
      return
    }
    
    if viewController == self {
      setupLeftCloseButton()
    }
    // --- ForX Replace Start ---
    if (viewController.children.filter { $0 == self }.count) > 0 {
      // --- ForX Replace End ---
      // ME ---if (viewController.childViewControllers.filter { $0 == self }.count) > 0 {
      setupLeftCloseButton()
    }
  }
  
  func closeOrBack() {
    if navigationController?.viewControllers.first != self {
      navigationController?.popViewController(animated: true)
      return
    }
    
    guard let closeButton = navigationItem.leftBarButtonItems?.first else {
      return
    }
    closeButtonPressed(closeButton)
  }
}

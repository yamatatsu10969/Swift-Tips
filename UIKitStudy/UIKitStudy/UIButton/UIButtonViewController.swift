//
//  UIButtonViewController.swift
//  UIKitStudy
//
//  Created by Tatsuya Yamamoto on 2019/7/5.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

final class UIButtonViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tryView: UIView!
    
    var alart: UIAlertController?
    var color: UIColor?
    var co: UICollectionView?
    var cl: UIColor?
    var fo: UIFont?
    var la: UILabel?
    var te: UITextField?
    var tex: UITextView?
    var im: UIImage?
    var ima: UIImageView?
    var pi: UIPickerView?
    var sc: UIScrollView?
    var sw: UISwitch?
    var vi: UIView?
    var vie: UIViewController?
    var ta: UITabBarController?
    var tab: UITabBarItem?
    var na: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let i =  button.buttonType.rawValue
        print(i)
        button.setTitle("やまたつ", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.setTitleShadowColor(.black, for: .normal)
        button.setNeedsLayout()
        // button.showsTouchWhenHighlighted = true
        button.adjustsImageWhenHighlighted = false
        button.reversesTitleShadowWhenHighlighted = true
        
        color = UIColor.red
        tryView.backgroundColor = color
        color?.setStroke()
        
        // .Selected
//        let mySelectedAttributedTitle =
//            NSAttributedString(string: "selected button",
//
//                               attributes: [NSAttributedString.Key.foregroundColor : UIColor.green,
//                                            ])
//        button.setAttributedTitle(mySelectedAttributedTitle, for: .selected)
        
        // .Normal
        let myNormalAttributedTitle =
            NSAttributedString(string: "Click Here",
                               attributes: [NSAttributedString.Key.foregroundColor : UIColor.blue,
                                            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)])
        
        
        button.setAttributedTitle(myNormalAttributedTitle, for: .normal)

    }
    
    @IBAction func test(sender: UIButton) {
        
    }

    @IBAction func buttonTapped(_ sender: UIButton, forEvent event: UIEvent) {
        print(event)
        button.isSelected = !button.isSelected
        print(button.currentImage)
        print(button.currentTitle)
        print(button.currentTitleColor)
        print(button.currentTitleShadowColor)
        print(button.titleLabel?.text)
        print(button.imageView?.image)
        alart = UIAlertController(title: "よっ", message: "こんにちは", preferredStyle: .actionSheet)
        if let VC = alart {
            self.show(VC, sender: self)
        }
    }
}

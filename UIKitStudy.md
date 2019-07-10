# UIKit Study
## 勉強方法
Jump to Definision で見ていく。

## UIButton
UIContorolを継承している
UIButton > UIControl > UIView > UIResponder > NSObject > 
```
// .Selected
let mySelectedAttributedTitle =
NSAttributedString(string: "selected button",

attributes: [NSAttributedString.Key.foregroundColor : UIColor.green,
])
button.setAttributedTitle(mySelectedAttributedTitle, for: .selected)

// .Normal
let myNormalAttributedTitle =
NSAttributedString(string: "Click Here",
attributes: [NSAttributedString.Key.foregroundColor : UIColor.blue,
NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 24)])

button.setAttributedTitle(myNormalAttributedTitle, for: .normal)

@IBAction func buttonTapped(_ sender: UIButton, forEvent event: UIEvent) {
print(event)
button.isSelected = !button.isSelected
}
```

UIButtonの気づき
isSelectedを変更することで、ボタンの表示を変えたりすることができる。
押された時にisSelectedを button.isSelected  =  !button.isSelected とする。
押された時にeventを取得できる

プロダクトのUIButton





## UIResponder 


## UIView
Animations
Changes to several view properties can be animated—that is, changing the property creates an animation starting at the current value and ending at the new value that you specify. The following properties of the UIView class are animatable:

* frame
* bounds
* center
* transform
* alpha
* backgroundColor


## NSAttributedStringで指定できる属性

### .font
フォント。UIFontを指定
### .foregroundColor
文字色。UIColorを指定
### .backgroundColor
文字背景色。UIColorを指定
### .kern
文字間隔。floatを指定。2.0など
### .underlineStyle
NSUnderlineStyleのrawValueを指定
NSUnderlineStyle.styleSingle.rawValueなど
### .strokeColor
縁取りの色。UIColorを指定
### .strokeWidth
縁取りの幅。floatを指定。
正の値のときは縁取りの内側はclearColorになる。.foregroundの指定は無視される
負の値のときは縁取りの内側は.foregroundColorになる（通常はこちらを使うと思う）
### .shadow
文字の影。NSShadowオブジェクトを指定


## UIAlertController
## UIButton
## UICollectionView
## UIColor
## UIFont
## UILabel
## UITextField
## UITextView
## UIImage
## UIImageView
## UIPickerView
## UIScrollView
## UISwitch
## UIView
## UIViewController
## UITabBarController
## UITabBarItem
## UINavigationController


## UIAlertController
## UIButton
## UICollectionView
## UIColor
## UIFont
## UILabel
## UITextField
## UITextView
## UIImage
## UIImageView
## UIPickerView
## UIScrollView
## UISwitch
## UIView
## UIViewController
## UITabBarController
## UITabBarItem
## UINavigationController

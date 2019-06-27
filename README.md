# Swift-Tips

## TableView
### 色を変えないようにする
```
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(false)
    if let indexPath = tableView.indexPathForSelectedRow {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
```
### 選択不可にする
#### 全体
`self.tableView.allowsSelection = false`
#### 二番目のセルだけ（一部だけにする時）
```
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
if indexPath.row == 1 {
// セルの選択不可にする
cell.selectionStyle = .none
} else {
// セルの選択を許可
cell.selectionStyle = .default
}

return cell
}

func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

switch indexPath.row {
case 0:
return indexPath
// 選択不可にしたい場合は"nil"を返す
case 1:
return nil

default:
return indexPath
}
}
```


### tableView の高さを動的に変更する
https://teratail.com/questions/46828
右辺を自分の好きな形にしよう！
```
let distanceFromViewTop: CGFloat = 200
view.frame.height - distanceFromViewTop
tableHeight.constant = tableView.contentSize.height
```

## NavigationController 
### 戻るボタンのハンドリング ： 以下は次の画面が TermOfServiceViewController だったら、TermOfServiceViewControllerを消すという動作。
```
extension RegistAuthUserViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is TermOfServiceViewController {
                viewController.dismiss(animated: true, completion: nil)
            }
        }
}
```

### 戻るボタンのテキストを消す
` navigationController!.navigationBar.topItem!.title = " " `

### NavigationBar を消す　一時的に
`navigationController?.setNavigationBarHidden(false, animated: false)`

## TableViewCell
### デフォルトのセルを使う
```
let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
let cell = UITableViewCell(style: .value2, reuseIdentifier: "cell")
```
#### デフォのセルのアクセサリ
```
cell.textLabel?.text       = "東京都"
cell.detailTextLabel?.text = "ここが詳細テキストラベルです"
cell.accessoryType         = UITableViewCellAccessoryType.disclosureIndicator
cell.imageView?.image      = UIImage(named: "eyecatch-image")
```


## CollectionView
### Cell情報の取得
### 多分正攻法じゃない気がする笑
```
guard let cell = collectionView.cellForItem(at: IndexPath(row: getNowWatchingCellIndex(collectionView), section: 0)) as? MovieCell else {
return
}
func getNowWatchingCellIndex(_ scrollView: UIScrollView) -> Int {
let nowVisiblePoint = scrollView.contentOffset.y
return Int(nowVisiblePoint / view.bounds.height)
}
```

### 動画や画像を画面いっぱいに表示したいのに、初期表示がいっぱいにならない
#### collectionView.contentInsetAdjustmentBehavior = .never
```
https://stackoverflow.com/questions/48101233/dont-use-safearea-inset-on-iphone-x-for-first-uitableviewcell
Marking the "Content insets" under Size Inspector to "Never" worked for me. 
```
### collectioViewCell に swipegestureをつける
```
let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(sender:)))
leftSwipe.direction = .right
collectionView.addGestureRecognizer(leftSwipe)
leftSwipe.delegate = collectionView

// ここで他のジェスチャーも受け入れるかを判断。 delegateを CollectionViewに入れるのだ！
extension UICollectionView: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
-> Bool {
        return true
        }
}
```


## Tabbar
### tabbarのアイコンの文字を消して、アイコンを真ん中に持ってくる 
アイコンの文字を消す時は、baritem → image inset →　bottom を　−10, -12　にするとよい。

### tabbar を消す　一時的に
`tabBarController?.tabBar.isHidden = true`

## ImageView
### タップを検出する
```
imageView.isUserInteractionEnabled = true
imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(test)))
```


## UIView
### UIVeiwをコンポーネントして扱う。セルみたいにxibファイルで管理したいとき。
```
protocol CommentInputViewDelegate: class {
func sendButtonTapped(text: String)
}

class CommentInputView: UIView {

@IBOutlet weak var commentField: UITextField!
@IBOutlet weak var sendButton: UIButton!

weak var delegate: CommentInputViewDelegate?

override init(frame: CGRect) {
super.init(frame: frame)
self.setFromXib()
sendButton.isEnabled = false
commentField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
}

required init?(coder aDecoder: NSCoder) {
super.init(coder: aDecoder)
self.setFromXib()
}

func setFromXib() {
let nib = UINib.init(nibName: self.className, bundle: nil)
let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
self.addSubview(view)

// カスタムViewのサイズを自分自身と同じサイズにする
view.translatesAutoresizingMaskIntoConstraints = false
let bindings = ["view": view]
addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
options:NSLayoutConstraint.FormatOptions(rawValue: 0),
metrics:nil,
views: bindings))
addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
options:NSLayoutConstraint.FormatOptions(rawValue: 0),
metrics:nil,
views: bindings))
}

var className: String {
get {
return type(of: self).className
}
}

@IBAction func sendButtonTapped(_ sender: Any) {
guard let text = commentField.text else {
return
}
if text.isEmpty {
return
}
commentField.resignFirstResponder()
commentField.text = String()
delegate?.sendButtonTapped(text: text)
sendButton.isEnabled = false
}
}
```

## TextField
### placeholder の色を変える
```
textField.attributedPlaceholder = NSAttributedString(string: "名前を入力してください。", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])

```

### 点滅するやつの色変更
`UITextField.appearance().tintColor = .white`


## ToolBar 
### ToolBar （下）をコードで生成する
ポイントは view.addSubView(toolBar) は viewWillAppear で行うこと！
https://qiita.com/kamesoft/items/09386431c94eb922ee4c

## WKWebView
### 気をつける点
１、WKWebViewはStoryboardからは貼り付けられない
２、`view = webView`ではなく、addSubviewで画面にのせる
３、Storyboardでおいたものはすでに生成されているので、`webView = WKWebView(frame: .zero, configuration: webConfiguration)`でもう一度生成すると二つwebViewができてしまう
なのでとりあえず、
storyboardのwebviewは消して、コードで生成したwkwebviewを使うか、もしくはその逆で行くかですね！

stackViewが表示されないのは、
｀view = webView｀でstackViewが置かれているview自身をwebViewに変更してしまってるため、表示されていないということですね！


# Error
## beta版を使っているときにアプリを申請に出すとbinary errorでリジェクト
参考：https://www.chrisjmendez.com/2017/05/02/modify-systemversion-plist-within-macos-sierra/
### 手順
リカバリーモードへ。
コマンド＋R （ちゃんとコマンドのところ。Capslockはダメ）
リカバリーモードのターミナル開く→自分のアカウントから入る
 csrutil disable
 再起動
 
 コピー取っとく
 ` sudo cp /System/Library/CoreServices/SystemVersion.plist ~/SystemVersion.plist.bak`
書き換える
`sudo nano -W /System/Library/CoreServices/SystemVersion.plist`

戻す　リカバリーモードのターミナル
`csrutil enable`
 


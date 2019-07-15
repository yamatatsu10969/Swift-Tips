# Swift-Tips

## レイアウトに関して
### 要素
一つのセルがあるとして、その中に複数の要素があるとする。
その時に、上下左右のマージンは 16 or 20 にする。
全ての外側のマージンの大きさは合わせる。

AutoLayoutは行列の計算で表される。
一つ一つの要素に一つの連立方程式があり、それを計算している。
つまり、labelなどの要素は高さや幅は決まっていた方が計算が早くなり、正確な値が出てくる。

labelの高さを決める時というのは、そのlabelが固定の文言であることや、長さが決まっている時である。
例えば、「名前」というラベルがあって、その下にユーザの名前のラベルがあるとする。
この時の「名前」のラベルは、不変のものなので、高さ、幅、マージンは指定する。
ユーザの名前のラベルは、もしかしたら、二行になる可能性があるので、高さと幅は決めることができない。名前がとても長い人がいたら、見えなくなってしまうからだ。

ほとんどの場合、値は決めて置くことがシステムのためになるが、可変になりそうなところだけはAutoLayoutに任せるのが吉だ。



## AppDelegate
### rootで管理する
```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Keyboard.configure()
    Progress.configure()
    window = UIWindow()
    window?.makeKeyAndVisible()
    window?.rootViewController = TabBarController()
return true
}
```

## TableView
### 選択された時に色を変えないようにする
`selectedStyle = .none `

↓↓↓↓↓↓こいつ使えない子かも。
```
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(false)
    if let indexPath = tableView.indexPathForSelectedRow {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
```

### 選択された後に、背景色を元に戻す
```
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // これを入れると、セレクトした後に、背景色が元に戻る。
    tableView.deselectRow(at: indexPath, animated: true)
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

## ScrollView
### 下にスクロールしているときは、navigationbarを閉じて、上にスクロールしているときは出す
```
extension TimelineViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
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
`view = webView` でstackViewが置かれているview自身をwebViewに変更してしまってるため、表示されていないということですね！


## AudioServicesPlaySystemSound
### 短い振動を出す
`AudioServicesPlaySystemSound(SystemSoundID("1519")!)`

## 三項演算子の使いどころ
### if let のかわり
```
tableView の return 〇〇.countの時。

〇〇がオプショナルの場合、
if let or guard let を使うけど、省略したい場合、

return 〇〇?.count ?? 0

にすると省略できる。

```


## dispatchDeque
### 非同期処理が何個もある場合 (配列の処理の時に、非同期処理にして性能を上げたいとき。)
```
// グループを作って
let dispatchGroup = DispatchGroup()

let dispatchQueue = DispatchQueue(label: "queue", attributes: .concurrent)
snapShot.documents.forEach({ (document) in
// 一つ目をグループに入れて、
dispatchGroup.enter()

dispatchQueue.async {
let id =  document.documentID
let isEntried = [String](entriedOffers.keys).contains(document.documentID)
var isConfirmed: Bool = false
if isEntried {
isConfirmed = entriedOffers[document.documentID] ?? false
}
var entryStatus: Offer.EntryStatus
if isEntried && isConfirmed {
entryStatus = .confirmed
} else if isEntried {
entryStatus = .entried
} else {
entryStatus = .notEntried
}
let offer = Offer(id: id, document: document.data(), entryStatus: entryStatus)
offers.append(offer)
dispatchGroup.leave()
}
})
dispatchGroup.notify(queue: .main) {
completion(offers, nil)
}
```


### iosのUIを更新する処理は単一のスレッド(main thread)から実行しなければならない、というルールに従って処理を記述する例です。
```
// 重たい処理
DispatchQueue.global().async {
}
// UIを更新する処理
DispatchQueue.main.async {
    weakSelf.tableView.reloadData()
}
```

## lazy
初期化のタイミングをずらすことができる。
アクセスした時に値が決定する。と思う。

```
### lazyなし
var defaultPrice = 100

class Item {
var price: Int = defaultPrice
}

let item = Item()

defaultPrice = 200
print(item.price) // 100

### lazyあり
var defaultPrice = 100

class Item {
lazy var price: Int = defaultPrice
}

let item = Item()

defaultPrice = 200
print(item.price) // 200

defaultPrice = 300
print(item.price) // 200

```

## コメント
### ドキュメントコメント
///
または、
/**
*
*/
で記述する
ドキュメントコメントではMarkdownが使用できる。


## クラスとストラクト class _ struct
### Swiftでは、主にstructを使用する。値型。classは参照型
### 参照型では予期しないエラーが起こる可能性を秘めている。継承元であるクラスもインスタンス化が可能なのはよくない
### 参照型 classを使うときは、deinitを利用したクラスのライフサイクルを使うときや、値を参照するべきとき。
### Structは継承ができないため、protocol で継承の様なことを行う。

## 非同期処理
### DispatchQueue.main.async はUIの更新で使う
### 参考ページ
`https://scior.hatenablog.com/entry/2018/12/29/100000`


## DateFormatter 
### 一番良いdateFormat 　
```
formatter.dateFormat = "yyyy/MM/dd HH:mm"
```
hhだと24時間表記にならない
mmだと、表示がおかしくなる

## Result<T, Error> 
### Usage
```
enum databaseError: Error {
    case entry
    case def
    case out
}

func test() -> Result<String,Error> {
    if let id = messages[0].messageId {
        return .success(id)
    }
    return .failure(databaseError.entry)
}
```


## Codable
参照：　https://qiita.com/s_emoto/items/deda5abcb0adc2217e86
### 常にCodableな型
　String, Int, Double, Data, Date, URL
　
### 条件付きでCodableな型
　Array, Dictionary, Optional　→　中身がCodableの場合
　struct　→　Codableなプロパティのみから構成されている場合

```
User.swift
struct Friend: Codable {  // -> プロパティが全てCodableなのでCodable
    name: String // -> Codable
    age: Int // -> Codable
}

struct User: Codable {
    name: String
    age: Int
    friends: [Friend] // -> 中身がCodableなのでCodable
    startDate: Date
    role: String
}
```

### CodingKeys の使いどころ
上記のように記述すればCodableとして使えるけど、EncodeとDecodeでキー名が異なる時に一対一対応させる必要がある。その時に使うのが「CodingKeys」。
```
struct User: Codable {
    name: String
    age: Int
    friends: [Friend]
    startDate: Date
    role: String

    enum CodingKeys: String, CodingKey {
        case name
        case age
        case friends
        case startDate = "start_date"  // ←　これ
        case role
    }
}
```

### 結構重要な実装のこと
【実装する時の決まり事】
・enumの名前は「CodingKeys」にする
・case名をプロパティ名、rawValueをエンコード結果のフィールド名として定義する
・case自体を省略するとエンコード・デコードされない。この時、Decodableにするにはdefault valueが必要。

例で示した＠「SnakeCase ↔︎ CamelCase」の場合は
Swift4.1以降では、DecoderのkeyDecodingStrategyを使うと省略できるみたいです。





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
 

# UIKit Study
## 勉強方法
Jump to Definision でUIKitの主要な部品を見ていく。

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
```
// アラートが出る
alart = UIAlertController(title: "よっ", message: "こんにちは", preferredStyle: .alert)
// 下にシートが出る
alart = UIAlertController(title: "よっ", message: "こんにちは", preferredStyle: .actionSheet)

```

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

# Xcode Tips
## デバッグ時とリリース時で実行させるコードを変更させる
```
//  広告ID設定
#if DEBUG
    // テスト用
    admobView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
#else
    // 本番用
    admobView.adUnitID = "realID"
#endif
```



# デザインパターン
## シングルトン パターン
### 使いどころ
 シングルトンパターンはインスタンスが1個しか生成されないことを保証したい時に使います。
 
 ### 書き方
 struct はインスタンスが一つではなくなるので、ダメ。値型だからね。
 以下の2行を書けばできる。
 ```
 static let shared =  ~~~
 private init() {}
 ```
 例：
 ```
 class MyApplication {
     // 自動的に遅延初期化される(初回アクセスのタイミングでインスタンス生成)
     static let shared = MyApplication()
     // 外部からのインスタンス生成をコンパイルレベルで禁止
     private init() {}
 }
 ```
 
 ### 参考はmonoさん
 https://medium.com/swift-column/singleton-398078bcc58d
 
 
 # クリーンアーキテクチャ
 ## 目的
 ### ソフトウェアアーキテクチャの目的は、求められるシステムを構築、保守するために必要な人材を最小限に抑えることである。
 
 
 ## 3つのプログラミングの型
 ### 関数型プログラミング
 変数が変化しない。
 可変コンポーネントと不変コンポーネントに分離させている。
 
 ### オブジェクト指向プログラミング
継承、ポリモーフィズム、カプセル化を特徴とする。

### 構造化プログラミング
goto文が老害


## 設計の原則 SOLIDの原則

### 単一責任の原則（SRP：Single Responsibility Principle）
モジュールはたった一つのアクターに対して責務を負うべきである。
モジュール → ファイルのこと。

### オープン・クローズドの原則（OCP：Opne-Closed Principle）
変更の影響を受けずにシステムを拡張しやすくすること。
目的を達成するために、システムをコンポーネントに分割して、コンポーネントの依存関係を階層構造にする。
そして、上位レベルのコンポーネントが下位レベルのコンポーネントの変更の影響を受けないようにする。


### リスコフの置換原則（LSP：Liskov Substitution Principle）
継承の使い方の指針
ベースとなるクラスの派生系でも、ベースのものが使えるようになるべき。
アーキテクチャのレベルにも適用できる。

### インターフェイス分離の原則（ISP：Interfade Segregation Principle）
依存関係に注意する。

### 依存関係逆転の原則（DIP：Dependency Inversion Principle）
ソースコードの依存関係が（具象ではなく）抽象だけを参照しているもの
・変化しやすい具象クラスを参照しない。その代わりに、抽象インターフェイスを参照する
・変化しやすい具象クラスを継承しない。
・具象関数をオーバーライドしない
・変化しやすい具象を名指しで参照しない




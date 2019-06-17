# Swift-Tips

## TableView
### 色を変えないようにする
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(false)
    if let indexPath = tableView.indexPathForSelectedRow {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

## NavigationController 
### 戻るボタンのハンドリング ： 以下は次の画面が TermOfServiceViewController だったら、TermOfServiceViewControllerを消すという動作。
extension RegistAuthUserViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is TermOfServiceViewController {
                viewController.dismiss(animated: true, completion: nil)
            }
        }
}

## CollectionView
### 動画や画像を画面いっぱいに表示したいのに、初期表示がいっぱいにならない
#### collectionView.contentInsetAdjustmentBehavior = .never
https://stackoverflow.com/questions/48101233/dont-use-safearea-inset-on-iphone-x-for-first-uitableviewcell
Marking the "Content insets" under Size Inspector to "Never" worked for me. 

## Tabbar
### tabbarのアイコンの文字を消して、アイコンを真ん中に持ってくる 
アイコンの文字を消す時は、baritem → image inset →　bottom を　−10, -12　にするとよい。



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
 sudo cp /System/Library/CoreServices/SystemVersion.plist ~/SystemVersion.plist.bak

書き換える
sudo nano -W /System/Library/CoreServices/SystemVersion.plist

戻す　リカバリーモードのターミナル
csrutil enable
 


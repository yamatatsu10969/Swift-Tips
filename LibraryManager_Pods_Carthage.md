# LibraryManager

### 導入したら .gitignoreを忘れない
```
# Pod
Pods/

# Carthage
Carthage/
```

# CocoaPods

## バージョン指定インストール
```
$ pod --version
0.33.1

$ gem uninstall cocoapods --version '=0.33.1'
Successfully uninstalled cocoapods-0.33.1

$ gem install -v 0.32.1 cocoapods

$ pod --version
0.32.1
```

## コマンド
`pod init`
`pod install`
`pod outdated` → 新しいバージョンがあるか

`pod update [NAME]` →一つだけアップデートする 

## 記事
[CocoaPodsのinstallとupdateを正しく使い分ける](http://noiselessworld.hatenablog.jp/entry/2016/12/17/212826)
[pod install vs. pod update](https://guides.cocoapods.org/using/pod-install-vs-update.html)



# Carthage

## インストール
`brew install carthage`

## コマンド
一つだけ
`carthage update RxSwif`

複数
`carthage update RxSwift realm-cocoa`

Cartfile.resolvedに記載されたバージョンをBuild
`carthage bootstrap --platform iOS`

時短。バイナリあれば
`carthage update --platform iOS --no-use-binaries`



## 手順
```
touch Cartfile

vi Cartfile

何かしら書く（例: github "SVProgressHUD/SVProgressHUD" ）

// 最初
carthage update --platform ios


TARGETS > General > Linked Frameworks and Libraries > Add Other > 導入したFramework

TARGETS > Build Phases > New Run Script Phase > ここに以下を記述

// 黒いところ。terminalみたいなとこ
/usr/local/bin/carthage copy-frameworks

// Input Files
$(SRCROOT)/Carthage/Build/該当のOS/該当のライブラリ.framework
例：　$(SRCROOT)/Carthage/Build/iOS/SVProgressHUD.framework

```

## 記事
[【Swift】Carthage導入手順](https://qiita.com/ShinokiRyosei/items/9b856ebdec5379b6c631)
[Carthageについて知りたいn個のこと](https://www.slideshare.net/syoikeda/carthagen)

[iOS開発における最強のパッケージ管理方法](https://qiita.com/omochimetaru/items/3a8441be9152ea6619b6)

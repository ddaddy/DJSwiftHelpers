# DJSwiftHelpers

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

DJSwiftHelpers is a Swift library containing useful Swift extensions. It allows you to perform many tasks easily.

## Integrate using Carthage

Install [Carthage](https://github.com/Carthage/Carthage#installing-carthage) if not already installed 

Change to the directory of your Xcode project, and Create and Edit your Cartfile and add DJSwiftHelpers:

``` bash
$ cd /path/to/MyProject
$ touch Cartfile
$ open Cartfile
```
Add the following line to your Cartfile

```
github "ddaddy/DJSwiftHelpers"
```

Save and then run:

``` bash
$ carthage update --platform ios
```

Once complete, drag both

* Carthage/Build/iOS/DJSwiftHelpers

into the `Frameworks, Libraries & Embeded Content` section of your project.

Don't forget to also add the above frameworks to the copy-frameworks

For more details on Cartage and how to use it, check the [Carthage Github](https://github.com/Carthage/Carthage) documentation


## Extensions Available

### Array
Split an `Array` into multiple arrays of size

```swift
chunked(into size: Int) -> [[Element]]
```

### String
Truncate a string by removing all characters at the `position`

```swift
truncated(limit: Int, position: TruncationPosition = .tail, leader: String = "") -> String
```

Allows you to use [8] subscript to get 1 character from a String

```swift
subscript(_ i: Int) -> String
```

Allows you to use [0..<9] subscript to truncate a String

```swift
subscript (r: Range<Int>) -> String
```

Allows you to use [0...8] subscript to truncate a String

```swift
subscript (r: CountableClosedRange<Int>) -> String
```

Convert a String into a Bool by looking for the relevant type texts (Yes, No, True etc..)

```swift
var bool: Bool?
```

Convert a String into a Double

```swift
toDouble() -> Double?
```

Convert a String to Data then saves it to the given URL path

```swift
save(path:URL) -> Bool
```
```swift
index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index?
```
```swift
endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index?
```
```swift
indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index]
```
```swift
ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>]
```

### UIApplication
Return the top most ViewController regardless if embeded in a navigation stack or not

```swift
getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
```

Display an alert regardless of what's on the screen

```swift
displayGlobalAlert(title:String, message:String, completion: (() -> Void)? = nil)
```

Dismiss back to the root view controller

```swift
dismisstoRoot(animated:Bool, completion:(() -> Void)? = nil)
```

### UIColor
Convert a hex string to a `UIColor`

```swift
init?(hex: String)
```

### UIDevice

```swift
var isPhone: Bool
var isPad: Bool
var isTV: Bool
var isCarPlay: Bool
```

### UIImage

Convert a String to Data then save it to the given URL path

```swift
saveAsPNG(path:URL) -> Bool
```
```swift
resize(width: CGFloat) -> UIImage
resize(height: CGFloat) -> UIImage
resize(size: CGSize) -> UIImage
```

### UIStackView
Remove and dealloc all subviews from a UIStackView

```swift
safelyRemoveArrangedSubviews()
```

Add a background color to a UIStackView

```swift
addBackground(color: UIColor)
```

### UIViewController
Displays a `UIAlertController` message with an "Ok" cancel button

```swift
displayAlert(title:String?, message:String?)
```
```swift
displayAlert(title:String?, message:String?, buttonAction:((UIAlertAction)->())?)
```

### UIWindow
Fetche the key window

```swift
var key: UIWindow?
```

### UserDefaults
Save to Us****erDefaults or remove it if nil

```swift
setOrDelete(value:String?, forKey key:String)
setOrDelete(value:Int?, forKey key:String)
```

## License	

Copyright (c) 2020 Darren Jones (Dappological Ltd.)

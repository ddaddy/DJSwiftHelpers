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
$ carthage update --use-xcframeworks
```

Once complete, drag both (as required)

* Carthage/Build/iOS/DJSwiftHelpers
* Carthage/Build/iOS/DJSwiftHelpers_Extension

into the `Frameworks, Libraries & Embeded Content` section of your project.

If adding to an extension, select `Do not embed` but also add to your main `iOS` or `watchOS` app and select `Embed & Sign`.


## Extensions Available

### Array
Removes an element from an `Array`. If the element occurs multiple times in the array, only the first element will be removed.

```swift
remove(element: Element)
```

Moves an element to a new index

```swift
move(_ element: Element, to newIndex: Index)
```
```swift
move(from oldIndex: Index, to newIndex: Index)
```

Split an `Array` into multiple arrays of size

```swift
chunked(into size: Int) -> [[Element]]
```

Filters an array to return one of each item where the keyPath elements are unique

```swift
uniques<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element]

Example:
.uniques(by: \.surname)
```

Filters an array to return one of each item where the combined keyPath elements are unique

```swift
uniques<T: Hashable, U: Hashable>(by keyPath: KeyPath<Element, T>, and secondKeyPath: KeyPath<Element, U>) -> [Element]

Example:
.uniques(by: \.firstName, and: \.surname)
```

### CLLocationCoordinate2D
Determine if a location is within a bounding rect

```swift
locationIsInside(minLat:Double, maxLat:Double, minLong:Double, maxLong:Double) -> Bool
```

### Collection (Array, Dictionary, Set etc..)
Removes the risk of `indexOutOfBounds` crashes.

```swift
subscript(safe index: Index) -> Element?
// array[safe: 5]
```

### Date
Adds additional seconds or minutes to a `Date`

```swift
adding(seconds: Int) -> Date
```

```swift
adding(minutes: Int) -> Date
```

Deduct one `Date` from another

```swift
- (lhs: Date, rhs: Date) -> TimeInterval
```

Converts an iso8601 string with or without milliseconds `2020-11-11T11:39:00Z` ro `2020-11-11T11:39:00.000Z`

**WARNING! These are expensive operations so probably best not to use in a loop**

```swift
var iso8601: String
```
```swift
var iso8601withFractionalSeconds: String
```
```swift
var iso8601: Date?
```
```swift
var iso8601withFractionalSeconds: Date?
```

### Double
Round doubles for less accurate comparisons

```swift
static func equal(_ lhs: Double, _ rhs: Double, precise value: Int? = nil) -> Bool
```
```swift
func precised(_ value: Int = 1) -> Double
```

### DJSwiftHelpers
Determines if running inside an app extension or not

```swift
static var isExtension:Bool
```

### FileManager

Fetches all contents (files & folders) in a specified file path and all subfolders

```swift
allContents(path: String) -> [URL]
```

Fetch contents (files & folders) in a specifies file path, none recursive

```swift
urls(for directory: FileManager.SearchPathDirectory, skipsHiddenFiles: Bool = true ) -> [URL]?
urls(for directory: URL, skipsHiddenFiles: Bool = true ) -> [URL]?
```

Parse a `json` file into the specified object type

```swift
readJSONFromFile<T: Decodable>(fileURL: URL, type: T.Type) -> T?
```

### Gradient

A `UIView` subclass with a gradient background.

Can be used in a storyboard as it supports `IBDesignable` however to use `IBDesignable` from an external framework you need to add this small class to your project:

```swift
@IBDesignable
class GradientView: Gradient {
    @IBInspectable override var startColor: UIColor {get { return super.startColor }set { super.startColor = newValue }}
    @IBInspectable override var endColor: UIColor {get { return super.endColor }set { super.endColor = newValue }}
    @IBInspectable override var startLocation: Double {get { return super.startLocation }set { super.startLocation = newValue }}
    @IBInspectable override var endLocation: Double {get { return super.endLocation }set { super.endLocation = newValue }}
    @IBInspectable override var horizontalMode: Bool {get { return super.horizontalMode }set { super.horizontalMode = newValue }}
    @IBInspectable override var diagonalMode: Bool {get { return super.diagonalMode }set { super.diagonalMode = newValue }}
}
```

### Locale

Return the emoji flag for the given Locale

```swift
var emojiFlag: String
```

### SafariActivityView

A SwiftUI view to display the share sheet with `Open in Safari`

```swift
Example:

.background(
	// Share button action
	SafariActivityView(isPresented: $activityPresented, url: url)
)
```

### String
Truncate a string by removing all characters at the `position`

```swift
truncated(limit: Int, position: TruncationPosition = .tail, leader: String = "") -> String
```

Delete a prefix if it exists

```swift
deletingPrefix(_ prefix: String) -> String
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

Splits a string into an array of lines

```swift
var lines: [SubSequence]
```

Returns a string that appears between 2 strings

```swift
func slice(from: String? = nil, to: String? = nil) -> String?
```

### UIApplication

Return the top most ViewController regardless if embeded in a navigation stack or not

```swift
class getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
```

Display an alert regardless of what's on the screen

```swift
class displayGlobalAlert(title:String, message:String, completion: (() -> Void)? = nil)
```

Dismiss back to the root view controller

```swift
class dismisstoRoot(animated:Bool, completion:(() -> Void)? = nil)
```

### UIColor
Convert a hex string to a `UIColor`

```swift
init?(hex: String)
```

Find the opposite colour of a `UIColor`

```swift
var inverted: UIColor
```

### UIDevice

```swift
var isPhone: Bool
var isPad: Bool
var isTV: Bool
var isCarPlay: Bool
```

### UIFont
Specify a font weight to a dynamic font style

```swift
static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont
```
use like:

```swift
label.font = UIFont.preferredFont(for: .title2, weight: .medium)
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

### UILabel
Adds an `SFSymbol` image to the beginning or end of a `UILabel`'s text

```swift
addSFSymbol(named:String, position:UILabel.SFSymbolPosition = .beginning, fontWeight weight:UIFont.Weight = .bold, fontDescriptorDesign design:UIFontDescriptor.SystemDesign = .rounded)
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

### UIView
Sets up the autolayout constraints to pin a view to it's superview

```swift
pinToSuperview(with insets: UIEdgeInsets = .zero, edges: UIRectEdge = .all)
```

Add a border to the insied of a `UIView` at a specific edge

```swift
addBorder(_ edge: UIRectEdge, color: UIColor, thickness: CGFloat)
```

### UIViewController
Displays a `UIAlertController` message with an "Ok" cancel button

```swift
displayAlert(title:String?, message:String?)
```
```swift
displayAlert(title:String?, message:String?, buttonAction:((UIAlertAction)->())?)
```
Add's & removes a child `UIViewController` to a continer view

```swift
addChild(_ child: UIViewController, in containerView: UIView)
```
```swift
removeChild(_ child: UIViewController)
```

### UIWindow
Fetches the key window

```swift
var key: UIWindow?
```

### UnkeyedDecodingContainer
Skips to the next container whilst iterating over an unkeyed decoding container using `while !container.isAtEnd { }`

```swift
skip()
```

### URLRequest
Generates a `URLRequest` whilst automatically converting headers and body to the correct formats

```swift
init?(url:URL, headers:[String:String], postBody:[String:Any], json:Bool = true, timeout:TimeInterval = 60.0)
```
```swift
init?(url:URL, headers:[String:String], postString:String, timeout:TimeInterval = 60.0)
```
```swift
init?(url:URL, headers:[String:String], parameters:[String:String], timeout:TimeInterval = 60.0)
```

### URLResponse
Returns the HTTP status code from a `URLResponse`

```swift
statusCode() -> Int?
```

### URLSession
A URLSession that will bypass an SSL certificate check.

#### WARNING!! Be careful where you use this! It can be dangerous.
```swift
static var selfSignedSSLSession:URLSession
```

### UserDefaults
Save to UserDefaults or remove it if nil

```swift
setOrDelete(value:String?, forKey key:String)
setOrDelete(value:Int?, forKey key:String)
```

## License	

Copyright (c) 2020 Darren Jones (Dappological Ltd.)


<img src="Assets/Header.png" alt="PillPickerView Logo" style="height: 150px;"/>

# PillPickerView

A SwiftUI library to present a Pill Picker view

- Highly customizable: PillPickerView offers a wide range of customization options to tailor the appearance of the pills to your needs. You can customize the font, border color, animation, width, height, corner radius, and color scheme of the pills.

- Easy integration: PillPickerView seamlessly integrates with SwiftUI, making it simple to add the pill picker to your SwiftUI-based app.

- Select multiple pills: You can select multiple pills simultaneously, and the library provides smooth transitions when adding or removing pills from the selection.

- Simple API: PillPickerView follows a straightforward API design, making it easy to use. It automatically adjusts the layout of pills to fit within the available space horizontally.

- iPadOS multitasking support: PillPickerView is designed to work with multitasking windows on iPadOS, providing a seamless experience across different app layouts.

- Compatibility: Supports iOS 14+, macOS 11+

- Lightweight and dependency-free: The library has a lightweight structure and does not have any external dependencies, minimizing its impact on your app's size and performance.

<br>

## Installation
Requires iOS 14+. PillPickerView can be installed through the [Swift Package Manager](https://developer.apple.com/documentation/swift_packages/adding_package_dependencies_to_your_app) (recommended) or [Cocoapods](https://cocoapods.org/).

<table>
<tr>
<td>
<strong>
Swift Package Manager
</strong>
<br>
Add the Package URL:
</td>
<td>
<strong>
Cocoapods
</strong>
<br>
Add this to your Podfile:
</td>
</tr>
  
<tr>
<td>
<br>

```
https://github.com/adisve/PillPickerView
```
</td>
<td>
<br>

```
pod 'PillPickerView'
```
</td>
</tr>
</table>

<br>

## Usage

Creating a PillPickerView

To create a pill picker, you need to follow these steps:

- Define a struct or enum that conforms to the Pill protocol. This protocol requires implementing the title property, which represents the title of each pill, as well as requiring the object to be Equatable and Hashable.

- In your SwiftUI view, create a @State or @Binding variable to hold the selected pills. For example:

```swift
@State private var selectedPills: [YourPillType] = []
```

<br>

Instantiate a PillPickerView by providing the necessary parameters, such as the list of items and the selected pills binding:

```swift
PillPickerView(
    items: yourItemList,
    selectedPills: $selectedPills
)
```

<br>

Here's an example usage of PillPickerView in a SwiftUI view:

```swift

struct ContentView: View {
    @State private var selectedPills: [YourPillType] = []

    var body: some View {
        VStack {
            // Your other content here
            
            PillPickerView(
                items: yourItemList,
                selectedPills: $selectedPills
            )
            
            // Your other content here
        }
    }
}
```

In the example above, replace YourPillType with your custom pill type and yourItemList with an array of items conforming to the Pill protocol.

## Customization

Customize the appearance of the pill picker by chaining the available modifier functions. For example:

```swift
.pillFont(.system(size: 16, weight: .semibold))
.pillSelectedForegroundColor(.white)
.pillSelectedBackgroundColor(.blue)
```

PillPickerView offers a range of customization options to tailor the appearance of the pills to your app's design. You can customize the font, colors, animation, size, and other visual aspects of the pills by using the available modifier functions. 

The PillPickerView includes a wrapping mechanism that automatically adjusts the layout of pills to fit within the available space. If the pills exceed the horizontal width of the container, the view wraps the excess pills to a new line. This makes it easy to present a large number of pills without worrying about truncation. The automatic wrapping behavior ensures a visually pleasing and user-friendly experience for your app's pill picker interface.

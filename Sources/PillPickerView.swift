/*
 PillPickerView.swift
 PillPickerView

 Created by A. Veletanlic (github.com/adisve) on 5/20/23.
 Copyright © 2023 A. Veletanlic. All rights reserved.

 MIT License

 Copyright (c) 2023 A. Veletanlic

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import SwiftUI

// MARK: - Protocols

/// Each Pill item must have a title,
/// which will be displayed on the actual pill.
public protocol Pill: Equatable, Hashable {
    var title: String { get }
}

// MARK: - Pill customizations

public struct PillOptions {
    
    /// Font type for a pill element
    public var font: Font = .system(size: 14, weight: .semibold, design: .rounded)
    
    /// Border color of a pill
    public var borderColor: Color = .clear
    
    /// The animation type which the pill will use
    /// when animating in/out in its parent view
    public var animation: Animation = .spring()
    
    /// Width of the pill
    public var width: CGFloat = 50
    
    /// Height of the pill
    public var height: CGFloat = 15
    
    /// Radius of the enclosing view of each pill
    public var cornerRadius: CGFloat = 40
    
    /// The background color of a pill when it is marked
    /// as being selected
    public var selectedBackgroundColor: Color = .accentColor
    
    /// The foregound color of a pill when it is marked
    /// as being selected
    public var selectedForegroundColor: Color = .white
    
    /// Background color of a pill when it is not selected
    public var normalBackgroundColor: Color = .accentColor.opacity(0.5)
    
    /// Foreground color of a pill when it is not selected
    public var normalForegroundColor: Color = .white
    
    /// Padding of elements inside PillItem
    public var padding: CGFloat = 5
    
}

// MARK: - Main view

public struct PillPickerView<T: Pill>: View {
    
    // MARK: - Properties
    
    /// Options for configuring each individual PillView
    public var options = PillOptions()
    
    /// Provider for the selectable items, passed as a
    /// @Binding list of elements conforming to PillEnum
    @Binding var selectedPills: [T]
    
    /// List of items that will be available to choose from
    let items: [T]
    
    // MARK: - Initialization
    
    public init(
        items: [T],
        selectedPills: Binding<[T]>
    ) {
        self.items = items
        self._selectedPills = selectedPills
    }
    
    // MARK: - Body
    
    public var body: some View {
        FlowStack(items: items, viewGenerator: { item in
            PillView(
                options: options,
                item: item,
                selectedPills: $selectedPills
            )
        })
    }
}

// MARK: - Extensions

public extension PillPickerView {
    
    /// The foreground color used for the title
    /// and icon in each pill when not selected
    func pillNormalForegroundColor(_ value: Color) -> PillPickerView {
        var view = self
        view.options.normalForegroundColor = value
        return view
    }
    
    /// The background color used for each pill
    /// when not selected
    func pillNormalBackgroundColor(_ value: Color) -> PillPickerView {
        var view = self
        view.options.normalBackgroundColor = value
        return view
    }
    
    /// The background color used for each pill when
    /// marked as being selected
    func pillSelectedBackgroundColor(_ value: Color) -> PillPickerView {
        var view = self
        view.options.selectedBackgroundColor = value
        return view
    }
    
    /// The foreground color used for the title
    /// and icon in each pill when marked as being selected
    func pillSelectedForegroundColor(_ value: Color) -> PillPickerView {
        var view = self
        view.options.selectedForegroundColor = value
        return view
    }
    
    /// The font used in each pill regardless of whether
    /// it is selected or not
    func pillFont(_ value: Font) -> PillPickerView {
        var view = self
        view.options.font = value
        return view
    }
    
    /// The minimum width of each pill
    func pillWidth(_ value: CGFloat) -> PillPickerView {
        var view = self
        view.options.width = value
        return view
    }

    /// The height of each pill
    func pillHeight(_ value: CGFloat) -> PillPickerView {
        var view = self
        view.options.height = value
        return view
    }
    
    /// The corner radius of each pill
    func pillCornerRadius(_ value: CGFloat) -> PillPickerView {
        var view = self
        view.options.cornerRadius = value
        return view
    }
    
    /// The border color of the edges of each pill
    func pillBorderColor(_ value: Color) -> PillPickerView {
        var view = self
        view.options.borderColor = value
        return view
    }
    
    /// The animation used when a pill is animated in
    /// its parent element, toggled when selected/removed
    func pillAnimation(_ value: Animation) -> PillPickerView {
        var view = self
        view.options.animation = value
        return view
    }
    
    func pillPadding(_ value: CGFloat) -> PillPickerView {
        var view = self
        view.options.padding = value
        return view
    }
    
}

// MARK: - Child views

/// View containing the selectable element
struct PillView<T: Pill>: View {
    
    // MARK: - Properties
    
    let options: PillOptions
    
    /// Passed element conforming to PillItem
    let item: T
    
    /// List of Binding items that are currently toggled
    @Binding var selectedPills: [T]
    
    
    // MARK: - Body
    
    public var body: some View {
        Button(action: {
            withAnimation(options.animation) {
                if !isItemSelected() {
                    selectedPills.append(item)
                }
            }
        }, label: {
            HStack {
                Text(item.title)
                    .font(options.font)
                    .foregroundColor(pillForegroundColor)
                if isItemSelected() {
                    Image(systemName: "xmark")
                        .font(options.font)
                        .foregroundColor(pillForegroundColor)
                        .padding(.leading, 5)
                        .onTapGesture {
                            withAnimation(options.animation) {
                                selectedPills.removeAll(where: { $0 == item })
                            }
                        }
                }
            }
            .padding(options.padding)
            .frame(minWidth: options.width)
        })
        .buttonStyle(
            PillItemStyle(
                selected: isItemSelected(),
                borderColor: options.borderColor,
                cornerRadius: options.cornerRadius,
                options: options
            )
        )
        .padding(5)
        .padding(.vertical, 2.5)
    }
    
    // MARK: - Helper Functions
    
    /// Checks if @Binding collection contains
    /// the given element
    func isItemSelected() -> Bool {
        return selectedPills.contains(item)
    }
    
    /// Retrieves the foreground color based
    /// on the state of the element
    private var pillForegroundColor: Color {
        if isItemSelected() {
            return options.selectedForegroundColor
        }
        return options.normalForegroundColor
    }
}

// MARK: - Button Styles

/// Basic Pill item style, giving some
/// bounce and label color
struct PillItemStyle: ButtonStyle {
    
    /// Whether pill is selected or not
    let selected: Bool
    
    /// Border color of the pill
    let borderColor: Color
    
    /// Corner radius of the pills border
    let cornerRadius: CGFloat
    
    let options: PillOptions
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(12)
            .background(background)
            .foregroundColor(foreground)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(options.animation, value: configuration.isPressed)
    }
    
    private var background: Color {
        return selected ? options.selectedBackgroundColor : options.normalBackgroundColor
    }
    
    private var foreground: Color {
        return selected ? options.selectedForegroundColor : options.normalForegroundColor
    }
}



// MARK: - FlowStack

/// View which automatically wraps element
/// in a HStack to a newline if it overflows
/// horizontally and does not fit the screen dimensions
public struct FlowStack<T, V>: View where T: Hashable, V: View {
    
    // MARK: - Types and Properties
    
    /// Alias for function type generating content
    typealias ContentGenerator = (T) -> V
    
    /// Collection of items passed to view
    var items: [T]
    
    /// Content generator function
    var viewGenerator: ContentGenerator
    
    /// Horizontal spacing of each item
    var horizontalSpacing: CGFloat = 2
    
    /// Vertical spacing for each item
    var verticalSpacing: CGFloat = 0

    /// Current total height calculated
    @State private var totalHeight = CGFloat.zero

    // MARK: - Body
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    // MARK: - Content Generation

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(items, id: \.self) { item in
                viewGenerator(item)
                    .padding(.horizontal, horizontalSpacing)
                    .padding(.vertical, verticalSpacing)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        return calculateLeadingAlignment(dimension: dimension, item: item)
                    })
                    .alignmentGuide(.top, computeValue: { dimension in
                        return calculateTopAlignment(item: item)
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
        
        // MARK: - Alignment calculations
        
        func calculateLeadingAlignment(dimension: ViewDimensions, item: T) -> CGFloat {
            if abs(width - dimension.width) > geometry.size.width {
                width = 0
                height -= dimension.height
            }
            let result = width
            if item == items.last {
                width = 0
            } else {
                width -= dimension.width
            }
            return result
        }
        
        func calculateTopAlignment(item: T) -> CGFloat {
            let result = height
            if item == items.last {
                height = 0
            }
            return result
        }
        
    }

    // MARK: - Height Calculation

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

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

// MARK: - Main view

/// This can be seen as a layer on top of the
/// already existing FlowStack library, but
/// giving some basic ease of use for views with collections
/// that are meant to be toggleable.
public struct PillPickerView<T: Pill>: View {
    
    // MARK: - Properties
    
    /// Background color of a pill when toggled
    let pillHighlightBackgroundColor: Color
    
    /// Foreground color of elements in pill when toggled
    let pillHighlightForegroundColor: Color
    
    /// Background color of a pill when not toggled
    let pillBackgroundColor: Color
    
    /// Foreground color of a pill when not toggled
    let pillForegroundColor: Color
    
    /// Provider for the selectable items, passed as a
    /// @Binding list of elements conforming to PillEnum
    @Binding var selectedItemsProvider: [T]
    
    /// List of items that will be available to choose from
    let items: [T]
    
    // MARK: - Initialization
    
    public init(
        items: [T],
        pillHighlightBackgroundColor: Color = .blue,
        pillHighlightForegroundColor: Color = .white,
        pillBackgroundColor: Color = .secondary,
        pillForegroundColor: Color = .white,
        selectedItemsProvider: Binding<[T]>
    ) {
        self.items = items
        self.pillHighlightBackgroundColor = pillHighlightBackgroundColor
        self.pillHighlightForegroundColor = pillHighlightForegroundColor
        self.pillBackgroundColor = pillBackgroundColor
        self.pillForegroundColor = pillForegroundColor
        self._selectedItemsProvider = selectedItemsProvider
    }
    
    // MARK: - Body
    
    public var body: some View {
        FlowStack(items: items, viewGenerator: { item in
            PillView(
                highlightBackgroundColor: pillHighlightBackgroundColor,
                backgroundColor: pillBackgroundColor,
                highlightForegroundColor: pillHighlightForegroundColor,
                foregroundColor: pillForegroundColor,
                item: item,
                selectedPills: $selectedItemsProvider)
        })
    }
}

// MARK: - Child views

/// View containing the selectable element
struct PillView<T: Pill>: View {
    
    // MARK: - Properties
    
    /// Background color of the pill when toggled
    let highlightBackgroundColor: Color
    
    /// Background color of the pill when not toggled
    let backgroundColor: Color
    
    /// Foreground color of the pill when toggled
    let highlightForegroundColor: Color
    
    /// Foreground color of the pill when not toggled
    let foregroundColor: Color
    
    /// Passed element conforming to PillItem
    let item: T
    
    /// List of Binding items that are currently toggled
    @Binding var selectedPills: [T]
    
    // MARK: - Body
    
    public var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                if !isItemSelected() {
                    selectedPills.append(item)
                }
            }
        }, label: {
            HStack {
                Text(item.title)
                    .foregroundColor(pillForegroundColor)
                if isItemSelected() {
                    Image(systemName: "xmark")
                        .foregroundColor(pillForegroundColor)
                        .padding(.leading, 5)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedPills.removeAll(where: { $0 == item })
                            }
                        }
                }
            }
            .frame(minWidth: 50)
        })
        /// Set the pill style and give some animation
        .buttonStyle(PillItemStyle(color: pillBackgroundColor))
        .padding(5)
        .padding(.vertical, 2.5)
    }
    
    // MARK: - Helper Functions
    
    /// Checks if @Binding collection contains
    /// the given element
    func isItemSelected() -> Bool {
        return selectedPills.contains(item)
    }
    
    /// Retrieves the background color based
    /// on the state of the element
    var pillBackgroundColor: Color {
        if isItemSelected() {
            return highlightBackgroundColor
        }
        return backgroundColor
    }
    
    /// Retrieves the foreground color based
    /// on the state of the element
    private var pillForegroundColor: Color {
        if isItemSelected() {
            return highlightForegroundColor
        }
        return foregroundColor
    }
}

// MARK: - Button Styles

/// Basic Pill item style, giving some
/// bounce and label color
struct PillItemStyle: ButtonStyle {
    let color: Color
    
    init(color: Color = .accentColor) {
        self.color = color
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(12)
            .background(color)
            .cornerRadius(30)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

// MARK: - FlowStack

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

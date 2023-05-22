import SwiftUI

// MARK: - Protocols

/// Each Pill item must have a title,
/// which will be displayed on the actual pill.
public protocol Pill: Equatable, Hashable {
    var title: String { get }
}

// MARK: - Enums

/// The style the pill content has, whether
/// it is dynamic and wrapping or statically placed
public enum StackStyle {
    case wrap
    case noWrap
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
    
    /// Minimum width of the pill
    public var minWidth: CGFloat = 50
    
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
    
    /// Whether pills should wrap to new line or not
    public var stackStyle: StackStyle = StackStyle.noWrap
    
    /// Spacing applied vertically between pill rows
    public var verticalSpacing: CGFloat = 5
    
    /// Spacing applied horizontally between pills
    public var horizontalSpacing: CGFloat = 2
    
    /// Trailing icon displayed inside the pills
    public var trailingIcon: Image? = nil
    
    /// Leading icon displayed inside the pills
    public var leadingIcon: Image? = nil
    
    /// Whether leading icon should only be displayed if
    /// the element is selected or not
    public var leadingOnlyWhenSelected: Bool = false
    
    /// Whether trailing icon should only be displayed if
    /// the element is selected or not
    public var trailingOnlyWhenSelected: Bool = false
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
        switch options.stackStyle {
        case StackStyle.noWrap:
            StaticStack(options: options, items: items, viewGenerator: { item in
                PillView(options: options, item: item, selectedPills: $selectedPills)
            })
        case StackStyle.wrap:
            FlowStack(options: options, items: items, viewGenerator: { item in
                PillView(options: options, item: item, selectedPills: $selectedPills)
            })
        }
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
    func pillMinWidth(_ value: CGFloat) -> PillPickerView {
        var view = self
        view.options.minWidth = value
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
    
    /// Padding of content inside each pill
    func pillPadding(_ value: CGFloat) -> PillPickerView {
        var view = self
        view.options.padding = value
        return view
    }
    
    /// The stack style the PillPickerView uses, either wrapping
    /// the pills to new lines or having them statically placed
    func pillStackStyle(_ value: StackStyle) -> PillPickerView {
        var view = self
        view.options.stackStyle = value
        return view
    }
    
    /// Set the vertical spacing of pills inside PillPickerView
    func pillViewVerticalSpacing(_ value: CGFloat) -> PillPickerView {
        var view = self
        view.options.verticalSpacing = value
        return view
    }
    
    /// Set the horizontal spacing of pills inside PillPickerView
    func pillViewHorizontalSpacing(_ value: CGFloat) -> PillPickerView {
        var view = self
        view.options.horizontalSpacing = value
        return view
    }
    
    func pillLeadingIcon(_ value: Image) -> PillPickerView {
        var view = self
        view.options.leadingIcon = value
        return view
    }
    
    func pillTrailingIcon(_ value: Image) -> PillPickerView {
        var view = self
        view.options.trailingIcon = value
        return view
    }
    
    func pillTrailingOnlySelected(_ value: Bool) -> PillPickerView {
        var view = self
        view.options.trailingOnlyWhenSelected = value
        return view
    }
    
    func pillLeadingOnlySelected(_ value: Bool) -> PillPickerView {
        var view = self
        view.options.leadingOnlyWhenSelected = value
        return view
    }
    
}

// MARK: - Pill View

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
                } else {
                    selectedPills.removeAll(where: { $0 == item })
                }
            }
        }, label: {
            HStack {
                if !options.leadingOnlyWhenSelected || isItemSelected() {
                    leadingIcon
                }
                Text(item.title)
                    .font(options.font)
                    .foregroundColor(pillForegroundColor)
                if !options.trailingOnlyWhenSelected || isItemSelected() {
                    trailingIcon
                }
            }
            .padding(options.padding)
            .frame(minWidth: options.minWidth)
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
    
    var leadingIcon: some View {
        options.leadingIcon
            .font(options.font)
            .foregroundColor(pillForegroundColor)
            .padding(.leading, 5)
    }
    
    var trailingIcon: some View {
        options.trailingIcon
            .font(options.font)
            .foregroundColor(pillForegroundColor)
            .padding(.leading, 5)
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

// MARK: - StaticStack


/// Stack of pills not wrapping to a new line
struct StaticStack<T, V>: View where T: Pill, V: View {
    
    /// Alias for function type generating content
    typealias ContentGenerator = (T) -> V
    
    let options: PillOptions
    
    /// Collection of items passed to view
    var items: [T]
    
    /// Content generator function
    var viewGenerator: ContentGenerator
    
    /// Chunk size which `items` is divided into
    @State private var chunkSize: Int = 1
    
    /// Current total height calculated
    @State private var totalHeight = CGFloat.zero
    
    private func calculateChunkSize(geometry: GeometryProxy) {
        let availableWidth = geometry.size.width
        let itemWidth: CGFloat = 100
        
        chunkSize = max(Int(availableWidth / (itemWidth + options.minWidth)), 1)
    }
    
    // MARK: - Height Calculation
    
    /// Used to calculate the total height of the view. It wraps the ZStack
    /// in a GeometryReader to obtain the height of the content and updates
    /// the `totalHeight` state variable accordingly.
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack(spacing: options.verticalSpacing) {
                    ForEach(items.chunked(into: chunkSize), id: \.self) { chunk in
                        HStack(spacing: options.horizontalSpacing) {
                            ForEach(chunk, id: \.self) { item in
                                viewGenerator(item)
                            }
                        }
                        .frame(width: geometry.size.width, alignment: .leading)
                    }
                }
                
                /// Necessary to get generated height
                /// of child elements combined, then
                /// set the parent `VStack` height accordingly
                .background(viewHeightReader($totalHeight))
                
                .onAppear {
                    calculateChunkSize(geometry: geometry)
                }
                
                /// Dynamically generate chunk size based on
                /// screen direction and dimension
                .onChange(of: geometry.size.width) { _ in
                    calculateChunkSize(geometry: geometry)
                }
            }
        }
        .frame(height: totalHeight)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Extension

extension Array {
    
    /// This method takes an integer `size`
    /// and returns a two-dimensional array ([[Element]])
    /// where the original array is divided into chunks of the specified size.
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

// MARK: - FlowStack

/// View which automatically wraps element
/// in a HStack to a newline if it overflows
/// horizontally and does not fit the screen dimensions
public struct FlowStack<T, V>: View where T: Pill, V: View {
    
    // MARK: - Types and Properties
    
    /// Alias for function type generating content
    typealias ContentGenerator = (T) -> V
    
    let options: PillOptions
    
    /// Collection of items passed to view
    var items: [T]
    
    /// Content generator function
    var viewGenerator: ContentGenerator

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
                    .padding(.horizontal, options.horizontalSpacing)
                    .padding(.vertical, options.verticalSpacing)
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
        
        /// Checks if adding the item's width to the current width value exceeds the
        /// available width (given by `geometry.size.width`). If it does, it resets width
        /// to 0 and subtracts the item's height from height to move to the next row.
        /// Otherwise, it returns the current `width` value and updates `width` by subtracting the item's width.
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
        
        /// Used to calculate the top (vertical) alignment for each item.
        /// It receives the item itself and returns the current height value.
        /// If the item is the last one, it resets `height` to 0.
        func calculateTopAlignment(item: T) -> CGFloat {
            let result = height
            if item == items.last {
                height = 0
            }
            return result
        }
        
    }
}

/// MARK: - Utility functions

/// Get height of context and set passed binding
/// parameter based on received value
func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
    return GeometryReader { geometry -> Color in
        let rect = geometry.frame(in: .local)
        DispatchQueue.main.async {
            binding.wrappedValue = rect.size.height
        }
        return .clear
    }
}

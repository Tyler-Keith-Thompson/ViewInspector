import SwiftUI

public extension ViewType {
    
    struct Slider: KnownViewType {
        public static var typePrefix: String = "Slider"
    }
}

// MARK: - Extraction from SingleViewContent parent

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
public extension InspectableView where View: SingleViewContent {
    
    func slider() throws -> InspectableView<ViewType.Slider> {
        return try .init(try child())
    }
}

// MARK: - Extraction from MultipleViewContent parent

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
public extension InspectableView where View: MultipleViewContent {
    
    func slider(_ index: Int) throws -> InspectableView<ViewType.Slider> {
        return try .init(try child(at: index))
    }
}

// MARK: - Custom Attributes

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
public extension InspectableView where View == ViewType.Slider {
    
    func labelView() throws -> InspectableView<ViewType.ClassifiedView> {
        let view = try Inspector.attribute(label: "label", value: content.view)
        return try .init(try Inspector.unwrap(content: Content(view)))
    }
    
    @available(*, deprecated, message: "Please use .labelView().text() instead")
    func text() throws -> InspectableView<ViewType.Text> {
        return try labelView().text()
    }
    
    func callOnEditingChanged() throws {
        let action = try Inspector.attribute(label: "onEditingChanged", value: content.view)
        typealias Callback = (Bool) -> Void
        if let callback = action as? Callback {
            callback(false)
        }
    }
}

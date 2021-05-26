//
//  Map.swift
//  ViewInspectorTests
//
//  Created by Tyler Thompson on 5/25/21.
//

#if canImport(MapKit)
import MapKit
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
public extension ViewType {
    struct Map: KnownViewType {
        public static let typePrefix: String = "Map"
        public static var namespacedPrefixes: [String] {
            return ["_MapKit_SwiftUI." + typePrefix]
        }
        public static func inspectionCall(typeName: String) -> String {
            return "map(\(ViewType.indexPlaceholder))"
        }
    }
}

// MARK: - Content Extraction

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
extension ViewType.Map: MultipleViewContent {
    public static func children(_ content: Content) throws -> LazyGroup<Content> {
        let provider = try Inspector.cast(value: content.view, type: MapContentProvider.self)
        let children = try provider.views()

        return LazyGroup(count: children.count) { index in
            try Inspector.unwrap(view: try children.element(at: index),
                                 medium: content.medium.resettingViewModifiers())
        }
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
private protocol MapContentProvider {
    func views() throws -> LazyGroup<Any>
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension Map: MapContentProvider {
    func views() throws -> LazyGroup<Any> {
        let s = self
        typealias Builder = (Data.Element) -> Content
//        let builder = try Inspector
//            .attribute(label: "content", value: self, type: Builder.self)
        let provider = try Inspector.attribute(label: "provider", value: content.view)
        let view = try Inspector.attribute(label: "content", value: provider)
        let data = try Inspector
            .attribute(label: "data", value: self, type: Data.self)
//        return try Inspector.viewsInContainer(view: view, medium: content.medium)

        return LazyGroup(count: data.count) { int in
            let index = data.index(data.startIndex, offsetBy: int)
            return builder(data[index])
        }
    }
}

// MARK: - Extraction from SingleViewContent parent

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension InspectableView where View: SingleViewContent {
    func map() throws -> InspectableView<ViewType.Map> {
        let call = ViewType.inspectionCall(
            base: ViewType.Map.inspectionCall(typeName: ""), index: nil)
        return try .init(try child(), parent: self, call: call)
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension InspectableView where View: MultipleViewContent {
    func map(_ index: Int) throws -> InspectableView<ViewType.Map> {
        let call = ViewType.inspectionCall(
            base: ViewType.Map.inspectionCall(typeName: ""), index: index)
        return try .init(try child(at: index), parent: self, call: call, index: index)
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension InspectableView where View == ViewType.Map {
    func coordinateRegion() throws -> Binding<MKCoordinateRegion> {
        try ViewType.Map.extractCoordinateRegion(from: self)
    }

    func interactionModes() throws -> MapInteractionModes {
        try ViewType.Map.extractInteractionModes(from: self)
    }

    func showsUserLocation() throws -> Bool {
        try ViewType.Map.extractShowsUserLocation(from: self)
    }

    func userTrackingMode() throws -> Binding<MapUserTrackingMode>? {
        try ViewType.Map.extractUserTrackingMode(from: self)
    }

    func mapRect() throws -> Binding<MKMapRect> {
        try ViewType.Map.extractMapRect(from: self)
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
private extension ViewType.Map {
    static func extractCoordinateRegion(from view: InspectableView<ViewType.Map>) throws -> Binding<MKCoordinateRegion> {
        let provider = try Inspector.attribute(label: "provider", value: view.content.view)
        let regionContainer = try Inspector.attribute(label: "region", value: provider)
        return try Inspector.attribute(label: "region", value: regionContainer, type: Binding<MKCoordinateRegion>.self)
    }

    static func extractInteractionModes(from view: InspectableView<ViewType.Map>) throws -> MapInteractionModes {
        let provider = try Inspector.attribute(label: "provider", value: view.content.view)
        return try Inspector.attribute(label: "interactionModes", value: provider, type: MapInteractionModes.self)
    }

    static func extractShowsUserLocation(from view: InspectableView<ViewType.Map>) throws -> Bool {
        let provider = try Inspector.attribute(label: "provider", value: view.content.view)
        return try Inspector.attribute(label: "showsUserLocation", value: provider, type: Bool.self)
    }

    static func extractUserTrackingMode(from view: InspectableView<ViewType.Map>) throws -> Binding<MapUserTrackingMode>? {
        let provider = try Inspector.attribute(label: "provider", value: view.content.view)
        return try Inspector.attribute(label: "userTrackingMode",
                                       value: provider,
                                       type: Binding<MapUserTrackingMode>?.self)
    }

    static func extractMapRect(from view: InspectableView<ViewType.Map>) throws -> Binding<MKMapRect> {
        let provider = try Inspector.attribute(label: "provider", value: view.content.view)
        let regionContainer = try Inspector.attribute(label: "region", value: provider)
        return try Inspector.attribute(label: "rect",
                                       value: regionContainer,
                                       type: Binding<MKMapRect>.self)
    }
}
#endif

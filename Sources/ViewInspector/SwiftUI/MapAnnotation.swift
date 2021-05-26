//
//  MapAnnotation.swift
//  ViewInspectorTests
//
//  Created by Tyler Thompson on 5/26/21.
//

#if canImport(MapKit)
import MapKit
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
public extension ViewType {
    struct MapAnnotation: KnownViewType {
        public static let typePrefix: String = "_MapAnnotationData"
        public static var namespacedPrefixes: [String] {
            return ["_MapKit_SwiftUI." + typePrefix]
        }
        public static func inspectionCall(typeName: String) -> String {
            return "mapAnnotation(\(ViewType.indexPlaceholder))"
        }
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension InspectableView where View: MultipleViewContent {
    func mapAnnotation(_ index: Int) throws -> InspectableView<ViewType.MapAnnotation> {
        let call = ViewType.inspectionCall(
            base: ViewType.MapAnnotation.inspectionCall(typeName: ""), index: index)
        return try .init(try child(at: index), parent: self, call: call, index: index)
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension InspectableView where View == ViewType.MapAnnotation {
//    func coordinateRegion() throws -> Binding<MKCoordinateRegion> {
//        try ViewType.MapAnnotation.extractCoordinateRegion(from: self)
//    }
//
//    func interactionModes() throws -> MapInteractionModes {
//        try ViewType.MapAnnotation.extractInteractionModes(from: self)
//    }
//
//    func showsUserLocation() throws -> Bool {
//        try ViewType.MapAnnotation.extractShowsUserLocation(from: self)
//    }
//
//    func userTrackingMode() throws -> Binding<MapUserTrackingMode>? {
//        try ViewType.MapAnnotation.extractUserTrackingMode(from: self)
//    }
//
//    func mapRect() throws -> Binding<MKMapRect> {
//        try ViewType.MapAnnotation.extractMapRect(from: self)
//    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
private extension ViewType.MapAnnotation {
//    static func extractCoordinateRegion(from view: InspectableView<ViewType.Map>) throws -> Binding<MKCoordinateRegion> {
//        let provider = try Inspector.attribute(label: "provider", value: view.content.view)
//        let regionContainer = try Inspector.attribute(label: "region", value: provider)
//        return try Inspector.attribute(label: "region", value: regionContainer, type: Binding<MKCoordinateRegion>.self)
//    }
//
//    static func extractInteractionModes(from view: InspectableView<ViewType.Map>) throws -> MapInteractionModes {
//        let provider = try Inspector.attribute(label: "provider", value: view.content.view)
//        return try Inspector.attribute(label: "interactionModes", value: provider, type: MapInteractionModes.self)
//    }
//
//    static func extractShowsUserLocation(from view: InspectableView<ViewType.Map>) throws -> Bool {
//        let provider = try Inspector.attribute(label: "provider", value: view.content.view)
//        return try Inspector.attribute(label: "showsUserLocation", value: provider, type: Bool.self)
//    }
//
//    static func extractUserTrackingMode(from view: InspectableView<ViewType.Map>) throws -> Binding<MapUserTrackingMode>? {
//        let provider = try Inspector.attribute(label: "provider", value: view.content.view)
//        return try Inspector.attribute(label: "userTrackingMode",
//                                       value: provider,
//                                       type: Binding<MapUserTrackingMode>?.self)
//    }
//
//    static func extractMapRect(from view: InspectableView<ViewType.Map>) throws -> Binding<MKMapRect> {
//        let provider = try Inspector.attribute(label: "provider", value: view.content.view)
//        let regionContainer = try Inspector.attribute(label: "region", value: provider)
//        return try Inspector.attribute(label: "rect",
//                                       value: regionContainer,
//                                       type: Binding<MKMapRect>.self)
//    }
}
#endif

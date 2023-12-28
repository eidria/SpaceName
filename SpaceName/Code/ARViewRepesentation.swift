//
//  ARViewRepesentation.swift
//  ObjectCaptureEdit
//
//  Created by Dan Galbraith on 9/25/23.
//

import SwiftUI

class ARViewRepesentationCoordinator {
}

struct ARViewRepesentation: NSViewRepresentable {
    @Environment(Photogrammetry.self) private var photogrammetry

    func makeNSView(context: Self.Context) -> RepresentedARView {
        let view = RepresentedARView()
        view.scene.addAnchor(photogrammetry.anchor)
        view.environment.lighting.intensityExponent = 3.0
        return view
    }

    func updateNSView(_ nsView: RepresentedARView, context: Self.Context) {
    }

    func makeCoordinator() -> ARViewRepesentationCoordinator {
        ARViewRepesentationCoordinator()
    }

    static func dismantleNSView(_ nsView: RepresentedARView, coordinator: ARViewRepesentationCoordinator) {
    }
}

#Preview {
    ARViewRepesentation()
}

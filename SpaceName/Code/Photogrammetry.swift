//
//  Photogrammetry.swift
//  SpaceName
//
//  Created by Dan Galbraith on 12/28/23.
//

import Foundation
import RealityKit

@Observable
class Photogrammetry {
    var session: PhotogrammetrySession
    var anchor = AnchorEntity()
    var modelProgressInfo: PhotogrammetrySession.Output.ProgressInfo? = nil
    var modelPercentageComplete: Double? = nil
    
    init() {
        let imageSourceURL = Bundle.main.resourceURL!
        try! session = PhotogrammetrySession(input: imageSourceURL)
        startSessionOutputHandling()
    }
    
    func createModel() {
        let request = PhotogrammetrySession.Request.modelEntity(detail: .preview, geometry: nil)
        do {
            try session.process(requests: [request])
        } catch {
            print("\(error)")
        }
    }
    
    private func startSessionOutputHandling() {
        Task {
            do {
                for try await output in session.outputs {
                    switch output {
                    case .processingComplete:
                        modelProgressInfo = nil
                        modelPercentageComplete = nil
                    case let .requestError(request, error):
                        handleRequestError(request: request, error: error)
                    case let .requestComplete(request, result):
                        handleRequestResult(request: request, result: result)
                    case let .requestProgress(request, fractionComplete):
                        handleRequestStatus(request: request, fractionComplete: fractionComplete)
                    case .inputComplete:
                        ()
                    case .invalidSample:
                        ()
                    case .skippedSample:
                        ()
                    case .automaticDownsampling:
                        ()
                    case .processingCancelled:
                        ()
                    case let .requestProgressInfo(request, info):
                        handleRequestProgress(request: request, info: info)
                    case .stitchingIncomplete:
                        ()
                    @unknown default: ()
                        //                        print("Unknown Photogrammetry Session Result received: \(output)")
                    }
                }
            } catch {
                print("Fatal session error! \(error)")
            }
        }
    }

    private func handleRequestProgress(request: PhotogrammetrySession.Request, info: PhotogrammetrySession.Output.ProgressInfo) {
        switch request {
        case .bounds: 
            ()
//            requestStatus.send(.objectBoundingBoxProgress(info))
        case .modelEntity:
            modelProgressInfo = info
        case .modelFile:
            ()
        case .pointCloud:
            ()
        case .poses:
            ()
        @unknown default: ()
            //            print("Unknown Photogrammetry Session Request Status received")
        }
    }
    
    private func handleRequestStatus(request: PhotogrammetrySession.Request, fractionComplete: Double) {
        switch request {
        case .bounds:
            ()
        case .modelEntity:
            modelPercentageComplete = fractionComplete
        case .modelFile:
            ()
        case .pointCloud:
            ()
        case .poses:
            ()
        @unknown default: ()
            //            print("Unknown Photogrammetry Session Request Status received")
        }
    }
    
    private func handleRequestResult(request: PhotogrammetrySession.Request, result: PhotogrammetrySession.Result) {
        switch request {
        case .bounds:
           ()
        case .modelEntity(_, _):
            if case let .modelEntity(entity) = result {
                anchor.children.removeAll()
                anchor.addChild(entity)
            }
        case .modelFile:
            ()
        case .pointCloud:
            ()
        case .poses:
            () // TODO: Don't handle this yet
        @unknown default: ()
            //           print("Unknown Photogrammetry Session Request Result received: \(result)")
        }
    }
    
    private func handleRequestError(request: PhotogrammetrySession.Request, error: Error) {
        switch request {
        case .bounds:
            ()
        case .modelEntity:
            ()
        case .modelFile:
            ()
        case .pointCloud:
            ()
        case .poses:
            ()
        @unknown default: ()
            //           print("Unknown Photogrammetry Session Request Status received in handleRequestError")
        }
    }
}

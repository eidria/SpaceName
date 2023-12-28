//
//  ContentView.swift
//  SpaceName
//
//  Created by Dan Galbraith on 12/28/23.
//

import SwiftUI

struct ContentView: View {
    @State private var photogrammetry = Photogrammetry()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    photogrammetry.createModel()
                } label: {
                    Text(verbatim: "Create Model")
                }
            }
            ZStack {
                ARViewRepesentation()
                    .environment(photogrammetry)
                if photogrammetry.modelPercentageComplete != nil {
                    HStack {
                        Text(verbatim: "Creating Test Model")
                        ProgressView(value: photogrammetry.modelPercentageComplete, total: 1.0)
                    }
                    .background{ Color.black }
                    .padding()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

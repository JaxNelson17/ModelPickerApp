//
//  ContentView.swift
//  ModelPickerApp
//
//  Created by Jaxson Nelson on 3/23/22.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    private var models: [String] = {
        // Dynamically get our file names
        let fileManager = FileManager.default
        
        guard let path = Bundle.main.resourcePath, let files = try? fileManager.contentsOfDirectory(atPath: path) else {
            return[]
        }
        var availableModels: [String] = []
        for fileName in files where
            fileName.hasSuffix("usdz") {
                let modelName = fileName.replacingOccurrences(of: ".usdz", with: "")
                availableModels.append(modelName)
        }
        return availableModels
    }()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            
            ModelPickerView(models: self.models)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

struct ModelPickerView: View {
    var models: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0..<self.models.count) { index in
                    Button(action: {
                        print("DEBUG: selected model with name: \(self.models[index])")
                              }) {
                                  Image(uiImage: UIImage(named: self.models[index])!)
                                      .resizable()
                                      .frame(height: 80)
                                      .aspectRatio(1/1, contentMode: .fit)
                                      .background(Color.white)
                                      .cornerRadius(12)
                        }
                              .buttonStyle(PlainButtonStyle())
                } // Bottom of ForEach
                           
            } // Bottom of HStack
        
        } // Bottom of Scrollview
        .padding(20)
        .background(Color.black.opacity(0.5))
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

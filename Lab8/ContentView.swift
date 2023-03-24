//
//  ContentView.swift
//  Lab8
//
//  Created by ICS 224 on 2023-03-24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    let world = try! Experience.loadWorld();
    @State var score = 0;
    var body: some View {
        VStack{
            ARViewContainer(worldAnchor: world, score: $score).edgesIgnoringSafeArea(.all)
            Button("button"){
                world.notifications.orbitTurd.post()
            }
            Text("score:" + String(score))
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    var worldAnchor:Experience.World
    @Binding var score:Int
    func makeUIView(context: Context) -> ARView {
            
            let arView = ARView(frame: .zero)
            
            // Load the "Box" scene from the "Experience" Reality File
            //let worldAnchor = try! Experience.loadWorld()
            
        self.worldAnchor.actions.knightWasHit.onAction = { entity in score+=1 }
            
            // Add the box anchor to the scene
            arView.scene.anchors.append(worldAnchor)
            
            return arView
            
        }
        func updateUIView(_ uiView: ARView, context: Context) {}
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

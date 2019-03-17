//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

enum Scenes: String {
    case opening = "OpeningScene"
}

if let sceneView: SKView = SceneLoader().loadScene(named: Scenes.opening.rawValue) {
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
}





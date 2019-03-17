//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit

if let sceneView: SKView = SceneLoader().loadScene(named: "GameScene") {
    PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
}





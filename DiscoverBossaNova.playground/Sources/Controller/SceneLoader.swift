import Foundation

import SpriteKit

public class SceneLoader {
    
    private let sceneWidth: CGFloat = 640
    private let sceneHeight: CGFloat = 480
    
    public init() {}
    
    public func loadScene(named: String) -> SKView? {
        
        guard let scene = GameScene(fileNamed: named) else {
            return nil
        }
        
        // Load the SKScene from 'GameScene.sks'
        let sceneView: SKView = SKView(frame: CGRect(x:0 , y:0, width: self.sceneWidth, height: self.sceneHeight))

        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        sceneView.presentScene(scene)
        
        return sceneView
    }
}

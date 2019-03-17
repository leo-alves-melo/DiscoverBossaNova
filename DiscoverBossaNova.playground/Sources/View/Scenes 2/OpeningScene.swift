import SpriteKit

class OpeningScene: SKScene, GameScene {
 
    private let openingDuration: Double = 5.0
    private let closingDuration: Double = 2.0
    
    var gameSceneDelegate: SceneCompletionDelegate?
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later

        let labelNode: SKLabelNode = SKLabelNode(text: "Rio de Janeiro, 1962")

        labelNode.alpha = 0.0
        let fadeInOut = SKAction.sequence([.fadeIn(withDuration: self.openingDuration),
                                           .fadeOut(withDuration: self.closingDuration)])
        labelNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        self.addChild(labelNode)
        labelNode.run(fadeInOut)
    }
}

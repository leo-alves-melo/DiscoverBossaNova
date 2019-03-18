import SpriteKit

class OpeningScene: SKScene, GameScene {
 
    private let openingDuration: Double = 3.0
    private let closingDuration: Double = 1.0
    
    var gameSceneDelegate: SceneCompletionDelegate?
    
    override func didMove(to view: SKView) {

        let labelNode: SKLabelNode = self.createLabel()

        let actions: SKAction = self.createActions()
        
        self.addChild(labelNode)
        labelNode.run(actions)
    }
    
    private func createLabel() -> SKLabelNode {
        let labelNode: SKLabelNode = SKLabelNode(text: "Rio de Janeiro, 1962")
        
        labelNode.fontSize = 20
        labelNode.fontName = "Courier"
        labelNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        labelNode.alpha = 0.0
        
        return labelNode
    }
    
    private func createActions() -> SKAction {
        let fadeInOut: SKAction = SKAction.sequence([.fadeIn(withDuration: self.openingDuration),
                                                     .fadeOut(withDuration: self.closingDuration)])
        
        let finish: SKAction = SKAction.run(self.finishScene)
        
        let actions: SKAction = SKAction.sequence([fadeInOut, finish])
        
        return actions
    }
    
    private func finishScene() {
        self.gameSceneDelegate?.didComplete()
    }
}

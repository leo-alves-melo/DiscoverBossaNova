import SpriteKit

class IntroductionScene: SKScene, GameScene {
    
    private let openingDuration: Double = 3.0
    private let closingDuration: Double = 2.0
    
    var gameSceneDelegate: SceneCompletionDelegate?
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        let background: SKSpriteNode = self.createBackground()
        
        let backgroundActions: SKAction = SKAction.sequence([.fadeIn(withDuration: self.openingDuration)])
        
        background.run(backgroundActions)
        
        self.addChild(background)
    }
    
    private func createBackground() -> SKSpriteNode {
        let background: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
        
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        
        background.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        
        background.alpha = 0.0
        
        return background
    }
}

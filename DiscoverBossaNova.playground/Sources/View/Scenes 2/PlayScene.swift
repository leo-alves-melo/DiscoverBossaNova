import SpriteKit

class PlayScene: SKScene, GameScene {
    
    private let background: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    
    var gameSceneDelegate: SceneCompletionDelegate?
    
    override func didMove(to view: SKView) {
        self.createBackground()
    }
    
    // MARK: - Private methods
    
    private func createBackground() {
        self.background.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.background.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        self.addChild(self.background)
    }
}

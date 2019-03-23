import SpriteKit

class PlayScene: SKScene, GameScene {
    
    // MARK: - Nodes
    
    private let background: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    private let tomJobimImage: SKSpriteNode = SKSpriteNode(imageNamed: "TomJobim")
    
    // MARK: - Properties
    
    var gameSceneDelegate: SceneCompletionDelegate?
    private let openingDuration: Double = 1.0
    
    // MARK: - Life cycle
    
    override func didMove(to view: SKView) {
        self.createBackground()
        self.setupTomJobimImage()
    }
    
    // MARK: - Private methods
    
    private func createBackground() {
        self.backgroundColor = UIColor.white
        
        self.background.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.background.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        
        self.background.run(SKAction.fadeAlpha(to: 0.75, duration: self.openingDuration))
        
        self.addChild(self.background)
    }
    
    private func setupTomJobimImage() {
        self.tomJobimImage.position = CGPoint(x: (self.tomJobimImage.texture?.size().width ?? 1)/4,
                                              y: (self.tomJobimImage.texture?.size().height ?? 1)/4)
        
        self.tomJobimImage.size = CGSize(width: (self.tomJobimImage.texture?.size().width ?? 1)/2,
                                         height: (self.tomJobimImage.texture?.size().height ?? 1)/2)

        self.addChild(self.tomJobimImage)
    }
}

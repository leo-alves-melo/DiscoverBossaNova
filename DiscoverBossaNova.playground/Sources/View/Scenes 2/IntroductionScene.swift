import SpriteKit

class IntroductionScene: SKScene, GameScene {

    // MARK: - Nodes
    
    private let textLabel: SKLabelNode = SKLabelNode(text: nil)
    let background: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    
    // MARK: - Properties
    
    private var textList: [String] = ["Brazil is a country full of beauties"]
    private let openingDuration: Double = 2.0
    private let closingDuration: Double = 1.0
    var gameSceneDelegate: SceneCompletionDelegate?
    
    // MARK: - Life cycle
    
    override func didMove(to view: SKView) {

        self.setupBackground()
        self.setupLabel()
    }
    
    // MARK: - Private methods
    
    private func createBackground() {
        self.background.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.background.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        self.background.alpha = 0.0
    }
    
    private func setupBackground() {
        self.createBackground()
        let backgroundActions: SKAction = SKAction.sequence([.fadeIn(withDuration: self.openingDuration)])
        self.background.run(backgroundActions)
        self.addChild(self.background)
    }
    
    private func setupLabel() {
        self.textLabel.text = self.textList[0]
        self.textLabel.fontSize = 18
        self.textLabel.verticalAlignmentMode = .center
        self.textLabel.horizontalAlignmentMode = .center
        self.textLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 50)
        self.addChild(self.textLabel)
    }
}

import SpriteKit

class IntroductionScene: SKScene, GameScene {

    // MARK: - Nodes
    
    private let textLabel: SKLabelNode = SKLabelNode(text: nil)
    private let background: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    private let textBackground: SKShapeNode = SKShapeNode()
    
    // MARK: - Properties
    
    private var textList: [String] = ["Brazil is a country full of beauties"]
    private let openingDuration: Double = 2.0
    private let closingDuration: Double = 1.0
    var gameSceneDelegate: SceneCompletionDelegate?
    
    // MARK: - Life cycle
    
    override func didMove(to view: SKView) {

        self.setupBackground()
        self.setupTextBackground()
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
        let fontName: String = UIFont.systemFont(ofSize: 18).fontName
        self.textLabel.fontName = fontName
        self.textLabel.fontSize = 17
        self.textLabel.verticalAlignmentMode = .center
        self.textLabel.horizontalAlignmentMode = .center
        self.textLabel.position = self.textBackground.position
        self.textLabel.fontColor = UIColor.black
        self.addChild(self.textLabel)
    }
    
    private func setupTextBackground() {

        self.textBackground.alpha = 0.5
        self.textBackground.position = CGPoint(x: self.frame.width/2 - 180, y: self.frame.height - 62)
        self.textBackground.path = UIBezierPath(roundedRect: CGRect(x: -128,
                                                                    y: -128,
                                                                    width: 360,
                                                                    height: 100), cornerRadius: 50).cgPath
        self.textBackground.fillColor = UIColor.white
        self.addChild(self.textBackground)
    }
}

import SpriteKit

class ClosingScene: SKScene, GameScene {
    
    // MARK: - Nodes
    
    private let textLabel: SKLabelNode = SKLabelNode(text: nil)
    private let background: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    private let textBackground: SKShapeNode = SKShapeNode()
    private let nextButton: SKSpriteNode = SKSpriteNode(imageNamed: "NextButton")
    private let tomJobimImage: SKSpriteNode = SKSpriteNode(imageNamed: "TomJobim")
    
    var score: Int = 0
    
    // MARK: - Properties
    
    private var textList: [String] = ["It became the second most covered song of all time! Frank Sinatra, Amy Winehouse and Madonna had versions of it",
                                      "\"Medicine, law, engineering, these are necessary to sustain life. But poetry, beauty, romance, love, these are what we stay alive for\", Dead Poets Society",
                                      "Play again?"]
    private var textListIndex: Int = 0
    private let openingDuration: Double = 2.0
    var gameSceneDelegate: SceneCompletionDelegate?
    
    // MARK: - Enum
    
    private enum Buttons: String {
        case next = "NextButton"
    }
    
    
    // MARK: - Life cycle
    
    convenience init(size: CGSize, score: Double) {
        self.init(size: size)
        self.score = Int(score)
        
    }
    
    override func didMove(to view: SKView) {
        self.setupText()
        self.setupBackground()
        self.setupTextBackground()
        self.setupLabel()
        self.setupNextButton()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let positionInScene: CGPoint = touch.location(in: self)
            let touchedNode: SKNode = self.atPoint(positionInScene)
            if let nodeName: String = touchedNode.name, let button: Buttons = Buttons(rawValue: nodeName) {
                switch button {
                case .next:
                    self.animateChangeLabel()
                }
            }
        }
    }
    
    // MARK: - Private methods
    
    private func setupText() {

        self.textList.insert("Awesome! You got \(self.score) points! And better: the song became a huge success!", at: 0)
    }
    
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
        self.textLabel.numberOfLines = 0
        self.textLabel.preferredMaxLayoutWidth = self.textBackground.frame.size.width - 20
        self.textLabel.fontSize = 17
        self.textLabel.verticalAlignmentMode = .center
        self.textLabel.horizontalAlignmentMode = .center
        self.textLabel.position = self.textBackground.position
        self.textLabel.fontColor = UIColor.black
        
        self.textLabel.alpha = 0.0
        self.textLabel.run(SKAction.fadeIn(withDuration: self.openingDuration))
        
        self.addChild(self.textLabel)
    }
    
    private func setupTextBackground() {
        
        self.textBackground.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 62)
        self.textBackground.path = UIBezierPath(roundedRect: CGRect(x: -180,
                                                                    y: -50,
                                                                    width: 360,
                                                                    height: 100), cornerRadius: 50).cgPath
        self.textBackground.fillColor = UIColor.white
        
        self.textBackground.alpha = 0.0
        self.textBackground.run(SKAction.fadeAlpha(by: 0.5, duration: self.openingDuration))
        self.addChild(self.textBackground)
    }
    
    private func setupNextButton() {
        self.nextButton.size = CGSize(width: 100, height: 100)
        self.nextButton.position = CGPoint(x: self.frame.width - 50 - 22, y: self.textBackground.position.y)
        self.nextButton.name = Buttons.next.rawValue
        self.nextButton.alpha = 0.0
        self.nextButton.run(SKAction.fadeIn(withDuration: self.openingDuration))
        self.addChild(self.nextButton)
    }
    
    private func nextText() {
        
        self.textListIndex += 1
        
        if self.textListIndex == 4 {
            self.setupTomJobimImage()
        }
        
        if self.textListIndex == self.textList.count - 1 {
            self.textLabel.text = self.textList[self.textListIndex]
            self.nextButton.texture = SKTexture(imageNamed: "PlayButton")
            
        } else if self.textListIndex == self.textList.count {
            self.gameSceneDelegate?.didComplete(with: nil)
        } else {
            self.textLabel.text = self.textList[self.textListIndex]
        }
    }
    
    private func animateChangeLabel() {
        let animation: SKAction = SKAction.sequence([.fadeOut(withDuration: 0.5),
                                                     SKAction.run(self.nextText),
                                                     .fadeIn(withDuration: 0.5)])
        
        self.textLabel.run(animation)
    }
    
    private func setupTomJobimImage() {
        self.tomJobimImage.position = CGPoint(x: (self.tomJobimImage.texture?.size().width ?? 1)/4,
                                              y: (self.tomJobimImage.texture?.size().height ?? 1)/4)
        
        self.tomJobimImage.size = CGSize(width: (self.tomJobimImage.texture?.size().width ?? 1)/2,
                                         height: (self.tomJobimImage.texture?.size().height ?? 1)/2)
        
        self.tomJobimImage.alpha = 0.0
        let fadeIn: SKAction = SKAction.fadeIn(withDuration: self.openingDuration)
        
        
        
        self.tomJobimImage.run(fadeIn)
        
        self.addChild(self.tomJobimImage)
    }
}

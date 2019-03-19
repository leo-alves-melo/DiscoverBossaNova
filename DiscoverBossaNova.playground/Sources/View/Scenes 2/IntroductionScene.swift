import SpriteKit

class IntroductionScene: SKScene, GameScene {

    // MARK: - Nodes
    
    private let textLabel: SKLabelNode = SKLabelNode(text: nil)
    private let background: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    private let textBackground: SKShapeNode = SKShapeNode()
    private let nextButton: SKSpriteNode = SKSpriteNode(imageNamed: "NextButton")
    private let tomJobimImage: SKSpriteNode = SKSpriteNode(imageNamed: "TomJobim")
    
    // MARK: - Properties
    
    private var textList: [String] = ["Brazil is a country full of beauties",
                                      "All these beauties inspired our artists in different ways",
                                      "That’s when Bossa Nova was created, a new music style mixing Samba and Jazz",
                                      "Helps Tom Jobim to compose \"Garota de Ipanema\" "]
    private var textListIndex: Int = 0
    private let openingDuration: Double = 2.0
    private let closingDuration: Double = 1.0
    var gameSceneDelegate: SceneCompletionDelegate?
    
    // MARK: - Enum
    
    private enum Buttons: String {
        case next = "NextButton"
    }
    
    
    // MARK: - Life cycle
    
    override func didMove(to view: SKView) {

        self.setupBackground()
        self.setupTextBackground()
        self.setupLabel()
        self.setupNextButton()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            if let nodeName: String = touchedNode.name, let button: Buttons = Buttons(rawValue: nodeName) {
                switch button {
                case .next:
                    self.animateChangeLabel()
                }
            }
        }
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
        self.textLabel.numberOfLines = 0
        self.textLabel.preferredMaxLayoutWidth = self.textBackground.frame.size.width
        self.textLabel.fontSize = 17
        self.textLabel.verticalAlignmentMode = .center
        self.textLabel.horizontalAlignmentMode = .center
        self.textLabel.position = self.textBackground.position
        self.textLabel.fontColor = UIColor.black
        self.addChild(self.textLabel)
    }
    
    private func setupTextBackground() {

        self.textBackground.alpha = 0.5
        self.textBackground.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 62)
        self.textBackground.path = UIBezierPath(roundedRect: CGRect(x: -180,
                                                                    y: -50,
                                                                    width: 360,
                                                                    height: 100), cornerRadius: 50).cgPath
        self.textBackground.fillColor = UIColor.white
        self.addChild(self.textBackground)
    }
    
    private func setupNextButton() {
        self.nextButton.size = CGSize(width: 100, height: 100)
        self.nextButton.position = CGPoint(x: self.frame.width - 50 - 22, y: self.textBackground.position.y)
        self.nextButton.name = Buttons.next.rawValue
        self.addChild(self.nextButton)
    }
    
    private func nextText() {
        
        self.textListIndex += 1
        
        if self.textListIndex == self.textList.count - 1 {
            self.textLabel.text = self.textList[self.textListIndex]
            self.nextButton.texture = SKTexture(imageNamed: "PlayButton")
            self.setupTomJobimImage()
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
        self.tomJobimImage.position = CGPoint(x: (self.tomJobimImage.texture?.size().width ?? 1)/2,
                                              y: (self.tomJobimImage.texture?.size().height ?? 1)/2)
        
        let fadeIn: SKAction = SKAction.fadeIn(withDuration: 0.5)
        
        self.tomJobimImage.run(fadeIn)
        
        self.addChild(self.tomJobimImage)
    }
}

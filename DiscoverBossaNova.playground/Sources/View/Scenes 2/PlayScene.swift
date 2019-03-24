import SpriteKit

class PlayScene: SKScene, GameScene {
    
    // MARK: - Nodes
    
    private let background: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    private let tomJobimImage: SKSpriteNode = SKSpriteNode(imageNamed: "TomJobim")
    private let board: SKSpriteNode = SKSpriteNode(imageNamed: "Board")
    private let greenButton: SKSpriteNode = SKSpriteNode(imageNamed: "GreenButton")
    private let yellowButton: SKSpriteNode = SKSpriteNode(imageNamed: "YellowButton")
    private let blueButton: SKSpriteNode = SKSpriteNode(imageNamed: "BlueButton")
    private let scoreLabel: SKLabelNode = SKLabelNode(text: "0")
    //private let song = SKAction.playSoundFileNamed("GarotaDeIpanema.m4a", waitForCompletion: false)
    
    // MARK: - Properties
    
    var gameSceneDelegate: SceneCompletionDelegate?
    private let openingDuration: Double = 1.0
    private let buttonsYPosition: CGFloat = 52
    private var greenButtonXPosition: CGFloat = 0
    private var yellowButtonXPosition: CGFloat = 0
    private var blueButtonXPosition: CGFloat = 0
    
    private var score: Int = 0
    
    private var timeToGoThroughBoard: TimeInterval = 5.0
    
    private var playableNotes: [SKNode] = []
    
    // MARK: - Enum
    
    private enum Notes {
        case green
        case yellow
        case blue
    }
    
    // MARK: - Life cycle
    
    override func didMove(to view: SKView) {
        self.setupBackground()
        self.setupTomJobimImage()
        self.setupBoard()
        self.setupBoardButtons()
        self.setupScore()
        self.setupNotesSequence()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: UITouch = touches.first {
            let positionInScene: CGPoint = touch.location(in: self)
            let touchedNode: SKNode = self.atPoint(positionInScene)
            
            self.validate(touchedNode: touchedNode)
        }
    }
    
    // MARK: - Private methods
    
    private func setupBackground() {
        self.backgroundColor = UIColor.white
        
        self.background.size = CGSize(width: self.frame.width + 2, height: self.frame.height + 2)
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
    
    private func setupBoard() {
        
        self.board.size = CGSize(width: (self.board.texture?.size().width ?? 1)/2,
                                 height: (self.board.texture?.size().height ?? 1)/2)
        
        self.board.position = CGPoint(x: self.size.width - 30 - self.board.size.width/2, y: self.size.height/2)
        
        self.addChild(self.board)
    }
    
    private func setupBoardButtons() {
        
        self.greenButton.size = CGSize(width: (self.greenButton.texture?.size().width ?? 1)/2,
                                       height: (self.greenButton.texture?.size().height ?? 1)/2)
        self.yellowButton.size = CGSize(width: (self.yellowButton.texture?.size().width ?? 1)/2,
                                       height: (self.yellowButton.texture?.size().height ?? 1)/2)
        self.blueButton.size = CGSize(width: (self.blueButton.texture?.size().width ?? 1)/2,
                                       height: (self.blueButton.texture?.size().height ?? 1)/2)
        
        self.greenButtonXPosition = 317 + self.greenButton.size.width/2
        self.greenButton.position = CGPoint(x: self.greenButtonXPosition,
                                            y: self.buttonsYPosition)
        
        self.yellowButtonXPosition = 46 + 317 + 3*self.yellowButton.size.width/2
        self.yellowButton.position = CGPoint(x: self.yellowButtonXPosition,
                                             y: self.buttonsYPosition)
        
        self.blueButtonXPosition = 2*46 + 315 + 5*self.blueButton.size.width/2
        self.blueButton.position = CGPoint(x: self.blueButtonXPosition,
                                           y: self.buttonsYPosition)
        
        self.addChild(self.greenButton)
        self.addChild(self.yellowButton)
        self.addChild(self.blueButton)
        
    }
    
    private func createNote(at xPosition: CGFloat, noteNode: SKSpriteNode) {
        
        noteNode.position = CGPoint(x: xPosition, y: self.size.height + noteNode.size.height)
        self.playableNotes.append(noteNode)
        
        noteNode.run(SKAction.moveTo(y: -noteNode.size.height, duration: self.timeToGoThroughBoard))
        
        self.addChild(noteNode)
        
    }
    
    private func create(note: Notes) {
        switch note {
        case .green:
            self.createNote(at: self.greenButtonXPosition,
                            noteNode: SKSpriteNode(imageNamed: "ScrollableGreenButton"))
        case .yellow:
            self.createNote(at: self.yellowButtonXPosition,
                            noteNode: SKSpriteNode(imageNamed: "ScrollableYellowButton"))
        case .blue:
            self.createNote(at: self.blueButtonXPosition,
                            noteNode: SKSpriteNode(imageNamed: "ScrollableBlueButton"))
        }
    }
    
    private func setupNotesSequence() {
        self.create(note: .green)
    }
    
    private func setupSong() {
        
    }
    
    private func setupScore() {
        let scoreBackground: SKSpriteNode = SKSpriteNode(imageNamed: "ScoreBackground")
        scoreBackground.position = CGPoint(x: 66 + scoreBackground.size.width/2,
                                           y: 360 + scoreBackground.size.height/2)
        
        self.addChild(scoreBackground)
        
        let scoreTitleLabel: SKLabelNode = SKLabelNode(text: "Score")
        scoreTitleLabel.fontColor = UIColor.white
        scoreTitleLabel.position = CGPoint(x: scoreBackground.position.x,
                                           y: scoreBackground.position.y + 10)
        scoreTitleLabel.fontName = UIFont.systemFont(ofSize: 35,
                                                     weight: .bold).fontName
        
        self.addChild(scoreTitleLabel)
        
        self.scoreLabel.fontName = UIFont.systemFont(ofSize: 35,
                                                      weight: .bold).fontName
        self.scoreLabel.fontColor = UIColor.white
        self.scoreLabel.position = CGPoint(x: scoreBackground.position.x,
                                           y: scoreBackground.position.y - 30)
        
        self.addChild(self.scoreLabel)
    }
    
    private func increaseScore() {
        self.score += 10
        self.scoreLabel.text = "\(self.score)"
    }
    
    private func validate(touchedNode: SKNode) {
        if self.playableNotes.contains(touchedNode) {
            if touchedNode.position.y < self.buttonsYPosition + self.blueButton.size.height/2,
                touchedNode.position.y > self.buttonsYPosition - self.blueButton.size.height/2 {
                self.increaseScore()
                self.disappear(note: touchedNode)
            }
        } else {
            if touchedNode == self.greenButton {
                if let closeNode: SKNode = self.playableNotes.first(where: { (node) -> Bool in
                    let xPositionCondition: Bool = node.position.x == self.greenButtonXPosition
                    let yPositionCondition: Bool = node.position.y < self.buttonsYPosition + self.blueButton.size.height/2 && node.position.y > self.buttonsYPosition - self.blueButton.size.height/2
                    
                    return xPositionCondition && yPositionCondition
                }) {
                    self.increaseScore()
                    self.disappear(note: closeNode)
                }
            } else if touchedNode == self.yellowButton {
                if let closeNode: SKNode = self.playableNotes.first(where: { (node) -> Bool in
                    let xPositionCondition: Bool = node.position.x == self.yellowButtonXPosition
                    let yPositionCondition: Bool = node.position.y < self.buttonsYPosition + self.blueButton.size.height/2 && node.position.y > self.buttonsYPosition - self.blueButton.size.height/2
                    
                    return xPositionCondition && yPositionCondition
                }) {
                    self.increaseScore()
                    self.disappear(note: closeNode)
                }
            } else if touchedNode == self.blueButton {
                if let closeNode: SKNode = self.playableNotes.first(where: { (node) -> Bool in
                    let xPositionCondition: Bool = node.position.x == self.blueButtonXPosition
                    let yPositionCondition: Bool = node.position.y < self.buttonsYPosition + self.blueButton.size.height/2 && node.position.y > self.buttonsYPosition - self.blueButton.size.height/2
                    
                    return xPositionCondition && yPositionCondition
                }) {
                    self.increaseScore()
                    self.disappear(note: closeNode)
                }
            }
        }
    }
    
    private func disappear(note: SKNode) {
        
        note.removeAllActions()
        
        let animationDuration: TimeInterval = 0.5
        let fadeAlpha: SKAction = SKAction.fadeAlpha(to: 0, duration: animationDuration)
        let increaseSize: SKAction = SKAction.scale(to: 2, duration: animationDuration)
        note.run(fadeAlpha)
        note.run(increaseSize)

        
        let sequence: SKAction = SKAction.sequence([SKAction.wait(forDuration: animationDuration),
                                                    SKAction.run {
                                                        note.removeFromParent()
                                                        self.finish()
            }])
        
        note.run(sequence)
        
    }
    
    private func finish() {
        self.gameSceneDelegate?.didComplete(with: Double(exactly: self.score))
    }
}

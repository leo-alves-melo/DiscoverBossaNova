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
    private let song = SKAction.playSoundFileNamed("GarotaDeIpanema.mp3", waitForCompletion: false)
    
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
        self.setupSong()
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
        // Base
        self.create(note: .green, after: 0)
        self.create(note: .yellow, after: 0.5)
        self.create(note: .green, after: 1)
        self.create(note: .yellow, after: 1.25)
        self.create(note: .yellow, after: 1.75)
        self.create(note: .green, after: 2)
        self.create(note: .yellow, after: 2.5)
        self.create(note: .green, after: 3)
        self.create(note: .yellow, after: 3.25)
        self.create(note: .yellow, after: 3.75)
        self.create(note: .green, after: 4)
        self.create(note: .blue, after: 4.5)
        self.create(note: .green, after: 5)
        self.create(note: .blue, after: 5.25)
        self.create(note: .blue, after: 5.75)
        self.create(note: .green, after: 6)
        self.create(note: .blue, after: 6.5)
        self.create(note: .green, after: 7)
        self.create(note: .blue, after: 7.25)
        self.create(note: .blue, after: 7.75)
        self.create(note: .yellow, after: 8)
        self.create(note: .blue, after: 8.5)
        self.create(note: .yellow, after: 9)
        self.create(note: .blue, after: 9.25)
        self.create(note: .blue, after: 9.75)
        self.create(note: .green, after: 10)
        self.create(note: .blue, after: 10.5)
        self.create(note: .green, after: 11)
        self.create(note: .blue, after: 11.25)
        self.create(note: .blue, after: 11.75)
        self.create(note: .green, after: 12)
        self.create(note: .yellow, after: 12.5)
        self.create(note: .green, after: 13)
        self.create(note: .yellow, after: 13.25)
        self.create(note: .yellow, after: 13.75)
        self.create(note: .green, after: 14)
        self.create(note: .yellow, after: 14.5)
        self.create(note: .green, after: 15)
        self.create(note: .yellow, after: 15.25)
        self.create(note: .yellow, after: 15.75)
        
        // Melody Intro
        self.create(note: .blue, after: 16)
        self.create(note: .blue, after: 16.5)
        self.create(note: .yellow, after: 16.75)
        self.create(note: .yellow, after: 17)
        self.create(note: .yellow, after: 17.5)
        self.create(note: .green, after: 17.75)
        self.create(note: .blue, after: 18)
        self.create(note: .blue, after: 18.5)
        self.create(note: .yellow, after: 18.75)
        self.create(note: .yellow, after: 19)
        self.create(note: .yellow, after: 19.25)
        self.create(note: .green, after: 19.5)
        self.create(note: .blue, after: 19.75)
        self.create(note: .blue, after: 20.25)
        self.create(note: .yellow, after: 20.75)
        self.create(note: .yellow, after: 21)
        self.create(note: .yellow, after: 21.5)
        self.create(note: .green, after: 21.75)
        
        self.create(note: .blue, after: 22)
        self.create(note: .blue, after: 22.5)
        self.create(note: .yellow, after: 22.75)
        self.create(note: .yellow, after: 23)
        self.create(note: .yellow, after: 23.25)
        self.create(note: .green, after: 23.5)
        self.create(note: .blue, after: 23.75)
        self.create(note: .blue, after: 24.25)
        self.create(note: .yellow, after: 24.75)
        self.create(note: .yellow, after: 25)
        self.create(note: .yellow, after: 25.5)
        self.create(note: .green, after: 25.75)
        self.create(note: .blue, after: 26)
        self.create(note: .blue, after: 26.5)
        self.create(note: .yellow, after: 26.75)
        self.create(note: .yellow, after: 27)
        self.create(note: .yellow, after: 27.25)
        self.create(note: .green, after: 27.5)
        self.create(note: .yellow, after: 27.75)
        
        // Melody 2
        self.create(note: .yellow, after: 32)
        self.create(note: .blue, after: 34.36)
        self.create(note: .yellow, after: 34.75)
        self.create(note: .green, after: 35.12)
        self.create(note: .blue, after: 35.5)
        self.create(note: .yellow, after: 35.88)
        self.create(note: .green, after: 36.25)
        self.create(note: .yellow, after: 38)
        
        self.create(note: .yellow, after: 40)
        self.create(note: .blue, after: 42.36)
        self.create(note: .yellow, after: 42.75)
        self.create(note: .green, after: 43.12)
        self.create(note: .blue, after: 43.5)
        self.create(note: .yellow, after: 43.88)
        self.create(note: .green, after: 44.25)
        self.create(note: .yellow, after: 46)
        
        self.create(note: .yellow, after: 48)
        self.create(note: .blue, after: 50.36)
        self.create(note: .yellow, after: 50.75)
        self.create(note: .green, after: 51.12)
        self.create(note: .blue, after: 51.5)
        self.create(note: .yellow, after: 51.88)
        self.create(note: .green, after: 52.25)
        self.create(note: .yellow, after: 54)
        
        self.create(note: .green, after: 55.25)
        self.create(note: .yellow, after: 55.64)
        self.create(note: .blue, after: 56)
        self.create(note: .green, after: 56.36)
        self.create(note: .yellow, after: 56.75)
        self.create(note: .blue, after: 57.13)
        self.create(note: .green, after: 57.5)
        self.create(note: .yellow, after: 57.75)
        self.create(note: .blue, after: 58)
        self.create(note: .blue, after: 58.75)
        
        self.create(note: .blue, after: 60)
        self.create(note: .green, after: 60.36)
        self.create(note: .yellow, after: 60.75)
        self.create(note: .blue, after: 61.13)
        self.create(note: .green, after: 61.5)
        self.create(note: .yellow, after: 61.75)
        self.create(note: .blue, after: 62)
        self.create(note: .blue, after: 62.75)
        
        // Melody Intro
        self.create(note: .blue, after: 64)
        self.create(note: .blue, after: 64.5)
        self.create(note: .yellow, after: 64.75)
        self.create(note: .yellow, after: 65)
        self.create(note: .yellow, after: 65.5)
        self.create(note: .green, after: 65.75)
        self.create(note: .blue, after: 66)
        self.create(note: .blue, after: 66.5)
        self.create(note: .yellow, after: 66.75)
        self.create(note: .yellow, after: 67)
        self.create(note: .yellow, after: 67.25)
        self.create(note: .green, after: 67.5)
        self.create(note: .blue, after: 67.75)
        self.create(note: .blue, after: 68.25)
        self.create(note: .yellow, after: 68.75)
        self.create(note: .yellow, after: 69)
        self.create(note: .yellow, after: 69.5)
        self.create(note: .green, after: 69.75)
        
        self.create(note: .blue, after: 70)
        self.create(note: .blue, after: 70.5)
        self.create(note: .yellow, after: 70.75)
        self.create(note: .yellow, after: 71)
        self.create(note: .yellow, after: 71.25)
        self.create(note: .green, after: 71.5)
        self.create(note: .blue, after: 71.75)
        self.create(note: .blue, after: 72.25)
        self.create(note: .yellow, after: 72.75)
        self.create(note: .yellow, after: 73)
        self.create(note: .yellow, after: 73.5)
        self.create(note: .green, after: 73.75)
        self.create(note: .blue, after: 74)
        self.create(note: .blue, after: 74.5)
        self.create(note: .yellow, after: 74.75)
        self.create(note: .yellow, after: 75)
        self.create(note: .yellow, after: 75.25)
        self.create(note: .green, after: 75.5)
        self.create(note: .yellow, after: 75.75)
        
        
    }
    
    private func create(note: Notes, after time: TimeInterval) {
        let sequence: SKAction = SKAction.sequence([SKAction.wait(forDuration: time), SKAction.run {
            self.create(note: note)
            }])
        
        self.run(sequence)
    }
    
    private func setupSong() {
        let sequence: SKAction = SKAction.sequence([SKAction.wait(forDuration: 4.3), self.song])
        self.run(sequence)
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
                                                        
            }])
        
        note.run(sequence)
        
    }
    
    private func finish() {
        self.gameSceneDelegate?.didComplete(with: Double(exactly: self.score))
    }
}

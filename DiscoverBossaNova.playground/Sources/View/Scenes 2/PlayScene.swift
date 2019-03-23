import SpriteKit

class PlayScene: SKScene, GameScene {
    
    // MARK: - Nodes
    
    private let background: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    private let tomJobimImage: SKSpriteNode = SKSpriteNode(imageNamed: "TomJobim")
    private let board: SKSpriteNode = SKSpriteNode(imageNamed: "Board")
    
    private let buttonsYPosition: CGFloat = 52
    
    private let greenButton: SKSpriteNode = SKSpriteNode(imageNamed: "GreenButton")
    private let yellowButton: SKSpriteNode = SKSpriteNode(imageNamed: "YellowButton")
    private let blueButton: SKSpriteNode = SKSpriteNode(imageNamed: "BlueButton")
    
    private var greenButtonXPosition: CGFloat = 0
    private var yellowButtonXPosition: CGFloat = 0
    private var blueButtonXPosition: CGFloat = 0
    
    private var score: Int = 0
    
    // MARK: - Properties
    
    var gameSceneDelegate: SceneCompletionDelegate?
    private let openingDuration: Double = 1.0
    
    // MARK: - Life cycle
    
    override func didMove(to view: SKView) {
        self.createBackground()
        self.setupTomJobimImage()
        self.setupBoard()
        self.setupBoardButtons()
    }
    
    // MARK: - Private methods
    
    private func createBackground() {
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
        
        self.blueButtonXPosition = 2*46 + 317 + 5*self.blueButton.size.width/2
        self.blueButton.position = CGPoint(x: self.blueButtonXPosition,
                                           y: self.buttonsYPosition)
        
        self.addChild(self.greenButton)
        self.addChild(self.yellowButton)
        self.addChild(self.blueButton)
        
    }
    
    
}

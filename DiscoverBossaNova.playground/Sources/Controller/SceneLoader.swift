import Foundation

import SpriteKit

class SceneLoader {
    
    private(set) var sceneWidth: CGFloat
    private(set) var sceneHeight: CGFloat
    
    init(sceneWidth: CGFloat, sceneHeight: CGFloat) {
        self.sceneWidth = sceneWidth
        self.sceneHeight = sceneHeight
    }
    
    func loadScene(sceneSequence: SceneSequence,
                   with value: Double?,
                   delegate: SceneCompletionDelegate) -> SKView? {
        
        var gameScene: GameScene?

        switch sceneSequence {
        case .opening:
            gameScene = OpeningScene(size: CGSize(width: self.sceneWidth, height: self.sceneHeight))
        case .introduction:
            gameScene = IntroductionScene(size: CGSize(width: self.sceneWidth, height: self.sceneHeight))
        case .playScene:
            gameScene = PlayScene(size: CGSize(width: self.sceneWidth, height: self.sceneHeight))
        case .closing:
            gameScene = ClosingScene(size: CGSize(width: self.sceneWidth, height: self.sceneHeight),
                                     score: value ?? 0)
        }
        
        let sceneView: SKView = SKView(frame: CGRect(x:0 , y:0, width: self.sceneWidth, height: self.sceneHeight))

        // Set the scale mode to scale to fit the window
        (gameScene as? SKScene)?.scaleMode = .aspectFill

        gameScene?.gameSceneDelegate = delegate

        // Present the scene
        sceneView.presentScene((gameScene as? SKScene))

        return sceneView
    }
}

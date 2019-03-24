import SpriteKit
import PlaygroundSupport

public class SceneController: SceneCompletionDelegate {
    
    // MARK: - Properties
    
    private let sceneLoader: SceneLoader = SceneLoader(sceneWidth: 640, sceneHeight: 480)
    
    private var currentScene: SceneSequence = SceneSequence.opening
    
    private var page: PlaygroundPage
    
    // MARK: - Init
    
    public init(page: PlaygroundPage) {
        self.page = page
    }
    
    // MARK: - Public Methods
    
    public func start() {
        
        self.loadScene(sequence: .opening, with: nil)
    }
    
    // MARK: - Private Methods
    
    private func loadScene(sequence: SceneSequence, with value: Double?) {
        guard let scene: SKView = self.sceneLoader.loadScene(sceneSequence: sequence,
                                                             with: value,
                                                             delegate: self) else {
                                                                return
        }

        self.page.liveView = scene

    }
    
    private func nextScene(value: Double?) {
        
        var nextScene: SceneSequence = .opening
        
        switch self.currentScene {
        case .opening:
            nextScene = .introduction
        case .introduction:
            nextScene = .playScene
        case .playScene:
            nextScene = .closing
        case .closing:
            nextScene = .playScene
        }
        
        self.currentScene = nextScene
        self.loadScene(sequence: nextScene, with: value)
    }
    
    // MARK: - Protocol Methods
    
    func didComplete(with value: Double?) {
        self.nextScene(value: value)
    }
}

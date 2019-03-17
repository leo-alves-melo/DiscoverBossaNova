import SpriteKit
import PlaygroundSupport

public class SceneController: SceneCompletionDelegate {
    
    private let sceneLoader: SceneLoader = SceneLoader(sceneWidth: 640, sceneHeight: 480)
    
    private var currentScene: SceneSequence = SceneSequence.opening
    
    private var page: PlaygroundPage
    
    // MARK: - Init
    
    public init(page: PlaygroundPage) {
        self.page = page
    }
    
    // MARK: - Public Methods
    
    public func start() {
        
        self.loadScene(sequence: .opening)
    }
    
    // MARK: - Private Methods
    
    private func loadScene(sequence: SceneSequence) {
        guard let scene: SKView = self.sceneLoader.loadScene(sceneSequence: sequence,
                                                             delegate: self) else {
                                                                return
        }

        self.page.liveView = scene

    }
    
    private func nextScene() {
        switch self.currentScene {
        case .opening:
            self.currentScene = .opening
            self.loadScene(sequence: .opening)
        }
    }
    
    // MARK: - Protocol Methods
    
    func didComplete() {
        self.nextScene()
    }
}

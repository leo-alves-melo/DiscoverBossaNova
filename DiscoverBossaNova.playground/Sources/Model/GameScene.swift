import SpriteKit

protocol GameScene: class {
    var gameSceneDelegate: SceneCompletionDelegate? {get set}
}

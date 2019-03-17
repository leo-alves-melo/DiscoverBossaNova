import Foundation

protocol GameScene: class {
    var gameSceneDelegate: SceneCompletionDelegate? {get set}
}

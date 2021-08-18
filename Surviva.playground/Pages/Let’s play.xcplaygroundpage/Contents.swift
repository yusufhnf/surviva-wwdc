/*:
 ### Before play the game, do this first:
 
 * Turn off “Enable Results” setting
 * Run in fullscreen mode (hide code editor)
 
 **Goal:** Keep your three bar to survive in life.
   
 In this game, players have to keep 3 bars so they are not empty. The bar will continue to decrease over time. The player only directs the object by touching, holding, and then pointing it at the item you want to pick up. However, avoid items that can make the bar drop quickly.
 
 ### The items are divided into 6 categories:
 1. Fun Item (🎳🎸🎹🎮🎻): +10 Fun bar
 2. Immune Item (🏸🏀🚴🏻‍♂️⚽️🏐): +10 Immune bar
 3. Health Item (🍚🥦🥕🥬🍎🍊): +10 Health bar
 4. Doctor Item (👩🏼‍⚕️): Fully all bar
 5. Enemy Item (🤧🤮🤢🗣👥🫂): -10 all bar
 6. Virus Item (🦠): -50 all bar
 
 Let’s Surviva!
 */


//#-hidden-code
import SpriteKit
import PlaygroundSupport
import UIKit

let skView = SKView(frame: .zero)

let gameScene = GameScene(size: UIScreen.main.bounds.size)
gameScene.scaleMode = .aspectFill
skView.presentScene(gameScene)
skView.preferredFramesPerSecond = 60
skView.showsNodeCount = true
skView.showsFPS = true

PlaygroundPage.current.liveView = skView
PlaygroundPage.current.wantsFullScreenLiveView = true
//#-end-hidden-code

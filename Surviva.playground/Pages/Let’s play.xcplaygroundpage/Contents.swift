/*:
 ### Before play the game, do this first:
 
 * Turn off โEnable Resultsโ setting
 * Run in fullscreen mode (hide code editor)
 
 **Goal:** Keep your three bar to survive in life.
 ย ย 
 In this game, players have to keep 3 bars so they are not empty. The bar will continue to decrease over time. The player only directs the object by touching, holding, and then pointing it at the item you want to pick up. However, avoid items that can make the bar drop quickly.
 
 ### The items are divided into 6 categories:
 1. Fun Item (๐ณ๐ธ๐น๐ฎ๐ป): +10 Fun bar
 2. Immune Item (๐ธ๐๐ด๐ปโโ๏ธโฝ๏ธ๐): +10 Immune bar
 3. Health Item (๐๐ฅฆ๐ฅ๐ฅฌ๐๐): +10 Health bar
 4. Doctor Item (๐ฉ๐ผโโ๏ธ): Fully all bar
 5. Enemy Item (๐คง๐คฎ๐คข๐ฃ๐ฅ๐ซ): -10 all bar
 6. Virus Item (๐ฆ ): -50 all bar
 
 Letโs Surviva!
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

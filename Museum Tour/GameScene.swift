//
//  GameScene.swift
//  Museum Tour
//
//  Created by Alan Chen on 11/1/14.
//  Copyright (c) 2014 Urban Games. All rights reserved.
//

import SpriteKit
import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer!

func playBackgroundMusic(filename: String) {
    let url = NSBundle.mainBundle().URLForResource(
        filename, withExtension: nil)
    if (url == nil) {
        println("Could not find file: \(filename)")
        return
    }
    
    var error: NSError? = nil
    backgroundMusicPlayer =
        AVAudioPlayer(contentsOfURL: url, error: &error)
    if backgroundMusicPlayer == nil {
        println("Could not create audio player: \(error!)")
        return
    }
    
    backgroundMusicPlayer.numberOfLoops = -1
    backgroundMusicPlayer.prepareToPlay()
    backgroundMusicPlayer.play()
}

class GameScene: SKScene {
//    var character = SKSpriteNode()
    var ground = SKNode()
    var paintingTexture = SKTexture()
    var descriptionTexture = SKTexture()
    var paintingMoveAndRemove = SKAction()
    
    var character: SKSpriteNode!
    var characterAtlas = SKTextureAtlas(named: "character")
    var characterFrames = [SKTexture]()
    
    var paintingList = ["asian1", "asian2"]
    var descList = ["asiandescription1", "asiandescription2"]
    
    var len = 0
    
    var count = 0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //Physics
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.0)
        
        //Background
        playBackgroundMusic("music.mp3")
        
        var background = SKSpriteNode(imageNamed: "beige.jpg")
        self.addChild(background)
        background.position = CGPointMake(self.size.width/2, self.size.height/2)
//        //Character
//        var characterTexture = SKTexture(imageNamed:"Alien")
//        characterTexture.filteringMode = SKTextureFilteringMode.Nearest
//        
//        character = SKSpriteNode(texture: characterTexture)
//        character.setScale(0.5)
//        character.position = CGPoint(x: self.frame.size.width * 0.35, y: self.frame.size.height * 0.8)
//        
//        character.physicsBody = SKPhysicsBody(circleOfRadius:character.size.height/2)
//        character.physicsBody?.dynamic = true
//        character.physicsBody?.allowsRotation = false
//        
//        self.addChild(character)
        
        //
        var totalImgs = characterAtlas.textureNames.count
        for var x = 1; x < totalImgs + 1; x++
        {
            var textureName = "p1_walk0\(x)"
            var texture = characterAtlas.textureNamed(textureName)
            println(textureName)
            characterFrames.append(texture)
        }
        
        character = SKSpriteNode(texture: characterFrames[0])
//        self.addChild(character)
        character.setScale(0.5)
        character.position = CGPoint(x: self.frame.size.width * 0.35, y: self.frame.size.height * 0.8)
        character.physicsBody = SKPhysicsBody(circleOfRadius:character.size.height/2)
        character.physicsBody?.dynamic = true
        character.physicsBody?.allowsRotation = false
        self.addChild(character)

        
        character.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(characterFrames, timePerFrame: 0.1, resize: false, restore: true)))
        
        
        //Ground
        
        var groundTexture = SKTexture(imageNamed: "ground")
        
        var sprite = SKSpriteNode(texture: groundTexture)
        sprite.setScale(2.0)
        sprite.position = CGPointMake(self.size.width/3.0, sprite.size.height/2.0)
        
        //self.addChild(sprite)
        
        ground.position = CGPointMake(0, groundTexture.size().height)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, groundTexture.size().height * 2.0))
        ground.physicsBody?.dynamic = false
        
        self.addChild(ground)
        
        //Paintings
        
        //Create the paintings
        
        //Shuffle the list of paintings and the list of descriptions
        
        len = paintingList.count
        print ("::")
        print (instance.gal)
        for i in 0...(len-1) {
            var rand = Int(arc4random_uniform(UInt32(len-i)))
            var temp = paintingList[i]
            var temp2 = descList[i]
            paintingList[i] = paintingList[rand]
            descList[i] = descList[rand]
            paintingList[rand] = temp
            descList[rand] = temp2
        }
        
        paintingTexture = SKTexture(imageNamed:"asian1")
        descriptionTexture = SKTexture(imageNamed:"asiandescription1")
        // Movement of paintings
        
        let distanceToMove = CGFloat(self.frame.size.width + 4.0 * paintingTexture.size().width)
        let movePaintings = SKAction.moveByX(-distanceToMove, y: 0.0, duration: NSTimeInterval(0.02 * distanceToMove))
        let removePaintings = SKAction.removeFromParent()
        
        paintingMoveAndRemove = SKAction.sequence([movePaintings, removePaintings])
        
        // Spawn Paintings
        
        let spawn = SKAction.runBlock({() in self.spawnPaintings()})
        let spawn_description = SKAction.runBlock({() in self.spawnDescriptions()})
        
        let delayPainting = SKAction.waitForDuration(NSTimeInterval(12.0))
        let delayDescription = SKAction.waitForDuration(NSTimeInterval(12.0))
        
        let spawnThenDelay = SKAction.sequence([spawn, delayPainting])
        let spawnThenDelayDescription = SKAction.sequence([spawn_description, delayDescription])
        
        let spawnThenDelayForever = SKAction.repeatActionForever(spawnThenDelay)
        let spawnThenDelayForever1 = SKAction.repeatActionForever(spawnThenDelayDescription)
        
        self.runAction(spawnThenDelayForever)
        //self.runAction(SKAction.waitForDuration(1.0))
        self.runAction(spawnThenDelayForever1)
    }
    
    func spawnPaintings() {
        var paintingFile = String()
        paintingFile = paintingList[count]
        paintingTexture = SKTexture(imageNamed: paintingFile)
        let painting = SKSpriteNode(texture: paintingTexture)
        painting.setScale(1.0)
        painting.position = CGPointMake(self.frame.size.width + paintingTexture.size().width/2.0, self.frame.size.height/2.0)
        
        painting.physicsBody = SKPhysicsBody(rectangleOfSize:painting.size)
        painting.physicsBody?.dynamic = false
        
        painting.runAction(paintingMoveAndRemove)
        self.addChild(painting)
    }
    
    func spawnDescriptions() {
        var descriptionFile = String()
        descriptionFile = descList[count]
        count += 1
        if (count == len) {
            count = 0
        }
        descriptionTexture = SKTexture(imageNamed: descriptionFile)
        let painting = SKSpriteNode(texture: descriptionTexture)
        painting.setScale(1.0)
        painting.position = CGPointMake(self.frame.size.width + paintingTexture.size().width * 1.5, self.frame.size.height/2.0)
        
        painting.physicsBody = SKPhysicsBody(rectangleOfSize:painting.size)
        painting.physicsBody?.dynamic = false
        
        painting.runAction(paintingMoveAndRemove)
        self.addChild(painting)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        runAction(SKAction.playSoundFileNamed("jump.wav", waitForCompletion: false))
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            character.physicsBody?.velocity = CGVectorMake(0, 0)
            character.physicsBody?.applyImpulse(CGVectorMake(0, 25))
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        // check player position and gameover if he dead
    }
}

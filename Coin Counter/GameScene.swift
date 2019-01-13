//
//  GameScene.swift
//  Coin Counter
//
//  Created by Julie Wu on 2019-01-08.
//  Copyright © 2019 Julie Wu. All rights reserved.
//

import SpriteKit
import GameplayKit

// Global Variables
var score2: Double!
var roundAnswer: Double!

var screenWidth: CGFloat!
var screenHeight: CGFloat!

class GameScene: SKScene {
    
    // Visual
    var roundLabel: SKLabelNode!
    var gameOverLabel: SKLabelNode!
    var inputBox: UITextField!
    var enterButton: UIButton!
    var nextButton: UIButton!
    var correctLabel: SKLabelNode!
    
    // In-Game
    var currentRound: Round!
    var currentRoundNumber = 1 {
        didSet{
            roundLabel.text = "Round: \(currentRoundNumber)"
        }
    }
    var score = 0.00 {
        didSet{
            correctLabel.text = "Correct! Your Score: $\(String(score))"
        }
    }
    var isGameOver: Bool!
    var isRoundOver: Bool!
    var gameTimer:Timer!
    
    // When the game screen first loads
    override func didMove(to view: SKView) {
        
        // Reset all variables
        isGameOver = false
        isRoundOver = false
        screenWidth = self.view?.frame.width
        screenHeight = self.view?.frame.height
        
        // Round Number Label
        roundLabel = SKLabelNode(text: "Round: 1")
        roundLabel.position = CGPoint(x: 0, y: 0)
        roundLabel.fontSize = 140
        roundLabel.fontColor = UIColor.lightGray
        roundLabel.fontName = "PingFang HK"
        roundLabel.zPosition = -1
        self.addChild(roundLabel)
        
        // Input Textfield
        inputBox = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        inputBox.center = CGPoint(x: screenWidth/2, y: screenHeight/2 - 100)
        inputBox.textColor = .black
        inputBox.backgroundColor = .white
        inputBox.keyboardType = UIKeyboardType.decimalPad
        inputBox.layer.cornerRadius = 5
        inputBox.textAlignment = .center
        self.view?.addSubview(inputBox)
        
        // Enter Button
        enterButton = UIButton(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        enterButton.center = self.view?.center ?? CGPoint(x: screenWidth/2, y: screenHeight/2)
        enterButton.backgroundColor = .white
        enterButton.setTitle("Enter", for: .normal)
        enterButton.setTitleColor(UIColor .black, for: .normal)
        enterButton.addTarget(self, action: #selector(EnterButtonAction), for: .touchUpInside)
        enterButton.titleLabel?.font = UIFont(name: "PingFang HK", size: 18)
        enterButton.layer.cornerRadius = 5
        self.view?.addSubview(enterButton)
        
        // Correct Label
        correctLabel = SKLabelNode(text: "Correct!")
        correctLabel.numberOfLines = 2
        correctLabel.preferredMaxLayoutWidth = self.frame.size.width - 200
        correctLabel.position = CGPoint(x: 0, y: 200)
        correctLabel.fontSize = 70
        correctLabel.fontColor = UIColor.white
        correctLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        correctLabel.fontName = "PingFang HK"
        self.addChild(correctLabel)
        
        // Next Button
        nextButton = UIButton(frame: CGRect(x: 0, y: 0, width: 75, height: 50))
        nextButton.center = self.view?.center ?? CGPoint(x: screenWidth/2, y: screenHeight/2)
        nextButton.backgroundColor = .white
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor .black, for: .normal)
        nextButton.addTarget(self, action: #selector(NextButtonAction), for: .touchUpInside)
        nextButton.titleLabel?.font = UIFont(name: "PingFang HK", size: 18)
        nextButton.layer.cornerRadius = 5
        self.view?.addSubview(nextButton)
        
        score = 0.00
        
        // Start first round
        SpawnCoins()
    }
    
    // After the round is over, ask the user for their input
    func AskInput() {
        
        roundLabel.isHidden = true
        
        inputBox.placeholder = "Enter Value Here"
        inputBox.isHidden = false
        
        enterButton.isHidden = false
        
    }
    
    // When the enter button is clicked
    @objc func EnterButtonAction(sender: UIButton!) {
        
        // Hide keyboard
        inputBox.resignFirstResponder()
        
        // store user's input
        let userAnswer = inputBox.text
        
        if userAnswer == String(roundAnswer) {
            
            // Correct Answer, move onto next round
            score += roundAnswer
            score = (Double(round(100*score)/100))
            currentRoundNumber += 1
            inputBox.isHidden = true
            enterButton.isHidden = true
            correctLabel.isHidden = false
            nextButton.isHidden = false
        }
        else{
            // hide all buttons
            enterButton.isHidden = true
            inputBox.isHidden = true
            roundLabel.isHidden = false
            correctLabel.isHidden = true
            nextButton.isHidden = true
            inputBox.text = ""
            // Game is over
            // store score in global score variable
            score2 = score
            // go to EndGame Scene
            let sceneToMove = EndGameScene()
            self.view!.presentScene(sceneToMove)
            
            
        }
        
    }
    
    // When next button is pressed
    @objc func NextButtonAction(sender: UIButton!) {
        SpawnCoins()
    }
    
    func SpawnCoins (){
        
        // hide all buttons
        enterButton.isHidden = true
        inputBox.isHidden = true
        roundLabel.isHidden = false
        correctLabel.isHidden = true
        nextButton.isHidden = true
        inputBox.text = ""
        
        // Create new round and spawn coins
        // Make round
        var ti: Double! = 1.5
        if (currentRoundNumber > 3) {
            ti = 2
        }
        
        currentRound = Round(roundNumber: currentRoundNumber)
        
        let delayTime: Double! = Double(currentRound.coins.count)*ti + 15
        
        roundAnswer = (Double(round(100*currentRound.answer)/100))
        gameTimer = Timer.scheduledTimer(timeInterval: ti, target: self, selector: #selector(addCoin), userInfo: nil, repeats: true)
        delayWithSeconds(delayTime) {
            self.gameTimer.invalidate()
            self.AskInput()
        }
    }
    
    // Used to spawn coins
    @objc func addCoin (){
        
        let screenWidth = self.frame.size.width
        let screenHeight = self.frame.size.width
        
        if currentRound.coins.count != 0 {
            
            let coin = SKSpriteNode(imageNamed: currentRound.coins[0].name)
            currentRound.coins.remove(at: 0)
            let randomXPos = GKRandomDistribution(lowestValue: 0 - Int(screenWidth/2) + Int(coin.size.width/2), highestValue: Int(screenWidth/2 - coin.size.width))
            let xPos = CGFloat(randomXPos.nextInt())
            
            coin.position = CGPoint(x: xPos, y: screenHeight)
            
            coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
            coin.physicsBody?.isDynamic = true
            
            self.addChild(coin)
            
            let animationDuration:TimeInterval = 15
            
            var actionArray = [SKAction]()
            actionArray.append(SKAction.move(to: CGPoint(x: xPos, y: -screenHeight/2 - coin.size.height), duration: animationDuration))
            actionArray.append(SKAction.removeFromParent())
            
            coin.run(SKAction.sequence(actionArray))
            
        }
    }
    
    // Used for delay
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}

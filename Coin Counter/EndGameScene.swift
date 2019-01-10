//
//  EndGameScene.swift
//  Coin Counter
//
//  Created by Julie Wu on 2019-01-09.
//  Copyright © 2019 Julie Wu. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class EndGameScene : SKScene {

    
    override func didMove(to view: SKView) {
        
        var exitButton: UIButton!
        var msg: UITextView!

        // Add message
        msg = UITextView(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
        msg.center = CGPoint(x: screenWidth/2, y: screenHeight/2 - 200)
        msg.textAlignment = .center
        msg.textColor = UIColor.white
        msg.backgroundColor = UIColor.black
        msg.font = UIFont(name: "PingFang HK", size: 24)
        msg.text = "Wrong Answer. The correct one was: $\(roundAnswer ?? 0). Your final score is: $\(score2 ?? 0)"
        self.view?.addSubview(msg)
        
        
        // Add Exit button
        exitButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
        exitButton.center = self.view?.center ?? CGPoint(x: 0, y: 0)
        exitButton.backgroundColor = .white
        exitButton.setTitle("Exit Game", for: .normal)
        exitButton.setTitleColor(UIColor .black, for: .normal)
        exitButton.addTarget(self, action: #selector(ExitButtonAction), for: .touchUpInside)
        exitButton.titleLabel?.font = UIFont(name: "PingFang HK", size: 24)
        self.view?.addSubview(exitButton)
    }

    
    // When the exit button is clicked
    @objc func ExitButtonAction(sender: UIButton!) {
        self.view?.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

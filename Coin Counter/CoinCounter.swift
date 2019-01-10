//
//  CoinCounter.swift
//  Coin Counter
//
//  Created by Julie Wu on 2019-01-08.
//  Copyright © 2019 Julie Wu. All rights reserved.
//

import Foundation

var allCoins = [Dollar(),Quarter(),Dime(),Nickel(),Penny(),Toonie()]

class Round {
    
    // variables
    var roundNumber: Int!
    var answer: Double!
    var coins = [Coin]()
    
    // produces the minimum number of coins that can be spawned according to round number
    func getMinCoins(n: Int) -> Int {
        if n%2 == 0 { return (n*5)/2 }
        else { return ((n+1)*5)/2 }
    }
    // produces the maximum number of coins that can be spawned according to round number
    func getMaxCoins(n: Int) -> Int{
        return (n*5) + 5
    }
    
    // stores the range of number of coins that can be spawned based on round number
    lazy var numCoinsRange: ClosedRange = getMinCoins(n: roundNumber)...getMaxCoins(n: roundNumber)
    
    // produces the answer for the round, based on the array of coins' values
    func getAnswer(arrayOfCoins aoc: [Coin]) -> Double {
        var sum = 0.0
        for i in 0...aoc.count-1{
            sum += aoc[i].value
        }
        return sum
    }
    
    // our initializer, takes in the round number
    init(roundNumber: Int) {
        
        self.roundNumber = roundNumber
        
        for _ in 1...Int.random(in: numCoinsRange){
            let coin = allCoins.randomElement()!
            coins.append(coin)
        }
        
        self.answer = getAnswer(arrayOfCoins: coins)
    }
}

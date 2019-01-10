//
//  Items.swift
//  Coin Counter
//
//  Created by Julie Wu on 2019-01-08.
//  Copyright © 2019 Julie Wu. All rights reserved.
//

import Foundation

class Coin {
    
    var value: Double
    var name: String
    
    init(value: Double, name: String){
        self.value = value
        self.name = name
    }
}

class Dollar: Coin {
    init(){
        super.init(value: 1, name: "Dollar")
    }
}

class Quarter: Coin {
    init(){
        super.init(value: 0.25, name: "Quarter")
    }
}

class Dime: Coin {
    init(){
        super.init(value: 0.1, name: "Dime")
    }
}

class Nickel: Coin {
    init(){
        super.init(value: 0.05, name: "Nickel")
    }
}

class Penny: Coin {
    init(){
        super.init(value: 0.01, name: "Penny")
    }
}

class Toonie:Coin{
    init(){
        super.init(value: 2, name: "Toonie")
    }
}


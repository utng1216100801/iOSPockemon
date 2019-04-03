//
//  Pockemons.swift
//  Pockemon
//
//  Created by Diana Manzano on 2/27/19.
//  Copyright © 2019 diana manzano. All rights reserved.
//

import UIKit

class Pockemons{
    var latitude:Double?
    var longitude:Double?
    var image:String?
    var name:String?
    var des:String?
    var power:Double?
    var isCatch:Bool?
    init(latitude:Double,longitude:Double,image:String, name:String, des:String, power:Double, isCatch:Bool){
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
        self.name = name
        self.des = des
        self.power = power
        self.isCatch = false
    }

}

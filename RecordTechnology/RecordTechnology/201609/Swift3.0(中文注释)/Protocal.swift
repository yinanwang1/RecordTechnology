//
//  Protocal.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/28.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import Foundation


class Protocal {
    
    func testPerson() {
        let john = Person(fullName: "john Appleseed")
        
        print("john.fullName is \(john.fullName)")
        
        let ncc1701 = Starship(name: "Enterprice", prefix: "USS")
        
        print("ncc 1701 is \(ncc1701.fullName)")
    }
    
    func testRandom() {
        let generator = LinearCongruentialGenerator()
        
        print("a random number: \(generator.random())")
        
        print("And another one: \(generator.random())")
    }
    
    func testOnOffSwitch() {
        var lightSwitch = OnOffSwitch.Off
        lightSwitch.toggle()
        
        print("lightSwitch is \(lightSwitch)")
    }
    
}

protocol FullyNamed {
    var fullName:String { get }
}

struct Person: FullyNamed {
    var fullName: String
}


class Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        
        return lastRandom / m
    }
}

protocol Togglabel {
    mutating func toggle()
}

enum OnOffSwitch: Togglabel {
    case Off, On
    
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On
        
        case .On:
            self = .Off
        }
    }
}



















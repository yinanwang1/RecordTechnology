//
//  NeskedType.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/27.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import Foundation

class NeskedType {
    func testBlackjack() {
        let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
        
        print("theAceOfSpades: \(theAceOfSpades.descripation)")
    }
    
    func testDouble() {
        let oneInch = 25.5.mm
        
        print("One inch is \(oneInch) meters")
        
        let threeFeet = 3.ft
        
        print("Three feet is \(threeFeet) meters")
        
        let aMarathon = 42.km + 195.m
        
        print("A marathon is \(aMarathon) meters long")
        
    }
    
    
    func testRect() {
        let defaultRect = Rect()
        
        let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
        
        print("defaultRect is \(defaultRect)")
        
        print("memberwiseRect is \(memberwiseRect)")
    }
    
    func testInt() {
        3.repetitions {
            print("Hello Arthur")
        }
        
        var someInt = 3
        
        someInt.square()
        
        print("someInt is \(someInt)")
        
        
        print("tst is \(12315446463434[0])")
        print("tst is \(12315446463434[3])")
        print("tst is \(12315446463434[3])")
        print("tst is \(12315446463434[5])")
        
    }
    
    func printIntegerKinds(numbers: [Int]) {
        for number in numbers {
            switch number.kind {
            case .Negative:
                print("- ", terminator: "")
                
            case .Zero:
                print("0 ", terminator: "")
                
            case .Positive:
                print("+ ", terminator: "")
            }
        }
        
        print("")
    }
    
    func testPrintInt() {
        printIntegerKinds(numbers: [2, 123, 34, -123, 0, -123, 99])
    }
    
}


struct BlackjackCard {
    
    enum Suit: Character {
        case  Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        
        struct Values {
            let first: Int, second: Int?
        }
        
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
                
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
                
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    let rank: Rank, suit: Suit
    
    var descripation: String {
        var output = "suit is \(suit.rawValue)"
        output += " value is \(rank.values.first)"
        
        if let second = rank.values.second {
            output += " or \(second)"
        }
        
        return output
    }
}


extension Double {
    var km: Double { return self * 1_000 }
    var m : Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

extension Int {
    func repetitions(task:() -> Void) {
        for _ in 0..<self {
            task()
        }
    }
    
    mutating func square() {
        self = self * self
    }
    
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        
        return (self / decimalBase) % 10
    }
    
    enum Kind {
        case Negative, Zero, Positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        
        case let x where x > 0:
            return .Positive
            
        default:
            return .Negative
        }
    }
}




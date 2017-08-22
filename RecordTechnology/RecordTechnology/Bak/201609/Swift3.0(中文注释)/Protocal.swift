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
    
    func swapTwoValues<T>( a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    func findStringIndex<T: Equatable>(array:[T], _ valueToFind: T) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        
        return nil
    }
    
    
    func testFindStringIndex() {
        let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
        if let foundIndex = findStringIndex(array: strings, "llamqa") {
            print("The index of llama is \(foundIndex)")
        } else {
            print("No, I can't find it!")
        }
        
        let doubleIndex = findStringIndex(array: [3.131415, 0.1, 0.23], 9.3)
        
        print("doubleIndex is \(doubleIndex)")
        
        let stringIndex = findStringIndex(array: ["Mike", "Malcolm", "Andrea"], "Andrea")
        
        print("stringIndex is \(stringIndex)")
    }
    
    fileprivate func someFunction() -> (InternalClass, PrivateClass) {
        let test1 = InternalClass()
        let test2 = PrivateClass()
        
        print("Test")
        
        return (test1, test2)
    }
    
    func testTrackingString() {
        var stringToEdit = TrackingString()
        stringToEdit.value = "This string will be tracked"
        stringToEdit.value += " This edit will increment numberOfEdits."
        stringToEdit.value += " So will this one"
        stringToEdit.value += " END"
        
        print("The number of edits is \(stringToEdit.numberOfEdits)")
    }
    
    func testVector() {
        let vector = Vector2D(x: 3.0, y: 1.0)
        let anotherVector = Vector2D(x: 2.0, y: 4.0)
        
        let combinedVector = vector + anotherVector
        
        print("combinedVector is \(combinedVector)")
        
        
        let positive = Vector2D(x: 3.0, y: 4.0)
        let negative = -positive
        
        print("negative is \(negative)")
        
        let alsoPositive = -negative
        
        print("alsoPositive is \(alsoPositive)")
        
    }
    
}

internal class InternalClass {
    
}

private class PrivateClass {
    
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

protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack: Container {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    typealias ItemType = Int
    
    mutating func append(item: Int) {
        self.push(item: item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct TrackingString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left1: Vector2D, right1: Vector2D) -> Vector2D {
        return Vector2D(x: left1.x + right1.x, y: left1.y + right1.y)
    }
    
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}



















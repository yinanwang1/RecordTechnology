//
//  StudentClass.swift
//  RecordTechnology
//
//  Created by ArthurWang on 15/9/2.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class StudentClass: NSObject {

    func sayHello() -> Void {
        print("Hello, I am swift")
    }
}



class StudentLow {
    var numberLow: Int = 0
    var namelow:String
    
    init(namelow:String) {
        self.namelow = namelow
    }
    
    func simpleDescription() -> String {
        return "I am a low student"
    }
}


class StudentHight: StudentLow {
    var grade: Double
    
    init(grade: Double, name: String) {
        self.grade = grade
        super.init(namelow: name)
        numberLow = 3
    }
    
    func  Grade() -> Double {
        return grade * 0.9
    }
    
    override func simpleDescription() -> String {
        return "I am a height student"
    }
}


class Celsius {
    var temperatureInCelsius: Double = 0.0
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    deinit {
        print("I am gone")
    }
}


class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    
    init(name: String, director: String) {
        self.director = director
        
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    
    init(name: String, artist: String) {
        self.artist = artist
        
        super.init(name: name)
    }
    
}

struct BlackjackCard {
    enum Suit: Character {
        case Spades = "🌱", Hearts = "🌲", Diamonds = "🌳", Clubs = "🌷"
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
}

protocol A {
    var a: String { get }
    var b: String { get set }
    mutating func method1();
}

class Test: A{
    var a:String = "hello victor"
    var b:String = "okok"
    func method1() {
        print("Nothing to do")
    }
}

struct Test1: A{
    var a:String = "hello victor"
    var b:String = "okok"
    func method1() {
        print("Struct is Test1")
    }
}






















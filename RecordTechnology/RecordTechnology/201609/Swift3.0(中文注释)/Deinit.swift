//
//  Deinit.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/25.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import Foundation

class Deinit {
    
    var reference1: Person?
    var reference2: Person?
    var reference3: Person?
    
    class func BankTest() {
        var playerOne: Player? = Player(coins: 100)
        
        print("A new player has joined the game with \(playerOne!.coinsInPuser) coins")
        
        print("There are now \(Bank.coinsInBank) coins left in the bank")
        
        playerOne!.winCoins(coins: 2_000)
        
        print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPuser) coins")
        
        print("The bank now only has \(Bank.coinsInBank) coins left")
        
        playerOne = nil
        
        print("PlayerOne has left the game")
        
        print("The bank now has \(Bank.coinsInBank) coins")
    }
    
    func persionTest() {
        
        reference1 = Person(name: "John Applessed")
        
        reference2 = reference1
        
        reference3 = reference1
    }
    
    func testCountry() {
        let country = Country(name: "Canada", capitalName: "Ottawa")
        
        print("\(country.name)'s capital city is called \(country.capitalCity.name)")
    }
    
    func testHTML() {
        let heading = HTMLElement(name: "h1")
        let defaultText = "some default text"
        
        heading.asHTML = {
            return "<\(heading.name)>\(heading.text ?? defaultText) </\(heading.name)>)"
        }
        
        print("****\n \(heading.asHTML())")
        
        
        var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
        
        print("*****\n \(paragraph!.asHTML())")
        
        paragraph = nil
        
    }
    
    
}



class Bank {
    static var coinsInBank = 10_000
    static func vendCoins(numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        
        return numberOfCoinsToVend
    }
    
    static func receiveCoins(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPuser: Int
    
    init(coins: Int) {
        coinsInPuser = Bank.vendCoins(numberOfCoinsRequested: coins)
    }
    
    func winCoins(coins: Int) {
        coinsInPuser += Bank.vendCoins(numberOfCoinsRequested: coins)
    }
    
    deinit {
        Bank.receiveCoins(coins: coinsInPuser)
    }
}

class Person {
    let name: String
    
    init(name: String) {
        self.name = name
        
        print("\(name) is being initiailized")
    }
    
    weak var apertment: Apartment?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    
    init(unit: String) {
        self.unit = unit
        
        print("\(unit) is being initiailized")
    }
    
    weak var tenant: Person?
    
    deinit {
        print("Apertment \(unit) is being deinitialized")
    }
}

class Customer {
    let name: String
    var card: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    
    unowned let customer: Customer
    
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

class Country {
    let name: String
    var capitalCity: City!
    
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: (Void) -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name;
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

















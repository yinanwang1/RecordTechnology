//
//  Optional.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/25.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import Foundation

enum VendingMachineError: Error {
    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}

struct Item {
    var price: Int
    var count: Int
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

class Optional {
    func testPerson() {
        let john = Person()
        
        john.residence = Residence()
        
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s)")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
    }
    
    func testPerson1() {
        let john = Person()
        
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has\(roomCount) room(s)")
        } else {
            print("Unable to retrieve the number of rooms")
        }
        
        john.residence?.address = createAddress()
        
        if john.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
            print("It was not possible to print the number of rooms")
        }
    }
    
    func createAddress() -> Address {
        print("Function was called.")
        
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        
        return someAddress
    }
    
    func testTest() {
        var testScores = ["Dave":[86, 82, 84], "Bev":[79, 94, 81]]
        
        testScores["Dave"]?[0] = 91
        testScores["Bev"]?[0] += 1
        testScores["Brian"]?[0] = 72
        
        print("testScores is \(testScores)")
    }
    
    func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        
        try vendingMachine.vend(itemNamed: snackName)
    }
    
    func testError() {
        let vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        
        do {
            try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
        } catch VendingMachineError.InvalidSelection {
            print("Invalid Selection")
        } catch VendingMachineError.OutOfStock {
            print("Out of stock")
        } catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins")
        } catch {
            
        }
    }
}


class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
    
    
}

class Room {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price:12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11),
    ]
    
    var coinsDeposited = 0
    
    func dispenseSnak(snack: String)  {
        print("Dispencing \(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.InvalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        dispenseSnak(snack: name)
    }
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        
        self.name = name
    }
}










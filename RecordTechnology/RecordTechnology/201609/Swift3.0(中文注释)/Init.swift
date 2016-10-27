//
//  Init.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/24.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class Init: NSObject {

    func fahrenheitTest() {
        let f = Fahrenheit()
        
        print("The default temperature is \(f.temperature)° Fahrenheit")
    }
    
    func celsiusTest() {
        let boilingPointOfWarter = Celsius(fromFahrenheit: 212.0)
        
        print("boilingPointOfWarter is \(boilingPointOfWarter)")
        
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        
        print("freezingPointOfWater is \(freezingPointOfWater)")
    }
    
    
    func colorTest() {
        let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        print("magenta is \(magenta)")
        
        let halfGray = Color(white: 0.5)
        
        print("halfGray is \(halfGray)")
    }
    
    func surveyQuestionTest() {
        let cheeseQeustion = SurveyQuestion(text: "Do you like cheese?")
        
        cheeseQeustion.ask()
    }
    
    func shoppingListItemtst() {
        let item = ShoppingListItem()
        
        print("item is \(item)")
    }
    
    func sizeTest() {
        let twoByTwo = Size(width: 2.0, height: 2.0)
        
        print("twoByTwo is \(twoByTwo)")
    }
    
    func foodTest() {
        let namedMeat = Food(name: "bacon")
        
        print("namedMeat is \(namedMeat.name)")
        
        print("Food() is \(Food().name)")
    }
    
    func recipeIngredientTest() {
        let oneMysteryItem = RecipeIngredient()
        
        print("oneMysteryItem.name is \(oneMysteryItem.name), quantity is \(oneMysteryItem.quantity)")
        
        let oneBacon = RecipeIngredient(name: "Bacon")
        
        print("oneBacon.name is \(oneBacon.name), quantity is \(oneBacon.quantity)")
        
        let sizEggs = RecipeIngredient(name: "Eggs", quantity: 6)
        
        print("sizEggs.name is \(sizEggs.name), quantity is \(sizEggs.quantity)")
    }
    
    func shoplistTest() {
        var breakfastList = [ShoppingListItemTest(), ShoppingListItemTest(name:"Bacon"), ShoppingListItemTest(name:"Eggs", quantity:6)]
        
        breakfastList[0].name = "Orange juice"
        breakfastList[1].purchased = true
        
        for item in breakfastList {
            print(item.description)
        }
    }
    
    func animalTest() {
        let someCreature = Animal(species: "")
        
        print("someCreature is \(someCreature)")
        
        if nil == someCreature {
            print("An animal was not initialized")
        }
    }
    
    func temperatureUnit() {
        let fahrenheitUnit = TemperatureUnit(symbol: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded")
        }
        
        let unknownUnit = TemperatureUnit(symbol: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
    }
    
}


struct Fahrenheit {
    var temperature: Double
    
    init() {
        temperature = 32.0
    }
}

struct Celsius {
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

struct Color {
    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

class SurveyQuestion {
    var text: String
    var response: String?
    
    init(text:String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var puchased = false
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    init() {}
    
    init(origin:Point, size:Size) {
        self.origin = origin
        self.size = size
    }
    
//    init(center: Point, size:Size) {
//        let originX = center.x - (size.width / 2)
//        let originY = center.y - (size.height / 2)
//        
//        self.init(origin:Point(x: originX, y: originY), size:size)
//    }
}


class Food {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name:"[Unnamed]")
    }
    
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

class ShoppingListItemTest: RecipeIngredient {
    var purchased = false
    
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "⟪" : "⟫"
        
        return output
    }
}

struct Animal {
    let species: String
    
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        
        self.species = species
    }
}


enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
            
        case "C":
            self = .Celsius
            
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}


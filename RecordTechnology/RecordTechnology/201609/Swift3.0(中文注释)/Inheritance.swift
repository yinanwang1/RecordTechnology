//
//  Inheritance.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/22.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class Inheritance: NSObject {

    let someVehicle = Vehicle()

    func vehicleTest() {
        print("Vehicle: \(someVehicle.description)")
    }
    
    func bicycleTest() {
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 15.0
        
        print("Bicycle is \(bicycle.description)")
    }
    
    func tandemTest() {
        let tandem = Tandem()
        
        tandem.hasBasket = true
        tandem.currentNumberOfPassengers = 2
        tandem.currentSpeed = 22.0
        
        print("Tandem: \(tandem.description)")
    }
    
    func trainTest()  {
        let train = Train()
        
        train.makeNoise()
    }
    
    func carTest() {
        let car = Car()
        car.currentSpeed = 25.0
        car.gear = 3
        
        print("Car: \(car.description)")
    }
}

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // Do nothing
    }
}

class Bicycle: Vehicle {
    var hasBasket = false
    
}

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

class Car: Vehicle {
    var gear = 1
    
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}




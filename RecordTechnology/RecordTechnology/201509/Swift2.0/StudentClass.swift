//
//  StudentClass.swift
//  RecordTechnology
//
//  Created by ArthurWang on 15/9/2.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class StudentClass: NSObject {

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





















//
//  OptionalExercise.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/7.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class OptionalExercise: NSObject
{
    var string1: String = "test"
    var age:String = ""
    
    func exercise() {
        let st = repertItem(item: "knock", numberOfTimes: 4)
        
        print(st)
    }
    
    func exercise3() {
        do {
            let printerResponse = try sendToPrinter(printername: "Never Has Toner")
            
            print(printerResponse)
        } catch {
            print(error)
        }
    }
    
    func exercise2() {
//        let a = SimpleClass()
        
        var a = SimpleStructure()
        a.adjust()
        
        print(a.simpleDescription)
    }
    
    
    func exercise1() {
        let stockCode:String? = findStockCode(company: "FaceBook")
        let text = "Stock Code - "
        
        if let tempStockCode = stockCode {
            let message = text + tempStockCode
            
            print("message is \(message)")
        } else {
            print("Baby I am sorry!")
        }
        
    }
    
    func findStockCode(company:String) -> String? {
        if company == "Apple" {
            return "AAPL"
        } else if company == "Google" {
            return "GOOG"
        }
        
        return nil
    }
    
    func sendToPrinter(printername: String) throws -> String {
        if printername == "Never Has Toner" {
            throw PrinterError.NoToner
        }
        
        return "Job sent"
    }
    
    func repertItem<Item>(item:Item, numberOfTimes: Int) -> [Item] {
        var result = [Item]()
        
        for _ in 0..<numberOfTimes {
            result.append(item)
        }
        
        return result
    }
}

protocol ExampleProtocol {
    var simpleDescription: String {get}
    mutating func adjust()
    
}


class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class"
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted"
    }
}

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

enum PrinterError: Error {
    case OutOfPaper
    case NoToner
    case OnFire
}












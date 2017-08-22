//
//  PropertyExercise.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/19.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class PropertyExercise: NSObject {
    struct Cuboid {
        var width = 0.0, height = 0.0, depth = 0.0
        
        var volume: Double {
            return width * height * depth;
        }
    }
    
    func structTest() {
        let result = Cuboid(width: 4.0, height:4.0, depth:4.0)
        
        print("result is \(result.volume)");
    }
    
    func stepTest() {
        let stepCounter = StepCounter()
        
        stepCounter.totalSteps = 200
        
        
        stepCounter.totalSteps = 360
        
        
        stepCounter.totalSteps = 896
        
        SomeStructure.storedTypeProperty = "123"
        
        print("SomeStructure.storedTypeProperty is \(SomeStructure.storedTypeProperty)")
    }
    
    class func mutatingTest() {
        var ovenLight = TriStateSwitch.Low
        
        ovenLight.next()
        print("ovenLight.next() is \(ovenLight)")
        
        ovenLight.next()
        print("ovenLight.next() is \(ovenLight)")
    }
    
    
    static func subscriptTest() {
        let threeTimesTable = TimeTalbe(multiplier: 3)
        
        print("six times three is \(threeTimesTable[6])")
    }
    
    static func matrixTest() {
        var matrix = Matrix(rows:2, columns:2)
        
        matrix[0, 1] = 1.5
        matrix[1, 0] = 3.2
        
        for row in 0..<2 {
            for column in 0..<2 {
                print("matrix is \(matrix[row, column])")
            }
        }
    }

}

struct Matrix {
    let rows: Int, columns: Int
    var grid:[Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating:0.0, count:rows * columns)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            
            return grid[(row * columns) + column]
        }
        
        set {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            
            grid[(row * columns) + column] = newValue
        }
    }
}

struct TimeTalbe {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

enum TriStateSwitch {
    case Off, Low, High
    
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}

struct SomeStructure {
    static var storedTypeProperty = "some value."
    static var computedTypeProperty: Int {
        return 1;
    }
}


class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

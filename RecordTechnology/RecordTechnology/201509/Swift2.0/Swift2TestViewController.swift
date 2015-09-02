//
//  Swift2TestViewController.swift
//  RecordTechnology
//
//  Created by ArthurWang on 15/9/2.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class Student {
    var num = 0
    
    func GetNum() -> Int {
        return num
    }
}

class Swift2TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let student = Student()
//        
//        student.num = 1;
//        
//        let Num = student.GetNum()
//        
//        print("Num is \(Num)")
        
        /***************/
        
//        let studentlow1 = StudentLow(namelow: "Json")
//        
//        studentlow1.numberLow = 2
//        
//        print("studentlow1 num is \(studentlow1.numberLow)")
//        print("studentlow1 name is \(studentlow1.namelow)")
//        print("studentlow1 information is \(studentlow1.simpleDescription())")
        
        
        /*****************************/
        
//        let studenthight1 = StudentHight(grade: 98, name: "lucy")
//        print("studenthight1 num is \(studenthight1.numberLow)")
//        print("studnetheight1 name is \(studenthight1.namelow)")
//        print("Greades is \(studenthight1.Grade())")
//        print("studenthight1 grade is \(studenthight1.grade)")
//        
//        print("studenthight1 information is \(studenthight1.simpleDescription())")
        
        /*****************************/
        
        
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        
        print("boilingPointOfWater is \(boilingPointOfWater.temperatureInCelsius)")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

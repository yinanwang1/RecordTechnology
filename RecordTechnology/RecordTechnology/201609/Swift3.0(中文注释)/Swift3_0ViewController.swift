//
//  Swift3_0ViewController.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/6.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

protocol Swift3_0ViewControllerDelegate {
    func test1(name:String) -> String;
}

class Swift3_0ViewController: UIViewController, Swift3_0ViewControllerDelegate {
    
    fileprivate var name = "private";

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NeskedType().testPrintInt()
        
//        Protocal().testPerson()
        
//        Protocal().testRandom()
        
        Protocal().testOnOffSwitch()
    }
    
    
    deinit {
        
    }
    
//    var john1: Customer?
//    
//    func testCreditCard() {
//        john1 = Customer(name: "John Appleseed")
//        
//        john1!.card = CreditCard(number: 1234_5678_9012_3456, customer: john1!)
//        
//        john1 = nil
//    }
//    
//    var john: Person?
//    var unit4A: Apartment?
//    
//    func testDeinit() {
//        john = Person(name: "John Appleseed")
//        unit4A = Apartment(unit: "4A")
//        
//        john!.apertment = unit4A
//        unit4A!.tenant = john
//        
//        john = nil
//        unit4A = nil
//    }
    
    
    func testName() {
        print("name is \(name)");
        
        
        testSwap();
        
        let oldArray = [1,2,3,4,5,6,7,8,9];
        let newArray = oldArray.filter({$0 > 4})
        
        print("newArray is \(newArray)");
        
        incrementBy(amount: 5, numberOfTimes: 10)
        
        print("count is \(count)")
    }
    
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes times: Int) {
        count += amount * times;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var someInt = 3
    var anotherInt = 107
    
    
    func swapTwoInts( a:inout Int, b:inout Int) {
        a = 107
        b = 3
    }
    
    func testSwap() {
        swapTwoInts(a: &someInt, b: &anotherInt);
        
        print("someInt is \(someInt), anotherInt is \(anotherInt)");
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func test1(name: String) -> String {
        print("That is nothing!");
        
        return "Game is over!";
    }
    
    
    func testDate() {
        DateExercise.exerciseClassFunc()
        
        
        DateExercise().exercise();
        
    }
    
    func testOptional() {
        OptionalExercise().exercise();
    }
}

extension Swift3_0ViewController {
    var accessPrivate: String {
        return name;
    }
    
    func test(){
        print("Test is wyn");
    }
}


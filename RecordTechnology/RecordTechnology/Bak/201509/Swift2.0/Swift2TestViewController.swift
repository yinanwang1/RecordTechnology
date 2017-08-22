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

//extension Int {
//    subscript(index: Int) -> Int {
//        var decimalBase = 1
//        for _ in 1...index {
//            decimalBase *= 10
//        }
//        
//        return (self / decimalBase) % 10
//    }
//    
//}

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
        
        
//        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
//        
//        print("boilingPointOfWater is \(boilingPointOfWater.temperatureInCelsius)")
        
//        let john = Person()
//        john.residence = Residence()
//        if let roomCount = john.residence?.numberOfRooms {
//            print("John's residence hase \(roomCount) room(s).")
//        } else {
//            print("Unable to retrieve the number of rooms")
//        }
        
//        let library = [
//            Movie(name: "Casablanca", director: "Michael Curtiz"),
//            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
//            Movie(name: "Citizen Kane", director: "Orson Welles"),
//            Song(name: "The one And Only", artist: "Chesney Hawkes"),
//            Song(name: "Never Gonna Give You UP", artist: "Rick Astley")
//        ]
//        
//        var movieCount = 0
//        var songCount = 0
//        
//        for item in library {
//            if item is Movie {
//                ++movieCount
//            } else if item is Song {
//                ++songCount
//            }
//        }
//        
//        print("Media library contains \(movieCount) movies and \(songCount) songs")
//        
//        
//        for item in library {
//            if let movie = item as? Movie {
//                print("Movie:'\(movie.name)', dir.\(movie.director)")
//            } else if let song = item as? Song {
//                print("Song: '\(song.name)', by \(song.artist)")
//            }
//        }
        
//        let obj: Objective = Objective()
//        
//        obj.sayHello()
        
//        print(711923719237[0])
        
//        let m = Test()
//        m.a = "aaaaa"
//        m.b = "ccccc"
//        
//        print(m.a + m.b)
        
        
//        let d6 = Dice(sides: 10000, generator: LinearCongruentialGenerator())
//        
//        for _ in 1...5 {
//            print("Random dice roll is \(d6.roll())")
//        }
        
        let tracker = DiceGameTracker()
        let game = SnakeAndLadders()
        game.delegate = tracker
        game.play()
        
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

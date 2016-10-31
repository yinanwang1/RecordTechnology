//
//  DateExercise.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/7.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import UIKit

class DateExercise: NSObject {

    func exercise() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var dateString = "2016-08-08 18:25:17"
        let date1 = dateFormatter.date(from: dateString)
        
        dateString = "1985-02-05 07:45:38"
        let date2 = dateFormatter.date(from: dateString)
        
        let calendar = Calendar.current
        
        let diffComponents = calendar.dateComponents([Calendar.Component.year,
                                                      Calendar.Component.month,
                                                      Calendar.Component.day,
                                                      Calendar.Component.hour,
                                                      Calendar.Component.minute,
                                                      Calendar.Component.second], from: date1!, to: date2!)
        
        print("\(diffComponents.year)years, \(diffComponents.month)month, \(diffComponents.day)day")
    }
    
    func exercise4() {
        var newDateComponents = DateComponents()
        newDateComponents.month = 2
        newDateComponents.day = 5
        
        let calendar = Calendar.current
        let currentDate = Date()
        
        let calculatedDate = calendar.date(byAdding: newDateComponents, to: currentDate)
        
        print(calculatedDate!)
    }
    
    func exercise3() {
        let currentDate = Date()
        print(currentDate)
        
        let monthsToAdd = 2
        let daysToAdd = 5
        
        let calendar = Calendar.current
        
        var calculatedDate = calendar.date(byAdding: Calendar.Component.month, value: monthsToAdd, to: currentDate)
        calculatedDate = calendar.date(byAdding: Calendar.Component.day, value: daysToAdd, to: calculatedDate!)
        
        print(calculatedDate!)
    }
    
    func exercise2() {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let dateComponents = calendar.dateComponents([Calendar.Component.era, Calendar.Component.year,
                                                      Calendar.Component.month, Calendar.Component.day,
                                                      Calendar.Component.hour, Calendar.Component.minute,
                                                      Calendar.Component.second], from: currentDate)
        print("era:\(dateComponents.era), year:\(dateComponents.year), month:\(dateComponents.month), day:\(dateComponents.day), hour:\(dateComponents.hour), minute:\(dateComponents.minute), second:\(dateComponents.second)")
        
        
        var componts = DateComponents()
        componts.year = 1985
        componts.month = 02
        componts.day = 05
        componts.hour = 07
        componts.minute = 08
        componts.second = 44
        componts.timeZone = TimeZone(abbreviation: "CET")
        
        let dateFormComponents = calendar.date(from: componts)
        print(dateFormComponents!)
        
    }
    
    func exercise1() {
        let currentDate = Date()
        
        print(currentDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        dateFormatter.dateStyle = DateFormatter.Style.none
        var stringDate = dateFormatter.string(from: currentDate)
        print(stringDate)
        
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        stringDate = dateFormatter.string(from: currentDate)
        print(stringDate)
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        stringDate = dateFormatter.string(from: currentDate)
        print(stringDate)
        
        dateFormatter.dateStyle = DateFormatter.Style.long
        stringDate = dateFormatter.string(from: currentDate)
        print(stringDate)
        
        dateFormatter.dateStyle = DateFormatter.Style.full
        stringDate = dateFormatter.string(from: currentDate)
        print(stringDate)
        
        dateFormatter.dateFormat = "EEEE, MMMM, dd, yyyy"
        stringDate = dateFormatter.string(from: currentDate)
        print(stringDate)
        
        let dateString = "2016-12-02 18:15:59"
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print(dateFormatter.date(from: dateString)!)
    }
    
    class func exerciseClassFunc() {
        print("Class func is me.");
    }
}

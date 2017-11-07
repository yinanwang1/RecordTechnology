//
//  InterfaceController.h
//  RecordTechnology WatchKit Extension
//
//  Created by ArthurWang on 15/4/1.
//  Copyright (c) 2015年 MonkeyKing. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceSlider *guessSlider;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *guessLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *resultLabel;

@end

//
//  InterfaceController.m
//  RecordTechnology WatchKit Extension
//
//  Created by ArthurWang on 15/4/1.
//  Copyright (c) 2015年 MonkeyKing. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@property (nonatomic, assign) NSInteger guessNumber;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    
    self.guessNumber = 3;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    NSDictionary *data = [[NSDictionary alloc] init];
    [WKInterfaceController openParentApplication:data reply:^(NSDictionary *replyInfo, NSError *error)
     {
//         NSLog(@"replyInfo is %@.", replyInfo);

     }];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)updateGuess:(float)value {
    
    self.guessNumber = (value * 5);
    
    [self.guessLabel setText:[NSString stringWithFormat:@"Your guess: %ld.", self.guessNumber]];
    
}
- (IBAction)startGuess {
//    NSInteger randomNumber = arc4random_uniform(6);
//    
//    if ( self.guessNumber == randomNumber )
//    {
//        [self.resultLabel setText:[NSString stringWithFormat:@"Correct. You win!"]];
//    }
//    else
//    {
//        [self.resultLabel setText:[NSString stringWithFormat:@"Wrong. The number is %lu.", randomNumber]];
//    }
    
    NSDictionary *data = [[NSDictionary alloc] init];
    [WKInterfaceController openParentApplication:data reply:^(NSDictionary *replyInfo, NSError *error)
     {
//         NSLog(@" %s replyInfo is %@.", __func__, replyInfo);
         
     }];
    
    
    
}

@end




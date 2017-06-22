//
//  HXQErrorRemindView.h
//  qiji
//
//  Created by BeyondChao on 2017/6/2.
//  Copyright © 2017年 huanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXQErrorRemindView : UIView

+ (instancetype)showRemindInView:(UIView *)view
                          status:(NSString *)text
                      afterDelay:(NSTimeInterval)delay;


@end

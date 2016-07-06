//
//  HXSQRCodes.h
//  store
//
//  Created by ArthurWang on 15/10/19.
//  Copyright © 2015年 huanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXSQRCodes : NSObject

/**
 *  创建二维码
 *
 *  @param qrString 被转为二维码的字符串
 *  @param size     二维码的图片大小
 *  @param color    二维码显示的颜色，默认为黑色
 *  @param iconImage 显示中间的图标
 *
 *  @return 图片
 */
+ (UIImage *)createImageWithQRString:(NSString *)qrString
                                size:(CGFloat)size
                               color:(UIColor *)color
                                icon:(UIImage *)iconImage;

@end

//
//  "Color+Image.h"
//  store
//
//  Created by Arthur Wang on 14-10-13.
//  Copyright (c) 2014年 Arthur Wang All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (util)
+(UIColor *)colorWithR:(uint8_t)R G:(uint8_t)G B:(uint8_t)B A:(CGFloat)A;
+(UIColor *)colorWithHexString: (NSString *) hexString;
@end


@interface UIImage (util)
+(UIImage*) resizableImageWithColor:(UIColor*)color size:(CGSize)size caps:(UIEdgeInsets)caps;
+(UIImage*) imageWithColor:(UIColor*)color;
+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size;

+ (id) imageFromImage:(UIImage*)image leftString:(NSString*)string textColor:(UIColor*)textColor font:(UIFont *)font;

@end

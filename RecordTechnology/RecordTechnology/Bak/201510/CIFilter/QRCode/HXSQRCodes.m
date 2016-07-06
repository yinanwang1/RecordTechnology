//
//  HXSQRCodes.m
//  store
//
//  Created by ArthurWang on 15/10/19.
//  Copyright © 2015年 huanxiao. All rights reserved.
//

#import "HXSQRCodes.h"

void ProviderReleaseData (void *info, const void *data, size_t size) {
    free((void *)data);
}

@implementation HXSQRCodes

#pragma mark - Public Methods

+ (UIImage *)createImageWithQRString:(NSString *)qrString
                                size:(CGFloat)size
                               color:(UIColor *)color
                                icon:(UIImage *)iconImage
{
    UIImage *resultImage = nil;
    
    if (nil == qrString
        || (0 >= [qrString length])) {
        return nil;
    }
    
    CIImage *qrCIImage = [self createQRForString:qrString];
    
    if (0 >= size) {
        size = 250.0f;
    }
    
    resultImage = [self createNonInterprolatedUIImageFormCIImage:qrCIImage
                                                        withSize:size];
    
    
    if (nil != iconImage) {
        resultImage = [self imageAddIconImage:iconImage
                                    inQRImage:resultImage];
    }
    
    if (nil == color) {
        return resultImage;
    }
    
    resultImage = [self imageBlackToTransparent:resultImage
                                                withRed:color.red
                                               andGreen:color.green
                                                andBlue:color.blue];
    
    return resultImage;
}


#pragma mark - Private Methods

+ (CIImage *)createQRForString:(NSString *)qrString
{
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    return qrFilter.outputImage;
}

+ (UIImage *)createNonInterprolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent format:kCIFormatARGB8 colorSpace:nil];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    CGImageRef scaleImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaleImage];
}

+ (UIImage *)imageAddIconImage:(UIImage *)iconImage
                     inQRImage:(UIImage *)qrImage
{
    UIGraphicsBeginImageContext(qrImage.size);
    
    CGFloat widthOfQRImage = qrImage.size.width;
    CGFloat heightOfQRImage = qrImage.size.height;
    CGFloat widthOfIconImage = iconImage.size.width;
    CGFloat heightOfIconImage = iconImage.size.height;
    
    [qrImage drawInRect:CGRectMake(0, 0, widthOfQRImage, heightOfQRImage)];
    [iconImage drawInRect:CGRectMake((widthOfQRImage - widthOfIconImage) / 2.0,
                                     (heightOfQRImage - heightOfIconImage) / 2.0,
                                     widthOfIconImage,
                                     heightOfIconImage)];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)imageBlackToTransparent:(UIImage *)image
                             withRed:(CGFloat)red
                            andGreen:(CGFloat)green
                             andBlue:(CGFloat)blue {
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow *imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[3] = red;
            ptr[2] = green;
            ptr[1] = blue;
        } else {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
    
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    
    return resultUIImage;
}

@end

//
//  CIFilterViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/10/17.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "CIFilterViewController.h"

void ProviderReleaseData (void *info, const void *data, size_t size) {
    free((void *)data);
}

@interface CIFilterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *filterTextField;
@property (weak, nonatomic) IBOutlet UIButton *filterButton;
@property (weak, nonatomic) IBOutlet UIImageView *filterImageView;


@end

@implementation CIFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickFliterBtn:(id)sender
{
    [self.filterTextField resignFirstResponder];
    
    if (nil == self.filterTextField.text
        || (0 >= [self.filterTextField.text length])) {
        return;
    }
    
    CIImage *qrCIImage = [self createQRForString:self.filterTextField.text];
    UIImage *qrImage = [self createNonInterprolatedUIImageFormCIImage:qrCIImage
                                                             withSize:self.filterImageView.frame.size.width];
    UIImage *colorImage = [self imageBlackToTransparent:qrImage
                                                withRed:255
                                               andGreen:0
                                                andBlue:0];
    
    self.filterImageView.image = colorImage;
    
}


#pragma mark - 二维码

- (CIImage *)createQRForString:(NSString *)qrString
{
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    return qrFilter.outputImage;
}

- (UIImage *)createNonInterprolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
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

- (UIImage *)imageBlackToTransparent:(UIImage *)image
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

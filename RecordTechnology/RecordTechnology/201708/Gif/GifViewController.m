//
//  GifViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/8/22.
//  Copyright © 2017年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "GifViewController.h"

#import "FLAnimatedImage.h"

@interface GifViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    NSInteger pages = 45;
    NSMutableArray *imagesMArr = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i = 1; i <= pages; i++ ) {
        NSString *imageName = [NSString stringWithFormat:@"loading_%d", i];
        UIImage *image = [UIImage imageNamed:imageName];

        [imagesMArr addObject:image];
    }

    [self.gifImageView setAnimationImages:imagesMArr];

    [self.gifImageView startAnimating];

//    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"bear" ofType:@"gif"];
//    NSData *gif = [NSData dataWithContentsOfFile:gifPath];
//
//    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gif];
//
//    [self.gifImageView setAnimatedImage:image];
}


@end

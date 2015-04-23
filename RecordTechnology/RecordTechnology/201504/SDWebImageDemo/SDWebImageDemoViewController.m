//
//  SDWebImageDemoViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/21.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "SDWebImageDemoViewController.h"

#import "UIImageView+WebCache.h"


@interface SDWebImageDemoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property (weak, nonatomic) IBOutlet UIImageView *imageView6;
@property (weak, nonatomic) IBOutlet UIImageView *imageView7;
@property (weak, nonatomic) IBOutlet UIImageView *imageView8;
@property (weak, nonatomic) IBOutlet UIImageView *imageView9;
@property (weak, nonatomic) IBOutlet UIImageView *imageView10;
@property (weak, nonatomic) IBOutlet UIImageView *imageView11;
@property (weak, nonatomic) IBOutlet UIImageView *imageView12;
@property (weak, nonatomic) IBOutlet UIImageView *imageView13;
@property (weak, nonatomic) IBOutlet UIImageView *imageView14;





@end

@implementation SDWebImageDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSLog(@"NSHomeDirectory is %@.", NSHomeDirectory());
    
    for (int i=1; i < 13; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"imageView%d", i];
        
        [self performSelector:@selector(downloadImageWithName:) withObject:imageName afterDelay:i];
        
        
    }
    
    
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


#pragma mark - download images

- (void)downloadImageWithName:(NSString *)imageName
{
    NSRange range = [imageName rangeOfString:@"imageView"];
    NSString *numStr = [imageName substringFromIndex:range.length];
    
    NSInteger name = [numStr integerValue];
    
    NSURL *url = [NSURL URLWithString:@"http://img.ivsky.com/img/bizhi/slides/201504/17/grainrain-001.jpg"];
    
    
    switch (name) {
        case 1:
        {
            
            NSData *data1 = [NSData dataWithContentsOfURL:url];
            
            UIImage *image = [UIImage imageWithData:data1];
            
            [self.imageView1 setImage:image];
            
            
            break;
        }
            
        case 2:
        {
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            
            [manager downloadImageWithURL:url
                                                         options:SDWebImageProgressiveDownload
                                                        progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                            NSLog(@"What?");
                                                            
                                                            NSLog(@"receivedSize is %ld, expectedSize is %ld.", (long)receivedSize ,(long)expectedSize);
                                                            
                                                            
                                                        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                            [self.imageView2 setImage:image];
                                                            
                                                            NSLog(@"imageURL is %@.", imageURL);
                                                        }];
            
            
            break;
        }
            
        case 3:
            [self.imageView3 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Suoluo"]];
            break;
            
        case 4:
            [self.imageView4 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Suoluo"]];
            break;
            
        case 5:
            [self.imageView5 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Suoluo"]];
            break;
            
        case 6:
            [self.imageView6 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Suoluo"]];
            break;
            
        case 7:
            [self.imageView7 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Suoluo"]];
            break;
            
        case 8:
            [self.imageView8 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Suoluo"]];
            break;
            
        case 9:
            [self.imageView9 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Suoluo"]];
            break;
            
        case 10:
            [self.imageView10 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Suoluo"]];
            break;
            
        case 11:
            [self.imageView11 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Suoluo"]];
            break;
            
        case 12:
            [self.imageView12 sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Suoluo"]];
            break;
            
        default:
            break;
    }
}


@end

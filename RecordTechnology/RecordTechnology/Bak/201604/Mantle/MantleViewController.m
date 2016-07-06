//
//  MantleViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 16/4/8.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "MantleViewController.h"

static NSString *URLStr = @"http://mobileapi.59temai.com/shop/categories?app_version=3.2.07&device_id=oa8b26e91a3f557cab9e939f4394f47df126b667d&device_type=0&protocol_version=2.0.0&shop_id=1007&shop_type=0&sign=926d8aaece220f95c47053cd26509bcb&site_id=1&time=1460105531&token=fd1e4e1a4bdc4c118553cc4f1c8b7500";

@interface MantleViewController ()

@end

@implementation MantleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URLStr]];
    
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:nil];
    
    NSLog(@"jsonDic is %@.", jsonDic);
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
- (IBAction)convertToObject:(id)sender
{
    
}

- (IBAction)convertToJson:(id)sender
{
    
}


@end

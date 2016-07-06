//
//  AFNetworkingViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/3/25.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "AFNetworkingViewController.h"


#import "UIImageView+AFNetworking.h"

@interface AFNetworkingViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showImageView];
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

- (IBAction)testNetworking:(id)sender {
    
    NSString *str = [NSString stringWithFormat:@"https://alpha-api.app.net/stream/0/posts/stream/global"];
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
        id dict = [NSJSONSerialization JSONObjectWithData:data
                                                  options:0
                                                    error:nil];
        NSLog(@"dict is %@.", dict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error is %@.", error);
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperation:operation];
    
}

- (IBAction)fetchImage:(id)sender
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/9c16fdfaaf51f3def7b9c06496eef01f3a2979a2.jpg"]];
}


- (void)showImageView
{
    [self.imageView setImageWithURL:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/pic/item/9c16fdfaaf51f3def7b9c06496eef01f3a2979a2.jpg"] placeholderImage:[UIImage imageNamed:@"haizeiwang"]];
}





@end

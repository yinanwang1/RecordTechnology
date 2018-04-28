//
//  DisplayLinkViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2018/4/27.
//  Copyright © 2018年 Monkey King. All rights reserved.
//

#import "DisplayLinkViewController.h"

#import <QuartzCore/CADisplayLink.h>

@interface DisplayLinkViewController ()

@property (weak, nonatomic) IBOutlet UIButton *muButton;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation DisplayLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.muButton.backgroundColor = [UIColor cyanColor];

    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animation)];

    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animation
{
    NSLog(@"wyn 111");
    CGRect frame = self.muButton.frame;
    frame.origin.y -= 1;
    frame.size.width += 1;

    self.muButton.frame = frame;
}

- (IBAction)onClickMyBtn:(id)sender
{
    self.displayLink.paused = !(self.displayLink.paused);
}


@end

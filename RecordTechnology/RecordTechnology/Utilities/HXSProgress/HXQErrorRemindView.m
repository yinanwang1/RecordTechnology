//
//  HXQErrorRemindView.m
//  qiji
//
//  Created by BeyondChao on 2017/6/2.
//  Copyright © 2017年 huanxiao. All rights reserved.
//

#import "HXQErrorRemindView.h"

@interface HXQErrorRemindView ()

@property (nonatomic, strong) UILabel *errorTitleLabel;
@property (nonatomic, strong) UILabel *errorContentLabel;
@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, weak) NSTimer *hideDelayTimer;

@end

@implementation HXQErrorRemindView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialSubviews];

    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self initialSubviews];
    }
    return self;
}

- (void)initialSubviews {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.errorTitleLabel];
    [self addSubview:self.errorContentLabel];
    [self addSubview:self.closeButton];
    
}

#pragma mark - Layout

- (void)updateConstraints {
    
    [self.errorTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.errorTitleLabel.superview);
        make.left.equalTo(self.errorTitleLabel.superview).offset(30);
    }];
    [self.errorContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.errorContentLabel.superview);
        make.left.equalTo(self.errorTitleLabel.mas_right).offset(10);
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.closeButton.superview);
        make.right.equalTo(self.closeButton.superview).offset(-30);
    }];

    [super updateConstraints];
}

#pragma mark - Action 

- (void)closeRemind {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.alpha = 0.0f;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                
                         [self.hideDelayTimer invalidate];
                         self.hideDelayTimer = nil;
                     }];
    
}

#pragma mark - Public

+ (instancetype)showRemindInView:(UIView *)view status:(NSString *)text afterDelay:(NSTimeInterval)delay {
    HXQErrorRemindView *remind = [[self alloc] initWithFrame:CGRectZero];
    remind.alpha = 0.0f;
    remind.errorContentLabel.text = text;
    [view addSubview:remind];
    [view bringSubviewToFront:remind];
    
    [remind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(remind.superview);
        make.height.equalTo(@44);
    }];
    
    [remind showAfterDelay:delay];
    
    return remind;
}

#pragma mark - Private

- (void)showAfterDelay:(NSTimeInterval)delay {
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.alpha = 1.0f;
                     }];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:delay target:self selector:@selector(closeRemind) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.hideDelayTimer = timer;

}

#pragma mark - Getter

- (UILabel *)errorTitleLabel {
    if (!_errorTitleLabel) {
        _errorTitleLabel = [[UILabel alloc] init];
        _errorTitleLabel.textColor = [UIColor colorWithRGBHex:0xEA6E3F];
        _errorTitleLabel.font = [UIFont systemFontOfSize:14];
        _errorTitleLabel.text = @"错误";
    }
    return _errorTitleLabel;
}

- (UILabel *)errorContentLabel {
    if (!_errorContentLabel) {
        _errorContentLabel = [[UILabel alloc] init];
        _errorContentLabel.font = [UIFont systemFontOfSize:14];
        _errorContentLabel.textColor = [UIColor colorWithRGBHex:0x646464];
    }
    return _errorContentLabel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"login_close_icon"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeRemind) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

@end

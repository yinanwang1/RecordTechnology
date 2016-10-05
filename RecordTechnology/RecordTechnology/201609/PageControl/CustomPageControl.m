//
//  CustomPageControl.m
//  RecordTechnology
//
//  Created by ArthurWang on 2016/9/24.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "CustomPageControl.h"

@interface CustomPageControl ()

@property (nonatomic, assign) NSInteger strokeWidth;
@property (nonatomic, assign) NSInteger diameter;
@property (nonatomic, assign) NSInteger gapWidth;

@end


@implementation CustomPageControl

#pragma mark - Lifecycle Methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (self.hidesForSinglePage
        && (1 == self.numberOfPages))
    {
        return;
    }
    
    NSInteger gap = self.gapWidth;
    float diameter = self.diameter - 2 * self.strokeWidth;
    
    if (self.thumbImage && self.selectedThumbImage)
    {
        diameter = self.thumbImage.size.width;
    }
    
    NSInteger total_width = self.numberOfPages * diameter + (self.numberOfPages-1) * gap;
    
    if (total_width > self.frame.size.width)
    {
        while (total_width > self.frame.size.width)
        {
            diameter -= 2;
            gap = diameter + 2;
            while (total_width > self.frame.size.width)
            {
                gap -= 1;
                total_width = self.numberOfPages*diameter + (self.numberOfPages-1)*gap;
                
                if (gap == 2)
                {
                    total_width = self.numberOfPages*diameter + (self.numberOfPages-1)*gap;
                    
                    break;
                }
            }
            
            if (diameter==2)
            {
                total_width = self.numberOfPages*diameter + (self.numberOfPages-1) * gap;
                
                break;
            }
        }
    }
    

    for (int i = 0; i < self.numberOfPages; i++)
    {
        int x = (self.frame.size.width - total_width) / 2 + i * (diameter + gap);
        
        UIImage* thumbImage = self.thumbImage;
        UIImage* selectedThumbImage = self.selectedThumbImage;
        
        if (thumbImage && selectedThumbImage)
        {
            if (i == self.currentPage)
            {
                [selectedThumbImage drawInRect:CGRectMake(x,(self.frame.size.height-selectedThumbImage.size.height)/2,selectedThumbImage.size.width,selectedThumbImage.size.height)];
            }
            else
            {
                [thumbImage drawInRect:CGRectMake(x,(self.frame.size.height-thumbImage.size.height)/2,thumbImage.size.width,thumbImage.size.height)];
            }
        }
    }
}



#pragma mark - Intial Methods

- (void)setup
{
    [self setBackgroundColor:[UIColor clearColor]];
    
    self.strokeWidth = 2;
    self.gapWidth = 10;
    self.diameter = 12;
    self.thumbImage = [UIImage imageNamed:@"ic_circel_solid_white"];;
    self.selectedThumbImage = [UIImage imageNamed:@"ic_circle_hollow_white"];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)onTapped:(UITapGestureRecognizer*)gesture
{
    CGPoint touchPoint = [gesture locationInView:[gesture view]];
    
    if (touchPoint.x < self.frame.size.width/2)
    {
        // move left
        if (self.currentPage>0)
        {
            if (touchPoint.x <= 22)
            {
                self.currentPage = 0;
            }
            else
            {
                self.currentPage -= 1;
            }
        }
        
    }
    else
    {
        // move right
        if (self.currentPage<self.numberOfPages-1)
        {
            if (touchPoint.x >= (CGRectGetWidth(self.bounds) - 22))
            {
                self.currentPage = self.numberOfPages-1;
            }
            else
            {
                self.currentPage += 1;
            }
        }
    }
    [self setNeedsDisplay];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}


#pragma mark - Setter Getter Methods

- (void)setCurrentPage:(NSInteger)page
{
    _currentPage = page;
    
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numOfPages
{
    _numberOfPages = numOfPages;
    
    [self setNeedsDisplay];
}


@end

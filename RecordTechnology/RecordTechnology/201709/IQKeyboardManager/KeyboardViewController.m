//
//  KeyboardViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/9/11.
//  Copyright © 2017年 MonkeyKing. All rights reserved.
//

#import "KeyboardViewController.h"

static CGFloat   const kSectionHeaderHeight = 30.0f;
#define SCREEN_WIDTH                ([UIScreen mainScreen].bounds.size.width)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface KeyboardViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation KeyboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kSectionHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSectionHeaderHeight)];
    view.backgroundColor = [UIColor whiteColor];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15, kSectionHeaderHeight)];
    label.textColor = UIColorFromRGB(0x333333);
    label.font = [UIFont systemFontOfSize:15.0f];
    label.backgroundColor = [UIColor whiteColor];

    label.text = @"1.请选择故障原因：（必选）";

    [view addSubview:label];

    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2)
    {
        return 40;
    }
    else
    {
        return 160;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        if (indexPath.row %2)
        {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(5,5,cell.contentView.frame.size.width-10,30)];
            textField.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth;
            [textField setPlaceholder:identifier];
            [textField setBorderStyle:UITextBorderStyleRoundedRect];
            [cell.contentView addSubview:textField];
        }
        else
        {
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectInset(cell.contentView.bounds, 5, 5)];
            textView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            textView.text = @"Sample Text";
            [cell.contentView addSubview:textView];
        }
    }

    return cell;
}

@end

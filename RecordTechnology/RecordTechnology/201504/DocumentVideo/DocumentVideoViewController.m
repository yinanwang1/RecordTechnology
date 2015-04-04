//
//  DocumentVideoViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/4/4.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "DocumentVideoViewController.h"

#import "DocumentVideoModel.h"
#import <QuickLook/QuickLook.h>
#import <MediaPlayer/MediaPlayer.h>


@interface DocumentVideoViewController () <UITableViewDelegate, UITableViewDataSource, QLPreviewControllerDelegate, QLPreviewControllerDataSource>

@property (nonatomic, strong) DocumentVideoModel *videoModel;


@end

@implementation DocumentVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _videoModel = [[DocumentVideoModel alloc] init];
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


#pragma mark - UITableViewDelegate, UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.videoModel.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if ( nil == cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.videoModel.dataSource objectAtIndex:indexPath.row];    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( 5 == indexPath.row )
    {
        NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"R410_hd_advanced_swift_debugging_in_lldb" ofType:@"mov"];
        
        NSURL *url = [[NSURL alloc] initFileURLWithPath:pathStr];
        
        NSLog(@"url is %@.", url);
        
        
        MPMoviePlayerViewController *VC = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
        
        MPMoviePlayerController *player = VC.moviePlayer;
        
        
        player.controlStyle = MPMovieControlStyleFullscreen;
        
        [player prepareToPlay];
        
        
        [self presentMoviePlayerViewControllerAnimated:VC];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(movieFinishedCallBack:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:player];
        
        
        
        return;
    }
    else
    {
        QLPreviewController *qlPreview = [[QLPreviewController alloc] init];
        
        qlPreview.delegate = self;
        qlPreview.dataSource = self;
        
        
        [self presentViewController:qlPreview animated:YES completion:^{
            NSLog(@"Finished.");
        }];
    }
 
}

- (void)movieFinishedCallBack:(NSNotification *)notification
{
    MPMoviePlayerController *player = (MPMoviePlayerController *)[notification object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:player];
    
}


#pragma mark - QLPreviewControllerDelegate, QLPreviewControllerDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 5;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"商品房验收标准和注意事项" ofType:@"docx"];
    
    NSURL *url = [NSURL fileURLWithPath:pathStr];
    
    
    
    return url;
}


@end

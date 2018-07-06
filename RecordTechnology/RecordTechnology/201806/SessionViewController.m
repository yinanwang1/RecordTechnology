//
//  SessionViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2018/6/27.
//  Copyright © 2018年 Monkey King. All rights reserved.
//

#import "SessionViewController.h"

#import "TestTableViewCell.h"

@interface SessionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *test;

@property (weak, nonatomic) IBOutlet UITableView *testTableView;

@property (nonatomic, strong) NSMutableArray *mArr;

@end

@implementation SessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"test is %@.", _test?:@"test");

    self.test = @"Hello";

    NSLog(@"test is %@.", _test?:@"wahaha");

    self.mArr = [[NSMutableArray alloc] initWithObjects:@"123123123", @"阿辉开始疯狂has发", @"阿双方均爱上了党费交", nil];

    [self.testTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TestTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TestTableViewCell class])];

    [self.testTableView reloadData];


    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addTestString:)];



    // Do any additional setup after loading the view.

//    NSDictionary *dic = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:NSLocalizedStringFromTable(@"Request failed: %@ (%ld)", @"AFNetworking", nil), [NSHTTPURLResponse localizedStringForStatusCode:1], (long)1]};
//
//    NSLog(@"dic is %@.", dic);

//    dispatch_queue_t queue = dispatch_queue_create("thead", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        NSLog(@"test1");
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"test2");
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"test3");
//    });
//
//    dispatch_barrier_sync(queue, ^{
//        for (int i = 0; i <= 5000000; i++) {
//            if (5000 == i) {
//                NSLog(@"point1");
//            } else if (6000 == i) {
//                NSLog(@"point2");
//            } else if (7000 == i) {
//                NSLog(@"point3");
//            }
//        }
//
//        NSLog(@"barrier");
//    });
//
//    NSLog(@"aaa");
//    dispatch_async(queue, ^{
//        NSLog(@"test4");
//    });
//    NSLog(@"bbb");
//    dispatch_async(queue, ^{
//        NSLog(@"test5");
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"test6");
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.


}

- (void)addTestString:(id)sender
{
    NSLog(@"sender is %@.", sender);

    [self.mArr addObject:@"您好啊还是砥砺奋进阿里山发放拉斯加附件是来得及发四六级的法拉世纪东方拉数据的飞机爱上了的积分爱上了的积分拉数据法拉盛记得发按时来得及发啦世纪东方"];

    [self.testTableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestTableViewCell class]) forIndexPath:indexPath];

    for (UIView *view in cell.testStackView.subviews) {
        [view removeFromSuperview];
    }

    for (NSString *string in self.mArr) {
        UILabel *label = [[UILabel alloc] init];
        label.text = string;
        label.numberOfLines = 0;

        [cell.testStackView addArrangedSubview:label];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"jumpToTestVC" sender:nil];
}



@end

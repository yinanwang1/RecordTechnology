//
//  CollectionViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 2017/12/20.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

#import "CollectionViewController.h"

#import "CollectionObject.h"

typedef void (^MyBlock) (void);

@interface CollectionViewController ()

@property (nonatomic, strong) NSMutableArray *Marray;

@end

@implementation CollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.Marray = [[NSMutableArray alloc] initWithCapacity:5];

    CollectionObject *object1 = [[CollectionObject alloc] init];
    CollectionObject *object2 = [[CollectionObject alloc] init];
    CollectionObject *object3 = [[CollectionObject alloc] init];
    CollectionObject *object4 = [[CollectionObject alloc] init];
    CollectionObject *object5 = [[CollectionObject alloc] init];
    CollectionObject *object6 = [[CollectionObject alloc] init];

    [self.Marray addObject:object1];
    [self.Marray addObject:object2];
    [self.Marray addObject:object3];
    [self.Marray addObject:object4];
    [self.Marray addObject:object5];
    [self.Marray addObject:object6];

}


- (IBAction)onClickMeBtn:(id)sender
{
    CollectionObject *object = [self.Marray objectAtIndex:1];

    object.name = @"123";


    __block NSInteger number = 0;
    MyBlock myBlock = ^(){
        number++;

        NSLog(@"number is %zd.", number);
    };

    NSLog(@"number++ is %zd.", number);

    myBlock();

    NSLog(@"number2 is %zd.", number);


}

- (IBAction)onClickShowBtn:(id)sender
{
    CollectionObject *object = [self.Marray objectAtIndex:1];

    NSLog(@"object.name is %@>",object.name);
}

@end

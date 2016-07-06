//
//  FMDBViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/10/14.
//  Copyright © 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "FMDBViewController.h"

#import "FMDB.h"

@interface FMDBViewController ()

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths firstObject];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if (![db open]) {
        NSLog(@"啥， 打不开db。。。");
        
        return;
    }
    

//    [db executeUpdate:@"CREATE TABLE PersonList (Name text, Age integer, Sex integer, Phone text, Address text, Photo blob)"];
    
    [db executeUpdate:@"INSERT INTO PersonList (Name, Age, Sex, Phone, Address, photo) VALUES (?,?,?,?,?,?)",
     @"Jone", [NSNumber numberWithInt:20], [NSNumber numberWithInt:0], @"13505816191", @"Taiwan, R.O,C", nil];
    
    FMResultSet *rs = [db executeQuery:@"SELECT Name, Age FROM PersonList"];
    
    while ([rs next]) {
        NSString *name = [rs stringForColumn:@"Name"];
        
        int age = [rs intForColumn:@"Age"];
        
        NSLog(@"Name is %@, Age is %ld", name, (long)age);
    }
    
    [rs close];
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

@end

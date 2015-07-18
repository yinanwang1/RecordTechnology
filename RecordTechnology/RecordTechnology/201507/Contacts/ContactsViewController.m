//
//  ContactsViewController.m
//  RecordTechnology
//
//  Created by ArthurWang on 15/7/18.
//  Copyright (c) 2015年 InSigma HengTian Softwar Ltd. All rights reserved.
//

#import "ContactsViewController.h"

#import <AddressBook/AddressBook.h>

@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self readAllPeoples];
    
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

- (void)readAllPeoples
{
    [self checkAuthorizationState];
    
    ABAddressBookRef tmpAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool granted, CFErrorRef error) {
        dispatch_semaphore_signal(sema);
    });
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    if (nil == tmpAddressBook) {
        NSLog(@"Can't fetch the address book.");
    }
    
    NSArray *tmpPeoples = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(tmpAddressBook);
    
    for (id tmpPerson in tmpPeoples) {
        NSString *tmpFirstName = (__bridge NSString *)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
        
        NSLog(@"first name is %@.", tmpFirstName);
    }
    
    
    
    

}


- (void)checkAuthorizationState
{
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusDenied:
            NSLog(@"kABAuthorizationStatusDenied");
            break;
            
        case kABAuthorizationStatusAuthorized:
            NSLog(@"kABAuthorizationStatusAuthorized");
            break;
        
        case kABAuthorizationStatusRestricted:
            NSLog(@"kABAuthorizationStatusRestricted");
            break;
            
        case kABAuthorizationStatusNotDetermined:
            NSLog(@"kABAuthorizationStatusNotDetermined");
            break;
            
        default:
            break;
    }
}





@end

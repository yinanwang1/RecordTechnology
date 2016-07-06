//
//  WebService.h
//  Moovers
//
//  Created by Sai Chow on 2/17/14.
//  Copyright (c) 2014 Moovers. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AFHTTPRequestOperationManager;

@interface WebService : NSObject

+ (AFHTTPRequestOperationManager*)sharedClient:(NSString *) baseURL;

+ (void)postRequest:(NSString*)path
         parameters:(NSDictionary*)parameters
           encToken:(NSString*)encToken
            isLogin:(BOOL)isLogin
            success:(void (^)(id JSON))success
            failure:(void (^)(NSError* error, id JSON))failure;

+ (void)getRequest:(NSString*)path
        parameters:(NSDictionary*)parameters
          encToken:(NSString*)encToken
           isLogin:(BOOL)isLogin
           success:(void (^)(id JSON))success
           failure:(void (^)(NSError* error, id JSON))failure;

+ (void)uploadRequest:(NSString*)path
           parameters:(NSDictionary*)parameters
             encToken:(NSString*)encToken
		formDataArray:(NSArray *)formDataArray
              isLogin:(BOOL)isLogin
              success:(void (^)(id JSON))success
              failure:(void (^)(NSError* error, id JSON))failure;

@end

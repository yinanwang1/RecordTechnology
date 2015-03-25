//
//  WebService.m
//  Moovers
//
//  Created by Sai Chow on 2/17/14.
//  Copyright (c) 2014 Moovers. All rights reserved.
//

#import "WebService.h"
#import "AFNetworking.h"

#import "NSDictionary+Utils.h"
#import "HMACStringGenerator.h"


#define STATUS_SUCCESS  @"success"
#define STATUS_ERROR    @"error"
#define STATUS_FAIL     @"fail"
#define NETWORK_ERROR   @"WS_Network_Error"

#define NETWORK_ACTIVITY_NOTIFICATION_NAME @"WS_Network_Activity"

static BOOL activityOn = NO;

@implementation WebService

+ (AFHTTPRequestOperationManager*)sharedClient:(NSString *) baseURL {
    static AFHTTPRequestOperationManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    });
    
    return _sharedClient;
}


#pragma mark -
#pragma mark Core

+ (void)handleSuccess:(BOOL)isPost
              isLogin:(BOOL)isLogin
                 path:(NSString*)path
           parameters:(NSDictionary*)parameters
            operation:(AFHTTPRequestOperation*)op
                 json:(id)json
              success:(void (^)(id JSON))success
              failure:(void (^)(NSError* error, id JSON))failure
{
    DLog(@"handleSuccess");
    
    success(json);
    
}

+ (void)handleFailure:(BOOL)isPost
              isLogin:(BOOL)isLogin
                 path:(NSString*)path
           parameters:(NSDictionary*)parameters
            operation:(AFHTTPRequestOperation*)op
                error:(NSError*)error
              success:(void (^)(id JSON))success
              failure:(void (^)(NSError* error, id JSON))failure {
//    DLog(@"Failure %@", error.debugDescription);
    [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_ERROR object:self userInfo:@{@"error": error}];
    failure(error, nil);
}

+ (void)postRequest:(NSString*)path
         parameters:(NSDictionary*)parameters
           encToken:(NSString*)encToken
            isLogin:(BOOL)isLogin
            success:(void (^)(id JSON))success
            failure:(void (^)(NSError* error, id JSON))failure

{
    DLog(@"Request Start %@", [NSDate date]);
    DLog(@"Request %@", path);
    DLog(@"Params %@", parameters);
    
    [WebService activity:YES];
    [WebService postPath:path parameters:parameters encToken:encToken isLogin:isLogin
                 success:^(AFHTTPRequestOperation* op, id json) {
                     
                     
                     NSDictionary *responseDic = [op.response allHeaderFields];
                     DLog(@"responseDic is %@.", responseDic);
                     
                     NSString *session_token = [responseDic objectForKey:@"session_token"];
                     if (nil != session_token) {
                         //[UserSession sharedInstance].userAccessToken = session_token;
                     }
                     
                     
                     DLog(@"Request End Success %@", [NSDate date]);
                     NSDictionary *responseDict = (NSDictionary *)[json dictionaryByReplacingNullsWithStrings];
                     NSArray *test = [responseDict objectForKey:@"ResponseList"];
                     
                     NSDictionary *jsonDict = nil;
                     if ( (nil != test)
                         && [test isKindOfClass:[NSArray class]]
                         && (0 < [test count]) )
                     {
                         NSDictionary *anotherTest = [test objectAtIndex:0];
                         jsonDict = (NSDictionary *)[anotherTest dictionaryByReplacingNullsWithStrings];
                     }
                     else {
                         jsonDict = json;
                     }
                     
                     [WebService handleSuccess:YES
                                       isLogin:isLogin
                                          path:path
                                    parameters:parameters
                                     operation:op
                                          json:jsonDict
                                       success:success
                                       failure:failure];
                     
                     [WebService activity:NO];
                 }
     
                 failure:^(AFHTTPRequestOperation* op, NSError* error)
     {
         DLog(@"Request End Faile %@", [NSDate date]);
         [WebService handleFailure:YES
                           isLogin:isLogin
                              path:path
                        parameters:parameters
                         operation:op
                             error:error
                           success:success
                           failure:failure];
         
         [WebService activity:NO];
     }];
}

+ (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
        encToken:(NSString*)encToken
         isLogin:(BOOL)isLogin
         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    // method
    NSString *method = @"POST";
    
    
    // request body
    NSData *jsonData = parameters == nil ? nil : [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *requestBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [WebService sharedClient:nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // Authorization value
    [manager.requestSerializer setValue:encToken forHTTPHeaderField:@"Authentication-Token"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];

    
    DLog(@"[request allHTTPHeaderFields] is %@.", manager.requestSerializer);
    
    [manager POST:path parameters:parameters success:success failure:failure];
    
}

+ (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
       encToken:(NSString*)encToken
        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    
    NSData *jsonData = parameters == nil ? nil : [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString *requestBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *currentDateString = [HMACStringGenerator currentDateString];
    
    AFHTTPRequestOperationManager *manager = [WebService sharedClient:nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:currentDateString forHTTPHeaderField:@"RequestDateTimeStamp"];
    [manager.requestSerializer setValue:[requestBody MD5] forHTTPHeaderField:@"ContentMd5"];
    
    [manager.requestSerializer setValue:encToken forHTTPHeaderField:@"Authentication-Token"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
    DLog(@"get [request allHTTPHeaderFields] is %@.", manager.requestSerializer);
    
    [manager GET:path parameters:parameters success:success failure:failure];
    
}

+ (void)getRequest:(NSString*)path
        parameters:(NSDictionary*)parameters
          encToken:(NSString*)encToken
           isLogin:(BOOL)isLogin
           success:(void (^)(id JSON))success
           failure:(void (^)(NSError* error, id JSON))failure {
    DLog(@"Request Start %@", [NSDate date]);
    DLog(@"Request %@", path);
    DLog(@"Params %@", parameters);
    
    [WebService getPath:path parameters:parameters
               encToken:encToken
                success:^(AFHTTPRequestOperation* op, id json) {
                    DLog(@"Request End Success %@", [NSDate date]);
                    
                    DLog(@"json is %@.", json);
                    
                    NSDictionary *jsonDict;
                    if ( [json isKindOfClass:[NSDictionary class]] )
                    {
                        jsonDict = (NSDictionary *)[json dictionaryByReplacingNullsWithStrings];
                    }
                    else
                    {
                        jsonDict = nil;
                    }
                    
                    [WebService handleSuccess:NO
                                      isLogin:isLogin
                                         path:path
                                   parameters:parameters
                                    operation:op
                                         json:jsonDict
                                      success:success
                                      failure:failure];
                }
     
                failure:^(AFHTTPRequestOperation* op, NSError* error)
     {
         DLog(@"Request End Faile %@", [NSDate date]);
         
         [WebService handleFailure:NO
                           isLogin:isLogin
                              path:path
                        parameters:parameters
                         operation:op
                             error:error
                           success:success
                           failure:failure];
         
     }];
}

+ (void)activity:(BOOL)on
{
    if(on && !activityOn)
    {
        activityOn = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_ACTIVITY_NOTIFICATION_NAME object:self userInfo:@{@"on": [NSNumber numberWithBool:on]}];
    }
    else if(!on && activityOn)
    {
        activityOn = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_ACTIVITY_NOTIFICATION_NAME object:self userInfo:@{@"on": [NSNumber numberWithBool:on]}];
    }
}

+ (NSString *)webServiceCurrentDateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *now = [[NSDate alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [dateFormatter stringFromDate:now];
}


+ (void)uploadRequest:(NSString *)path
		   parameters:(NSDictionary *)parameters
             encToken:(NSString*)encToken
		formDataArray:(NSArray *)formDataArray
			  isLogin:(BOOL)isLogin
			  success:(void (^)(id))success
			  failure:(void (^)(NSError *, id))failure
{
    DLog(@"Request Start %@", [NSDate date]);
    DLog(@"Request %@", path);
    DLog(@"Params %@", parameters);
    
    [WebService activity:YES];
    [WebService uploadPath:path parameters:parameters encToken:encToken constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for ( NSArray *arrayOfFormData in formDataArray )
        {
            [formData appendPartWithFileData:[arrayOfFormData objectAtIndex:0]
                                        name:[arrayOfFormData objectAtIndex:1]
                                    fileName:[arrayOfFormData objectAtIndex:2]
                                    mimeType:[arrayOfFormData objectAtIndex:3]];
        }
    }
                   success:^(AFHTTPRequestOperation* op, id json) {
					   
					   DLog(@"Request End Success %@", [NSDate date]);
					   NSDictionary *jsonDict = (NSDictionary *)[json dictionaryByReplacingNullsWithStrings];
					   [WebService handleSuccess:YES
										 isLogin:isLogin
											path:path
									  parameters:parameters
									   operation:op
											json:jsonDict
										 success:success
										 failure:failure];
					   
					   [WebService activity:NO];
				   }
     
				   failure:^(AFHTTPRequestOperation* op, NSError* error)
     {
         DLog(@"Request End Faile %@", [NSDate date]);
         [WebService handleFailure:YES
                           isLogin:isLogin
                              path:path
                        parameters:parameters
                         operation:op
                             error:error
                           success:success
                           failure:failure];
         
         [WebService activity:NO];
     }];
}


+ (void)uploadPath:(NSString *)path
        parameters:(NSDictionary *)parameters
          encToken:(NSString*)encToken
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSData *jsonData = parameters == nil ? nil : [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *requestBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [WebService sharedClient:nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:encToken forHTTPHeaderField:@"Authentication-Token"];
    [manager.requestSerializer setValue:requestBody forHTTPHeaderField:@"ContentInfo"];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
    
    [manager POST:path parameters:parameters constructingBodyWithBlock:block success:success failure:failure];
}

@end

////
////  WebService.m
////  Moovers
////
////  Created by Sai Chow on 2/17/14.
////  Copyright (c) 2014 Moovers. All rights reserved.
////
//
//#import "WebService.h"
//#import "AFNetworking.h"
//
//#import "NSDictionary+Utils.h"
//
//
//#define STATUS_SUCCESS  @"success"
//#define STATUS_ERROR    @"error"
//#define STATUS_FAIL     @"fail"
//#define NETWORK_ERROR   @"WS_Network_Error"
//
//#define NETWORK_ACTIVITY_NOTIFICATION_NAME @"WS_Network_Activity"
//
//static BOOL activityOn = NO;
//
//extern NSMutableArray *loginTokens;
//
//@implementation WebService
//
//+ (AFHTTPRequestOperationManager*)sharedClient:(NSString *) baseURL {
//    static AFHTTPRequestOperationManager *_sharedClient = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedClient = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
////        [_sharedClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
////        [_sharedClient setDefaultHeader:@"Accept" value:@"application/json"];
////        [_sharedClient setParameterEncoding:AFJSONParameterEncoding];
//    });
//    
//    return _sharedClient;
//}
//
//
//#pragma mark -
//#pragma mark Core
//
//+ (void)handleSuccess:(BOOL)isPost
//              isLogin:(BOOL)isLogin
//                 path:(NSString*)path
//           parameters:(NSDictionary*)parameters
//            operation:(AFHTTPRequestOperation*)op
//                 json:(id)json
//              success:(void (^)(id JSON))success
//              failure:(void (^)(NSError* error, id JSON))failure
//{
//    DLog(@"handleSuccess");
//    
//    
//    // Check for error status
//    NSString* status = [json objectForKey:@"status"];
////    NSString *errorCode = [json objectForKey:@"errorcode"];
//    
//    if([status isEqualToString:STATUS_ERROR]) {
//        NSString* message = [json objectForKey:@"message"];
//        DLog(@"Error: %@", message);
//        //failure([NSError defaultError:message errorCode:errorCode], json);
//        failure(nil, nil);
//    } else if([status isEqualToString:STATUS_FAIL]) {
//        
//        NSString* errorMessage = @"Error";
//        
//        NSDictionary* data = [json objectForKey:@"data"];
//        if(data && [data isKindOfClass:[NSDictionary class]]&& [data allKeys].count > 0) {
//            NSString* key = [[data allKeys] objectAtIndex:0];
//            if(key) {
//                id val = [data objectForKey:key];
//                if([val isKindOfClass:[NSString class]]) {
//                    errorMessage = val;
//                } else if([val isKindOfClass:[NSArray class]]) {
//                    errorMessage = [(NSArray*)val objectAtIndex:0];
//                }
//            }
//        }
//        
//        //failure([NSError defaultError:errorMessage errorCode:errorCode], json);
//        failure(nil, nil);
//    }
//    else {
//        success(json);
//    }
//}
//
//+ (void)handleFailure:(BOOL)isPost
//              isLogin:(BOOL)isLogin
//                 path:(NSString*)path
//           parameters:(NSDictionary*)parameters
//            operation:(AFHTTPRequestOperation*)op
//                error:(NSError*)error
//              success:(void (^)(id JSON))success
//              failure:(void (^)(NSError* error, id JSON))failure {
////    DLog(@"Failure %@", error.debugDescription);
//    [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_ERROR object:self userInfo:@{@"error": error}];
//    failure(error, nil);
//}
//
//+ (void)postRequest:(NSString*)path
//         parameters:(NSDictionary*)parameters
//           encToken:(NSString*)encToken
//            isLogin:(BOOL)isLogin
//            success:(void (^)(id JSON))success
//            failure:(void (^)(NSError* error, id JSON))failure
//
//{
//    DLog(@"Request Start %@", [NSDate date]);
//    DLog(@"Request %@", path);
//    DLog(@"Params %@", parameters);
//    
//    [WebService activity:YES];
//    [WebService postPath:path parameters:parameters encToken:encToken isLogin:isLogin
//                 success:^(AFHTTPRequestOperation* op, id json) {
//                     
//                     
//                     NSDictionary *responseDic = [op.response allHeaderFields];
//                     DLog(@"responseDic is %@.", responseDic);
//                     
//                     NSString *session_token = [responseDic objectForKey:@"session_token"];
//                     if (nil != session_token) {
//                         //[UserSession sharedInstance].userAccessToken = session_token;
//                     }
//                     
//                     
//                     DLog(@"Request End Success %@", [NSDate date]);
//                     NSDictionary *responseDict = (NSDictionary *)[json dictionaryByReplacingNullsWithStrings];
//                     NSArray *test = [responseDict objectForKey:@"ResponseList"];
//                     
//                     NSDictionary *jsonDict = nil;
//                     if ( (nil != test)
//                         && [test isKindOfClass:[NSArray class]]
//                         && (0 < [test count]) )
//                     {
//                         NSDictionary *anotherTest = [test objectAtIndex:0];
//                         jsonDict = (NSDictionary *)[anotherTest dictionaryByReplacingNullsWithStrings];
//                     }
//                     else {
//                         jsonDict = json;
//                     }
//                     
//                     [WebService handleSuccess:YES
//                                       isLogin:isLogin
//                                          path:path
//                                    parameters:parameters
//                                     operation:op
//                                          json:jsonDict
//                                       success:success
//                                       failure:failure];
//                     
//                     [WebService activity:NO];
//                 }
//     
//                 failure:^(AFHTTPRequestOperation* op, NSError* error)
//     {
//         DLog(@"Request End Faile %@", [NSDate date]);
//         [WebService handleFailure:YES
//                           isLogin:isLogin
//                              path:path
//                        parameters:parameters
//                         operation:op
//                             error:error
//                           success:success
//                           failure:failure];
//         
//         [WebService activity:NO];
//     }];
//}
//
//+ (void)postPath:(NSString *)path
//      parameters:(NSDictionary *)parameters
//        encToken:(NSString*)encToken
//         isLogin:(BOOL)isLogin
//         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//{
//    // method
//    NSString *method = @"POST";
//    
//    
//    // request body
//    NSData *jsonData = parameters == nil ? nil : [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
//    NSString *requestBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSMutableURLRequest *request = [[WebService sharedClient:nil] requestWithMethod:method path:path parameters:parameters];
//    // Authorization value
//    [request addValue:encToken forHTTPHeaderField:@"Authentication-Token"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//
//    
//	AFHTTPRequestOperation *operation = [[WebService sharedClient:nil] HTTPRequestOperationWithRequest:request success:success failure:failure];
//    
//    DLog(@"[request allHTTPHeaderFields] is %@.", [request allHTTPHeaderFields]);
//    
//    [[WebService sharedClient:nil] enqueueHTTPRequestOperation:operation];
//}
//
//+ (void)getPath:(NSString *)path
//     parameters:(NSDictionary *)parameters
//       encToken:(NSString*)encToken
//        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
//    
//    // method
//    NSString *method = @"GET";
//    
//    NSData *jsonData = parameters == nil ? nil : [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *requestBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSMutableURLRequest *request = [[WebService sharedClient:nil] requestWithMethod:method path:path parameters:parameters];
//    NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:@"currentUserName"];
//    NSString *currentDateString = [HMACStringGenerator currentDateString];
//    NSString *token = [loginTokens firstObject];
//    
//    NSString *str = [HMACStringGenerator generateAuthValueWithMethod:method requestBody:requestBody date:currentDateString username:username path:path preSharedKey:token];
//    NSString *authStr = str;
//    
//    
//    [request addValue:currentDateString forHTTPHeaderField:@"RequestDateTimeStamp"];
//    [request addValue:authStr forHTTPHeaderField:@"Authorization"];
//    [request addValue:[requestBody MD5] forHTTPHeaderField:@"ContentMd5"];
//    
//    [request addValue:encToken forHTTPHeaderField:@"Authentication-Token"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//    
//    AFHTTPRequestOperation *operation = [[WebService sharedClient:nil] HTTPRequestOperationWithRequest:request success:success failure:failure];
//    
//    DLog(@"get [request allHTTPHeaderFields] is %@.", [request allHTTPHeaderFields]);
//    
//    [[WebService sharedClient:nil] enqueueHTTPRequestOperation:operation];
//}
//
//+ (void)getRequest:(NSString*)path
//        parameters:(NSDictionary*)parameters
//          encToken:(NSString*)encToken
//           isLogin:(BOOL)isLogin
//           success:(void (^)(id JSON))success
//           failure:(void (^)(NSError* error, id JSON))failure {
//    DLog(@"Request Start %@", [NSDate date]);
//    DLog(@"Request %@", path);
//    DLog(@"Params %@", parameters);
//    
//    [WebService getPath:path parameters:parameters
//               encToken:encToken
//                success:^(AFHTTPRequestOperation* op, id json) {
//                    DLog(@"Request End Success %@", [NSDate date]);
//                    
//                    DLog(@"json is %@.", json);
//                    
//                    NSDictionary *jsonDict;
//                    if ( [json isKindOfClass:[NSDictionary class]] )
//                    {
//                        jsonDict = (NSDictionary *)[json dictionaryByReplacingNullsWithStrings];
//                    }
//                    else
//                    {
//                        jsonDict = nil;
//                    }
//                    
//                    [WebService handleSuccess:NO
//                                      isLogin:isLogin
//                                         path:path
//                                   parameters:parameters
//                                    operation:op
//                                         json:jsonDict
//                                      success:success
//                                      failure:failure];
//                }
//     
//                failure:^(AFHTTPRequestOperation* op, NSError* error)
//     {
//         DLog(@"Request End Faile %@", [NSDate date]);
//         
//         [WebService handleFailure:NO
//                           isLogin:isLogin
//                              path:path
//                        parameters:parameters
//                         operation:op
//                             error:error
//                           success:success
//                           failure:failure];
//         
//     }];
//}
//
//+ (void)activity:(BOOL)on
//{
//    if(on && !activityOn)
//    {
//        activityOn = YES;
//        [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_ACTIVITY_NOTIFICATION_NAME object:self userInfo:@{@"on": [NSNumber numberWithBool:on]}];
//    }
//    else if(!on && activityOn)
//    {
//        activityOn = NO;
//        [[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_ACTIVITY_NOTIFICATION_NAME object:self userInfo:@{@"on": [NSNumber numberWithBool:on]}];
//    }
//}
//
//+ (NSString *)webServiceCurrentDateString {
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSDate *now = [[NSDate alloc] init];
//    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
//    
//    return [dateFormatter stringFromDate:now];
//}
//
//
//+ (void)uploadRequest:(NSString *)path
//		   parameters:(NSDictionary *)parameters
//             encToken:(NSString*)encToken
//		formDataArray:(NSArray *)formDataArray
//			  isLogin:(BOOL)isLogin
//			  success:(void (^)(id))success
//			  failure:(void (^)(NSError *, id))failure
//{
//    DLog(@"Request Start %@", [NSDate date]);
//    DLog(@"Request %@", path);
//    DLog(@"Params %@", parameters);
//    
//    [WebService activity:YES];
//    [WebService uploadPath:path parameters:parameters encToken:encToken constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        for ( NSArray *arrayOfFormData in formDataArray )
//        {
//            [formData appendPartWithFileData:[arrayOfFormData objectAtIndex:0]
//                                        name:[arrayOfFormData objectAtIndex:1]
//                                    fileName:[arrayOfFormData objectAtIndex:2]
//                                    mimeType:[arrayOfFormData objectAtIndex:3]];
//        }
//    }
//                   success:^(AFHTTPRequestOperation* op, id json) {
//					   
//					   DLog(@"Request End Success %@", [NSDate date]);
//					   NSDictionary *jsonDict = (NSDictionary *)[json dictionaryByReplacingNullsWithStrings];
//					   [WebService handleSuccess:YES
//										 isLogin:isLogin
//											path:path
//									  parameters:parameters
//									   operation:op
//											json:jsonDict
//										 success:success
//										 failure:failure];
//					   
//					   [WebService activity:NO];
//				   }
//     
//				   failure:^(AFHTTPRequestOperation* op, NSError* error)
//     {
//         DLog(@"Request End Faile %@", [NSDate date]);
//         [WebService handleFailure:YES
//                           isLogin:isLogin
//                              path:path
//                        parameters:parameters
//                         operation:op
//                             error:error
//                           success:success
//                           failure:failure];
//         
//         [WebService activity:NO];
//     }];
//}
//
//
//+ (void)uploadPath:(NSString *)path
//        parameters:(NSDictionary *)parameters
//          encToken:(NSString*)encToken
//constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
//           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//{
//    NSMutableURLRequest *request = [[WebService sharedClient:nil]
//                                    multipartFormRequestWithMethod:@"POST"
//                                    path:path
//                                    parameters:parameters
//                                    constructingBodyWithBlock:block];
//    
//    NSData *jsonData = parameters == nil ? nil : [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
//    NSString *requestBody = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    [request addValue:encToken forHTTPHeaderField:@"Authentication-Token"];
//    [request addValue:requestBody forHTTPHeaderField:@"ContentInfo"];
//    [request addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//    
//    
//    
//	AFHTTPRequestOperation *operation = [[WebService sharedClient:nil] HTTPRequestOperationWithRequest:request success:success failure:failure];
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        // display the progress
//        DLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
//    }];
//    
//    [[WebService sharedClient:nil] enqueueHTTPRequestOperation:operation];
//}
//
//@end

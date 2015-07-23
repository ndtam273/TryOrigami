//
//  FXWSRequest.m
//  FXStencil
//
//  Created by Le Phuong Tien on 1/23/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import "FXWSRequest.h"
#import "Define.h"

@implementation FXWSRequest

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    
}

#pragma mark - Private Method
+ (NSString*) processParaPOSTWith:(NSDictionary*)info
{
    
    NSArray *keys       = [info allKeys];
    NSArray *values     = [info allValues];
    
    NSString *post      = @"";
    
    for (int i = 0; i < [keys count]; i ++) {
        if (i == 0) {
            post = [post stringByAppendingString:[NSString stringWithFormat:@"%@=%@",keys[i], values[i]]];
        } else {
            post = [post stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",keys[i], values[i]]];
        }
    }
    
    return post;

}

#pragma mark - Class method

+ (NSURLRequest*) requestWithMethod:(NSString*)method stringURL:(NSString*)strURL
{
    
    NSString *encodedUrl = [strURL stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
                                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                      timeoutInterval:FXWSRequestTimeOutDefault];
    
    [request setHTTPMethod:method];
    
    
    return request;
}

#pragma mark - FOR APP
+ (NSURLRequest*) requestWithMethod:(NSString*)method
                        queryString:(NSString*)queryString
                         parameters:(NSDictionary*)parameters
{
   
    NSString *encodedUrl    = [queryString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"URL - %@", encodedUrl);
    
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
                                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                      timeoutInterval:FXWSRequestTimeOutDefault];
    [request setHTTPMethod:[method uppercaseString]];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@",AUTH_USERNAME,AUTH_PASSWORD];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *baseString = [authData base64EncodedStringWithOptions:0];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", baseString];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    if (![[method uppercaseString] isEqualToString:FXWSRequestMethodGET]) {
        NSString *post = [self processParaPOSTWith:parameters];
        
        NSLog (@"Post data : %@",post);
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
    }
    
    NSLog(@"%@",request.allHTTPHeaderFields);
    
    return request;
}

+ (NSURLRequest*) requestWithMethod:(NSString*)method
                        queryString:(NSString*)queryString
                         postString:(NSString*)postString
{
    NSString *encodedUrl    = [queryString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"URL - %@", encodedUrl);
    
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
                                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                      timeoutInterval:FXWSRequestTimeOutDefault];
    [request setHTTPMethod:[method uppercaseString]];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@",AUTH_USERNAME,AUTH_PASSWORD];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *baseString = [authData base64EncodedStringWithOptions:0];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", baseString];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    if ([[method uppercaseString] isEqualToString:FXWSRequestMethodPOST] ||
        [[method uppercaseString] isEqualToString:FXWSRequestMethodPUT] ) {
        
        
        NSLog (@"Post data : %@",postString);
        
        NSData *postData = [postString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
    }
    
    NSLog(@"%@",request.allHTTPHeaderFields);
    
    return request;
}


+ (NSURLRequest*) requestWithMethod:(NSString*)method
                        queryString:(NSString*)queryString
                           jsonData:(NSDictionary*)jsonData
{
    NSString *encodedUrl    = [queryString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"URL - %@", encodedUrl);
    
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
                                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                      timeoutInterval:FXWSRequestTimeOutDefault];
    [request setHTTPMethod:[method uppercaseString]];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@",AUTH_USERNAME,AUTH_PASSWORD];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *baseString = [authData base64EncodedStringWithOptions:0];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", baseString];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    if ([[method uppercaseString] isEqualToString:FXWSRequestMethodPOST] ||
        [[method uppercaseString] isEqualToString:FXWSRequestMethodPUT]) {
        
        NSLog(@"jsonPost: %@", jsonData);
        
        NSData *dataPost = [NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:nil];
        
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
       
        [request setHTTPBody:dataPost];
    }
    
    NSLog(@"----> %@",request.HTTPBody);
    
    return request;
}

+ (NSURLRequest*) requestWithMethod:(NSString*)method
                        queryString:(NSString*)queryString
                               data:(NSData*)dataPost {
    NSString *encodedUrl    = [queryString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"URL - %@", encodedUrl);
    
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
                                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                      timeoutInterval:FXWSRequestTimeOutDefault];
    [request setHTTPMethod:[method uppercaseString]];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@",AUTH_USERNAME,AUTH_PASSWORD];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *baseString = [authData base64EncodedStringWithOptions:0];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", baseString];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    if ([[method uppercaseString] isEqualToString:FXWSRequestMethodPOST]) {
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:dataPost];
    }
    
    NSLog(@"----> %@",request.HTTPBody);
    
    return request;
}

+ (NSURLRequest*) requestPutDictionaryWithMethod:(NSString*)method
                        queryString:(NSString*)queryString
                         parameters:(NSDictionary*)parameters
{
    
    NSString *encodedUrl    = [queryString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"URL - %@", encodedUrl);
    
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
                                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                      timeoutInterval:FXWSRequestTimeOutDefault];
    [request setHTTPMethod:[method uppercaseString]];
    
    NSString *authStr = [NSString stringWithFormat:@"%@:%@",AUTH_USERNAME,AUTH_PASSWORD];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *baseString = [authData base64EncodedStringWithOptions:0];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", baseString];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    if ([[method uppercaseString] isEqualToString:FXWSRequestMethodPOST]) {
        NSString *post = [self processParaPOSTWith:parameters];
        
        NSLog (@"Post data : %@",post);
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
    }
    
    NSLog(@"%@",request.HTTPBody);
    
    return request;
}




+ (NSURLRequest*) requestWithMethod:(NSString*)method
                        queryString:(NSString*)queryString
                         parameters:(NSDictionary*)parameters
                       headerValues:(NSDictionary*)headerValues
{
    NSString *encodedUrl    = [queryString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"URL - %@", encodedUrl);
    
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
                                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                      timeoutInterval:FXWSRequestTimeOutDefault];
    [request setHTTPMethod:[method uppercaseString]];
    
    BOOL isContentTypeDefalse = YES;
    
    if (headerValues) {
        
        
        NSArray *keys       = [headerValues allKeys];
        NSArray *values     = [headerValues allValues];
        
        for (int i = 0; i < [keys count]; i ++) {
            
            if ([keys[i] isEqual:@"Content-Type"]) isContentTypeDefalse = NO;
            
            [request setValue:values[i] forHTTPHeaderField:keys[i]];
        }

    }
    
    if ([[method uppercaseString] isEqualToString:FXWSRequestMethodPOST]) {
        NSString *post = [self processParaPOSTWith:parameters];
        
        NSLog (@"Post data : %@",post);
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        if (isContentTypeDefalse) {
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        }
        [request setHTTPBody:postData];
        
    }
    
    
    
    return request;
}

#pragma mark - PHOTO
+ (NSURLRequest*) requestUploadPhotoWithData:(NSData*)data
                                 queryString:(NSString*)queryString
                                 parameters:(NSDictionary*)parameters
                                  method   : (NSString*)method
                                 


{
    NSString *encodedUrl    = [queryString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    NSLog(@"URL - %@", encodedUrl);
    
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:encodedUrl]
                                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                      timeoutInterval:FXWSRequestTimeOutDefault];
    [request setHTTPMethod:[method uppercaseString]];
    
    // add Header
    NSString *authStr = [NSString stringWithFormat:@"%@:%@",AUTH_USERNAME,AUTH_PASSWORD];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
   
    
    // set boundary
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    // create body
    NSMutableData *body = [NSMutableData data];
    
    //input
    NSArray *keys       = [parameters allKeys];
    for (NSString *key in keys) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //file
    if ([data length]) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"without_video[upload_file]\"; filename=\"test.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:data];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];

    
    return request;
}

#pragma mark - request Youtube

+ (NSURLRequest*) requestYoutubeVideoWithMethod:(NSString *)method {
    
    NSString *stringQuery   = [NSString stringWithFormat:@"%@%@search?part=snippet&q=%@&key=AIzaSyCsOhlMbXyN-RWk2Tdp6X55lMposabnXYk",API_SERVER_Youtube, API_URL_Youtube, method];
    
    NSLog(@"URL - %@", stringQuery);
    
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringQuery]
                                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                      timeoutInterval:FXWSRequestTimeOutDefault];
    [request setHTTPMethod:@"GET"];
    
    
    return request;
}

#pragma mark - request TopSong

+ (NSURLRequest*) requestTopSongWithMethod:(NSInteger)limit {
    
    NSString *stringQuery        = [NSString stringWithFormat:@"%@%@%@limit=%ld/json",API_SERVER,API_URL,API_TOPSONG,(long)limit];
    
    NSLog(@"%@",stringQuery);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringQuery]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:FXWSRequestTimeOutDefault];
    [request setHTTPMethod:@"GET"];
    
    return request;
}




















@end

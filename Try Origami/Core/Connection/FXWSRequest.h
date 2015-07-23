//
//  FXWSRequest.h
//  FXStencil
//
//  Created by Le Phuong Tien on 1/23/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import <Foundation/Foundation.h>

//define METHOD
#define FXWSRequestMethodPOST               @"POST"
#define FXWSRequestMethodPUT                @"PUT"
#define FXWSRequestMethodGET                @"GET"
#define FXWSRequestMethodDELETE             @"DELETE"

//define TIME_OUT
#define FXWSRequestTimeOutDefault           60

@interface FXWSRequest : NSObject

+ (NSURLRequest*) requestWithMethod:(NSString*)method stringURL:(NSString*)strURL;

//API custome
+ (NSURLRequest*) requestWithMethod:(NSString*)method
                        queryString:(NSString*)queryString
                         parameters:(NSDictionary*)parameters;

+ (NSURLRequest*) requestWithMethod:(NSString*)method
                        queryString:(NSString*)queryString
                         postString:(NSString*)postString;

+ (NSURLRequest*) requestWithMethod:(NSString*)method
                        queryString:(NSString*)queryString
                           jsonData:(NSDictionary*)jsonData;

+ (NSURLRequest*) requestWithMethod:(NSString*)method
                        queryString:(NSString*)queryString
                         data:(NSData*)dataPost;

+ (NSURLRequest*) requestWithMethod:(NSString*)method
                        queryString:(NSString*)queryString
                         parameters:(NSDictionary*)parameters
                       headerValues:(NSDictionary*)headerValues;

+ (NSURLRequest*) requestUploadPhotoWithData:(NSData*)data
                                queryString :(NSString*)queryString
                                parameters  :(NSDictionary*)parameters
                                  method    :(NSString*)method;
// request Youtube
+ (NSURLRequest*) requestYoutubeVideoWithMethod:(NSString*)method;

// request TopSong
+ (NSURLRequest*) requestTopSongWithMethod:(NSInteger)limit;


@end

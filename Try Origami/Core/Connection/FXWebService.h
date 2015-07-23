//
//  FXWebService.h
//  FXStencil
//
//  Created by Le Phuong Tien on 1/23/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

/*
 
 Warring : If you use function with object, you must init object and set strURL.
 
 */

#import <Foundation/Foundation.h>
#import "FXError.h"
#import "FXConnection.h"
#import "FXWSRequest.h"
#import "FXWSParse.h"

typedef void (^FXWebServiceComplete)(NSData *data, FXError *error);
typedef void (^FXWebServiceIdentifierComplete)(NSData *data, FXError *error, id identifier);


@interface FXWebService : NSObject
{
    FXWebServiceComplete _complete;
    FXWebServiceIdentifierComplete _completeIdentifier;
    
    BOOL _isRequestWithTagert;
}

@property (nonatomic, strong) NSURLRequest        *urlRequest;
@property (nonatomic, strong) NSString            *strURL;
@property (nonatomic, strong) NSURL               *url;

@property (nonatomic, weak) id                    target;
@property (nonatomic, strong) id                  identifier;

//init function
- (id)initWithStringURL:(NSString*)stringURL;
- (id)initWithURLRequest:(NSURLRequest*)urlRequest;
- (id)initWithURLRequest:(NSURLRequest*)urlRequest tagert:(id)target;

//method
- (void) setCompleteWithBlock:(FXWebServiceComplete)complete;

//Class method
+ (void) callWSWithStringURL:(NSString*)stringURL completeWithBlock:(FXWebServiceComplete)complete;

+ (void) callWSWithURLRequest:(NSURLRequest*)urlRequest completeWithBlock:(FXWebServiceComplete)complete;
+ (void) callWSWithURLRequest:(NSURLRequest*)urlRequest tagert:(id)target completeWithBlock:(FXWebServiceComplete)complete;
+ (void) callWSWithURLRequest:(NSURLRequest*)urlRequest tagert:(id)target identifier:(id)identifier completeWithBlock:(FXWebServiceIdentifierComplete)complete;

@end


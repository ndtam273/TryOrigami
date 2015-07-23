//
//  FXConnection.h
//  FXConnection
//
//  Created by Le Phuong Tien on 1/15/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXError.h"

typedef void (^FXConnectionSussess)(NSData *data);
typedef void (^FXConnectionFail)(FXError *error);


@interface FXConnection : NSObject
{
    FXConnectionSussess _fxConnectionSussess;
    FXConnectionFail    _fxConnectionFail;
}

@property(nonatomic, strong) FXError             *error;
@property(nonatomic, strong) NSMutableData       *data;
@property(nonatomic, strong) NSString            *strURL;
@property(nonatomic, strong) NSURL               *url;


//method
+ (id)request:(NSString *)requestUrl sussess:(FXConnectionSussess)sussess fail:(FXConnectionFail)fail;
- (id)initWithRequest:(NSString *)requestUrl sussess:(FXConnectionSussess)sussess fail:(FXConnectionFail)fail;

+ (void)requestWithURLRequest:(NSURLRequest*)request sussess:(FXConnectionSussess)sussess fail:(FXConnectionFail)fail;

@end

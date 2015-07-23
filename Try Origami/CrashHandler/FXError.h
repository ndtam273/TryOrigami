//
//  FXError.h
//  FXConnection
//
//  Created by Le Phuong Tien on 1/15/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FXErrorNotification @"FXErrorNotification"

@interface FXError : NSObject

@property (nonatomic)           int         error_id;
@property (nonatomic, strong)   NSString    *error_msg;

+ (FXError*) error;

@end

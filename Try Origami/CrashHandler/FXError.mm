//
//  FXError.m
//  FXConnection
//
//  Created by Le Phuong Tien on 1/15/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import "FXError.h"


//DEFINE ID NOTIFICATION
#define _fx_idError1 4048

//DEFINE MESSAGE NOTIFICATION
#define _fx_messageError1 @"auto_login_key is invalid."


@interface FXError()
{
    
}

@property(nonatomic, strong) NSMutableDictionary *idNotifications;
@property(nonatomic, strong) NSMutableDictionary *messageNotifications;

@end

@implementation FXError

- (id) init
{
    self = [super init];
    if (self) {
        _error_id       = 0;
        _error_msg      = @"";
    }
    return self;
}

- (void)dealloc
{
    self.error_msg              = nil;
    self.idNotifications        = nil;
    self.messageNotifications   = nil;
}

+ (FXError*) error
{
    FXError *error = [[FXError alloc] init];
    return error;
}

#pragma mark - Notification

- (NSMutableDictionary*) idNotifications
{
    
    if (!_idNotifications) {
        _idNotifications = [[NSMutableDictionary alloc] init];
    }
    
    return _idNotifications;
}

- (NSMutableDictionary*) messageNotifications
{
    if (!_messageNotifications) {
        _messageNotifications = [[NSMutableDictionary alloc] init];
    }
    
    return _messageNotifications;
}

- (void) postNotification
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:_error_id], _error_msg] forKeys:@[@"error_id", @"error_msg"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:FXErrorNotification object:nil userInfo:userInfo];
}

#pragma mark - Setter

- (void)setError_id:(int)error_id
{
    _error_id = error_id;
    
    //check
    switch (error_id) {
        case _fx_idError1:
        {
            [self postNotification];
            break;
        }
        default:
            break;
    }
}

- (void)setError_msg:(NSString *)error_msg
{
    _error_msg = error_msg;
    
    //check
    if ([error_msg isEqualToString:_fx_messageError1]) {
        [self postNotification];
    }
}


@end

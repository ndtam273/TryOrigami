//
//  FXUser.h
//  FXStencil
//
//  Created by Le Phuong Tien on 1/20/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface User : NSObject

//Profile


//Method
- (void) login;
- (void) logout;

- (void) loadProfileInfo:(NSDictionary*)userInfo;



@end





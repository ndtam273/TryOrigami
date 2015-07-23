//
//  MVViewController.h
//  MuVeo
//
//  Created by Tam Nguyen on 7/13/15.
//  Copyright (c) 2015 AS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "Common.h"
#import "MBProgressHUD.h"

#define TIME_DURATION_TOAST                     3.0

@interface MVViewController : UIViewController


@property (nonatomic, strong) MBProgressHUD             *loadingView;

@property (nonatomic, weak) IBOutlet UIView             *viewHeader;
@property (nonatomic, weak) IBOutlet UILabel            *lbTitle;


//public method

- (void) showLoading;
- (void) hideLoading;

- (void) showToastMessageWith:(NSString*)message;
- (void) showToastMessageWith:(NSString*)message duration:(NSUInteger)durationInMillis;

//notification
- (void)eventListenerDidReceiveNotification:(NSNotification *)notification;

//Action
- (IBAction)back:(id)sender;
- (IBAction)close:(id)sender;




@end
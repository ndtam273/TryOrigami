//
//  MVViewController.m
//  MuVeo
//
//  Created by Tam Nguyen on 7/13/15.
//  Copyright (c) 2015 AS. All rights reserved.
//

#import "MVViewController.h"
#import "CSToast.h"

@interface MVViewController () <UIActionSheetDelegate>

@end

@implementation MVViewController

- (void)dealloc
{
    self.loadingView = nil;
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:DID_POST_MESHI object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loadingView = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_loadingView];
    
    //notification
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(eventListenerDidReceiveNotification:)
    //                                                 name:DID_POST_MESHI
    //                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

#pragma mark - Notification
- (void)eventListenerDidReceiveNotification:(NSNotification *)notification
{
    
}

#pragma mark - Action
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)close:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark - Loading view
- (void) showLoading
{
    [self.view bringSubviewToFront:_loadingView];
    [_loadingView show];
}

- (void) hideLoading
{
    [_loadingView hide];
}

#pragma mark - CSToast
- (void) showToastMessageWith:(NSString*)message
{
    [CSToast showToast:message withDuration:TIME_DURATION_TOAST];
}

- (void) showToastMessageWith:(NSString*)message duration:(NSUInteger)durationInMillis
{
    [CSToast showToast:message withDuration:durationInMillis];
}

@end

//
//  FXConnection.m
//  FXConnection
//
//  Created by Le Phuong Tien on 1/15/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import "FXConnection.h"


@interface FXConnection()


@end

@implementation FXConnection

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithRequest:(NSString *)requestUrl sussess:(FXConnectionSussess)sussess fail:(FXConnectionFail)fail
{
    self = [super init];
    if (self) {
        _fxConnectionSussess    = [sussess copy];
        _fxConnectionFail       = [fail copy];
        
        self.strURL             = requestUrl;
        
        NSURLRequest *request   = [NSURLRequest requestWithURL:_url];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
    return self;
}

- (void)dealloc
{
    self.data       = nil;
    self.error      = nil;
    self.strURL     = nil;
    self.url        = nil;
}

#pragma mark - Setter

- (void) setStrURL:(NSString *)strURL
{
    _strURL = strURL;
    _url = [NSURL URLWithString:strURL];
}

#pragma mark - Getter

- (NSMutableData*)data
{
    if (!_data) {
        _data = [[NSMutableData alloc] init];
    }
    
    return _data;
}

- (FXError*)error
{
    if (!_error) {
        _error = [[FXError alloc] init];
    }
    
    return _error;
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _fxConnectionSussess(self.data);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.error.error_id     = 1;
    self.error.error_msg    = error.localizedDescription;
    _fxConnectionFail(self.error);
}

#pragma mark - public method
- (void)request:(NSURLRequest*)request sussess:(FXConnectionSussess)sussess fail:(FXConnectionFail)fail
{
    _fxConnectionSussess    = [sussess copy];
    _fxConnectionFail       = [fail copy];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark - Class method
+ (id)request:(NSString *)requestUrl sussess:(FXConnectionSussess)sussess fail:(FXConnectionFail)fail
{
    return [[self alloc] initWithRequest:requestUrl sussess:sussess fail:fail];
}

+ (void)requestWithURLRequest:(NSURLRequest*)request sussess:(FXConnectionSussess)sussess fail:(FXConnectionFail)fail
{
    return [[[self alloc] init] request:request sussess:sussess fail:fail];
}






@end

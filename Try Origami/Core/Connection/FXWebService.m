//
//  FXWebService.m
//  FXStencil
//
//  Created by Le Phuong Tien on 1/23/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import "FXWebService.h"
#import "TryOrigami-Bridging-Header.h"

@interface FXWebService()
{
    
}

@end

@implementation FXWebService

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithStringURL:(NSString*)stringURL
{
    self = [super init];
    if (self) {
        self.strURL = stringURL;
    }
    return self;
}

- (id)initWithURLRequest:(NSURLRequest*)urlRequest
{
    self = [super init];
    if (self) {
        self.urlRequest = urlRequest;
    }
    return self;
}

- (id)initWithURLRequest:(NSURLRequest*)urlRequest tagert:(id)target
{
    self = [super init];
    if (self) {
        self.urlRequest         = urlRequest;
        self.target             = target;
        _isRequestWithTagert    = YES;
    }
    return self;
}

- (id)initWithURLRequest:(NSURLRequest*)urlRequest tagert:(id)target identifier:(id)identifier
{
    self = [super init];
    if (self) {
        self.urlRequest         = urlRequest;
        self.target             = target;
        self.identifier         = identifier;
        _isRequestWithTagert    = YES;
    }
    return self;
}


- (void)dealloc
{
    self.identifier = nil;
    self.urlRequest = nil;
    self.strURL     = nil;
    self.url        = nil;
    self.target     = nil;
}

#pragma mark - Setter
- (void) setStrURL:(NSString *)strURL
{
    _strURL = strURL;
    _url = [NSURL URLWithString:strURL];
}

#pragma mark - Getter

- (NSURLRequest*) urlRequest
{
    if (!_urlRequest) {
        _urlRequest   = [NSURLRequest requestWithURL:self.url];
    }
    
    return _urlRequest;
}

#pragma mark - public method

- (void)setCompleteWithBlock:(FXWebServiceComplete)complete
{
    _complete = [complete copy];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [FXConnection requestWithURLRequest:self.urlRequest sussess:^(NSData *data) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (_isRequestWithTagert && !self.target) {
                    return;
                }
                
                _complete(data, nil);
            });
        });
        
    } fail:^(FXError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (_isRequestWithTagert && !self.target) {
                    return;
                }
                
                _complete(nil, error);
            });
        });
        
    }];

}

- (void)setCompleteIdentifierWithBlock:(FXWebServiceIdentifierComplete)complete
{
    _completeIdentifier = [complete copy];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [FXConnection requestWithURLRequest:self.urlRequest sussess:^(NSData *data) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (_isRequestWithTagert && !self.target) {
                    return;
                }
                
                _completeIdentifier(data, nil, _identifier);
            });
        });
        
    } fail:^(FXError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (_isRequestWithTagert && !self.target) {
                    return;
                }
                
                _completeIdentifier(nil, error, _identifier);
            });
        });
        
    }];
    
}

#pragma mark - Class method
+ (void) callWSWithStringURL:(NSString*)stringURL completeWithBlock:(FXWebServiceComplete)complete
{
    return [[[self alloc] initWithStringURL:stringURL] setCompleteWithBlock:complete];
}

+ (void) callWSWithURLRequest:(NSURLRequest*)urlRequest completeWithBlock:(FXWebServiceComplete)complete
{
    return [[[self alloc] initWithURLRequest:urlRequest] setCompleteWithBlock:complete];
}

+ (void) callWSWithURLRequest:(NSURLRequest*)urlRequest tagert:(id)target completeWithBlock:(FXWebServiceComplete)complete
{
    return [[[self alloc] initWithURLRequest:urlRequest tagert:target] setCompleteWithBlock:complete];
}

+ (void) callWSWithURLRequest:(NSURLRequest*)urlRequest tagert:(id)target identifier:(id)identifier completeWithBlock:(FXWebServiceIdentifierComplete)complete
{
    return [[[self alloc] initWithURLRequest:urlRequest tagert:target identifier:identifier] setCompleteIdentifierWithBlock:complete];
}


@end

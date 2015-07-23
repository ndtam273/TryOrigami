//
//  FXDownloader.m
//  FXStencil
//
//  Created by Le Phuong Tien on 1/24/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import "FXDownloader.h"


@interface FXDownloader()
{
    
}

@end

@implementation FXDownloader

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
        self.strURL             = stringURL;
    }
    return self;
}

- (id) initWithStringURL:(NSString*)stringURL target:(id)target
{
    self = [super init];
    if (self) {
        self.strURL             = stringURL;
        self.target             = target;
        _isRequestWithTagert    = YES;
    }
    return self;
}

- (id) initWithStringURL:(NSString*)stringURL target:(id)target identifier:(id)identifier
{
    self = [super init];
    if (self) {
        self.strURL             = stringURL;
        self.target             = target;
        self.identifier         = identifier;
        _isRequestWithTagert    = YES;
    }
    return self;
}

- (id) initWithStringURL:(NSString*)stringURL target:(id)target identifier:(id)identifier indexPath:(NSIndexPath*)indexPath
{
    self = [super init];
    if (self) {
        self.strURL             = stringURL;
        self.target             = target;
        self.identifier         = identifier;
        self.indexPath          = indexPath;
        _isRequestWithTagert    = YES;
    }
    return self;
}

- (void)dealloc
{
    
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

- (void)setCompleteWithBlock:(FXDownloaderComplete)complete
{
    _complete = [complete copy];
    [FXConnection requestWithURLRequest:self.urlRequest sussess:^(NSData *data) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (_isRequestWithTagert && !self.target) {
                    return;
                }
                
                _complete(data, nil);
            });
        });
        
    } fail:^(FXError *error) {
        
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

- (void) setImageCompleteWithBlock:(FXDownloaderImageComplete)imageComplete
{
    _imageComplete = [imageComplete copy];
    
    [FXConnection requestWithURLRequest:self.urlRequest sussess:^(NSData *data) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (_isRequestWithTagert && !self.target) {
                    return;
                }
                
                if ([data length]) {
                    _imageComplete([UIImage imageWithData:data], nil);
                } else {
                    FXError *error = [FXError error];
                    error.error_id = 1;
                    error.error_msg = @"Image is 0 byte.";
                    
                    _imageComplete([UIImage imageNamed:NO_IMAGE_DEFAULT], error);
                }
                
            });
        });
        
    } fail:^(FXError *error) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (_isRequestWithTagert && !self.target) {
                    return;
                }
                
                 _imageComplete([UIImage imageNamed:NO_IMAGE_DEFAULT], error);
            });
        });
        
    }];
}

- (void) setCellImageCompleteWithBlock:(FXDownloaderCellImageComplete)cellImageComplete
{
    _cellImageComplete = [cellImageComplete copy];
    
    [FXConnection requestWithURLRequest:self.urlRequest sussess:^(NSData *data) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (_isRequestWithTagert && !self.target) {
                    return;
                }
                
                if ([data length]) {
                    
                    _cellImageComplete([UIImage imageWithData:data], nil, _indexPath, _identifier);
                } else {
                    FXError *error = [FXError error];
                    error.error_id = 1;
                    error.error_msg = @"Image is 0 byte.";
               
                     _cellImageComplete([UIImage imageNamed:NO_IMAGE_DEFAULT], error, _indexPath, _identifier);
                }
                
            });
        });
        
    } fail:^(FXError *error) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (_isRequestWithTagert && !self.target) {
                    return;
                }
                
                _cellImageComplete([UIImage imageNamed:NO_IMAGE_DEFAULT], error, _indexPath, _identifier);
                
            });
        });
        
    }];
}

#pragma mark - Class method
+ (void) downloadWithStringURL:(NSString*)stringURL
             completeWithBlock:(FXDownloaderComplete)complete
{
    return [[[self alloc] initWithStringURL:stringURL] setCompleteWithBlock:complete];
}

+ (void) downloadWithStringURL:(NSString*)stringURL
                        target:(id)target
             completeWithBlock:(FXDownloaderComplete)complete
{
    return [[[self alloc] initWithStringURL:stringURL target:target] setCompleteWithBlock:complete];
}

+ (void) downloadWithStringURL:(NSString*)stringURL
                        target:(id)target
                    identifier:(id)identifier
             completeWithBlock:(FXDownloaderComplete)complete
{
    return [[[self alloc] initWithStringURL:stringURL target:target identifier:identifier] setCompleteWithBlock:complete];
}

+ (void) downloadWithStringURL:(NSString*)stringURL
                        target:(id)target
                    identifier:(id)identifier
                     indexPath:(NSIndexPath*)indexPath
             completeWithBlock:(FXDownloaderComplete)complete
{
    return [[[self alloc] initWithStringURL:stringURL target:target identifier:identifier indexPath:indexPath] setCompleteWithBlock:complete];
}

#pragma mark - Download Image
+ (void) downLoadImageStringURL:(NSString*)stringURL
             completeWithBlock:(FXDownloaderImageComplete)complete
{
    return [[[self alloc] initWithStringURL:stringURL] setImageCompleteWithBlock:complete];
}

+ (void) downLoadImageStringURL:(NSString*)stringURL
                        target:(id)target
             completeWithBlock:(FXDownloaderImageComplete)complete
{
    return [[[self alloc] initWithStringURL:stringURL target:target] setImageCompleteWithBlock:complete];
}

+ (void) downLoadImageStringURL:(NSString*)stringURL
                        target:(id)target
                    identifier:(id)identifier
             completeWithBlock:(FXDownloaderImageComplete)complete
{
    return [[[self alloc] initWithStringURL:stringURL target:target identifier:identifier] setImageCompleteWithBlock:complete];
}

+ (void) downLoadImageStringURL:(NSString*)stringURL
                        target:(id)target
                    identifier:(id)identifier
                     indexPath:(NSIndexPath*)indexPath
             completeWithBlock:(FXDownloaderImageComplete)complete
{
    return [[[self alloc] initWithStringURL:stringURL target:target identifier:identifier indexPath:indexPath] setImageCompleteWithBlock:complete];
}

#pragma mark - cell downloader
+ (void) cellDownloadImageWithStringURL:(NSString*)stringURL
                                 target:(id)target
                             identifier:(id)identifier
                              indexPath:(NSIndexPath*)indexPath
                      completeWithBlock:(FXDownloaderCellImageComplete)complete
{
    return [[[self alloc] initWithStringURL:stringURL target:target identifier:identifier indexPath:indexPath] setCellImageCompleteWithBlock:complete];
}



@end

//
//  FXDownloader.h
//  FXStencil
//
//  Created by Le Phuong Tien on 1/24/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FXError.h"
#import "FXConnection.h"

#define NO_IMAGE_DEFAULT @"no_image.png"

typedef void (^FXDownloaderComplete)(NSData *data, FXError *error);

typedef void (^FXDownloaderImageComplete)(UIImage *image, FXError *error);
typedef void (^FXDownloaderCellImageComplete)(UIImage *image, FXError *error, NSIndexPath *indexPath, id identifier);

@interface FXDownloader : NSObject
{
    FXDownloaderComplete            _complete;
    FXDownloaderImageComplete       _imageComplete;
    FXDownloaderCellImageComplete   _cellImageComplete;
    
    BOOL _isRequestWithTagert;
    BOOL _isDownloadImage;
}

@property (nonatomic, strong) NSURLRequest          *urlRequest;
@property (nonatomic, strong) NSString              *strURL;
@property (nonatomic, strong) NSURL                 *url;

@property (nonatomic, weak)   id                    target;
@property (nonatomic, strong) id                    identifier;

@property (nonatomic, strong) NSIndexPath           *indexPath;


//init function
- (id) initWithStringURL:(NSString*)stringURL;
- (id) initWithStringURL:(NSString*)stringURL target:(id)target;
- (id) initWithStringURL:(NSString*)stringURL target:(id)target identifier:(id)identifier;
- (id) initWithStringURL:(NSString*)stringURL target:(id)target identifier:(id)identifier indexPath:(NSIndexPath*)indexPath;

//method
- (void) setCompleteWithBlock:(FXDownloaderComplete)complete;
- (void) setImageCompleteWithBlock:(FXDownloaderImageComplete)imageComplete;
- (void) setCellImageCompleteWithBlock:(FXDownloaderCellImageComplete)cellImageComplete;

//class method
+ (void) downloadWithStringURL:(NSString*)stringURL completeWithBlock:(FXDownloaderComplete)complete;
+ (void) downloadWithStringURL:(NSString*)stringURL target:(id)target completeWithBlock:(FXDownloaderComplete)complete;
+ (void) downloadWithStringURL:(NSString*)stringURL target:(id)target identifier:(id)identifier completeWithBlock:(FXDownloaderComplete)complete;
+ (void) downloadWithStringURL:(NSString*)stringURL target:(id)target identifier:(id)identifier indexPath:(NSIndexPath*)indexPath completeWithBlock:(FXDownloaderComplete)complete;

//download image
+ (void) downLoadImageStringURL:(NSString*)stringURL completeWithBlock:(FXDownloaderImageComplete)complete;
+ (void) downLoadImageStringURL:(NSString*)stringURL target:(id)target completeWithBlock:(FXDownloaderImageComplete)complete;
+ (void) downLoadImageStringURL:(NSString*)stringURL target:(id)target identifier:(id)identifier completeWithBlock:(FXDownloaderImageComplete)complete;
+ (void) downLoadImageStringURL:(NSString*)stringURL target:(id)target identifier:(id)identifier indexPath:(NSIndexPath*)indexPath completeWithBlock:(FXDownloaderImageComplete)complete;

//download cell
+ (void) cellDownloadImageWithStringURL:(NSString*)stringURL target:(id)target identifier:(id)identifier indexPath:(NSIndexPath*)indexPath completeWithBlock:(FXDownloaderCellImageComplete)complete;

@end

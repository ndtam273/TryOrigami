//
//  FXCommon.h
//  FXTemplateProject
//
//  Created by Le Phuong Tien on 1/20/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"




@interface Common : NSObject

//User
+ (User *) user;


//UIView

//alert
+ (void)showAlert:(NSString *)message title:(NSString*)title;
+ (void)showAlert:(NSString *)message title:(NSString*)title delegateTarget:(id)delegateTarget;

//image
+ (UIImage *) resizeImage:(UIImage *)orginalImage withSize:(CGSize)size;
+ (UIImage*)imageInRetinaScreenWithImage:(UIImage*)image;
+ (UIImage*) drawImage:(UIImage*)fgImage inImage:(UIImage*)bgImage atPoint:(CGPoint)point;

//String
+ (NSString*) md5: (NSString *)str;
+ (NSString*) trimString:(NSString*)string;

//Number
+ (BOOL) isNumeric:(NSString *)str;


//Dictionary
+ (NSData*)dataFormDictionary:(NSDictionary*)dic;
+ (NSDictionary*)dictionaryFormData:(NSData*)data;

//Validation
+ (BOOL) isEmailFormat:(NSString *)email;
+ (BOOL) isUrlFormat: (NSString *) url;

//Device
+ (void) setDeviceToken:(NSString*) token;
+ (NSString*) getDeviceToken;
+ (BOOL) checkScreenIPhone5;
+ (BOOL) detectIPhone;
+ (BOOL) isPortrait;
+ (BOOL) isIOS8;
+ (BOOL) isIOS7;
+ (BOOL) isIOS6;
+ (BOOL) isIOS5;

//XML
+ (NSString *) getXMLSpecialChars:(NSString *)str;
+ (NSString *) processXMLSpecialChars:(NSString *)str;

//JSON
+ (NSString*) formatJSONValue:(NSString*)str;
+ (float) formatJSONValueFloat:(NSString*)str;
+ (int) formatJSONValueInt:(NSString*)str;

//Date
+ (NSDate *) convertDateTime:(NSString *)fromUTCDateTime serverTime:(NSString *)strServerTime;

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)formatString;
+ (NSDate *) dateFromString:(NSString *)strDate withFormat:(NSString *)formatString;

+ (NSString *) getStrDateFromDate: (NSDate *)date;
+ (NSDate *) getDateFromStr: (NSString *)strDate;

+ (NSString *)timeAgoFromUnixTime:(double)seconds;

+ (NSString*) convertTimeToStringWithFormat:(NSString*)strFormat date:(NSDate*)date;

+ (NSDate *) dateUTCFromString:(NSString *)strDate withFormat:(NSString *)formatString;

//Audio
+ (void) playPushSound;
+ (void) playPushSoundWithCorrect:(BOOL)isCorrect;

//Color
+ (UIColor*) getTintColorWithUserDefine;
+ (UIColor*) randomColor;
+ (UIColor*) mainColor1;

//Others
+ (BOOL) isNetworkAvailable;
+ (NSString *) extractYoutubeID:(NSString *)youtubeURL;


@end

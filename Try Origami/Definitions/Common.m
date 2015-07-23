//
//  FXCommon.m
//  FXTemplateProject
//
//  Created by Le Phuong Tien on 1/20/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import "Common.h"
#import <CommonCrypto/CommonDigest.h>
#import <AudioToolbox/AudioServices.h>
#import "Reachability.h"


static User *user = nil;

@implementation Common

#pragma mark - FXUser
+ (User *) user
{
    if (user == nil) user = [[User alloc] init];
    return user;
}


#pragma mark - UIView

#pragma mark - UIAlertView
+ (void)showAlert:(NSString *)message title:(NSString*)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

+ (void)showAlert:(NSString *)message title:(NSString*)title delegateTarget:(id)delegateTarget
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegateTarget cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - UIImage
+ (UIImage *) resizeImage:(UIImage *)orginalImage withSize:(CGSize)size
{  CGFloat actualHeight = orginalImage.size.height;
    CGFloat actualWidth = orginalImage.size.width;
    
    if(actualWidth <= size.width || actualHeight <= size.height)
    {
        return orginalImage;
    }
    else
    {
        if((actualWidth/actualHeight)<(size.width/size.height))
        {
            actualHeight=actualHeight*(size.width/actualWidth);
            actualWidth=size.width;
            
        }else
        {
            actualWidth=actualWidth*(size.height/actualHeight);
            actualHeight=size.height;
        }
    }
    
    CGRect rect = CGRectMake(0.0,0.0,actualWidth,actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [orginalImage drawInRect:rect];
    orginalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return orginalImage;
}

+ (UIImage*)imageInRetinaScreenWithImage:(UIImage*)image
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0)) {
        CGSize size = [image size];
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width*2, size.height*2), NO, 0);
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(con, [UIColor whiteColor].CGColor);
        
        CGContextFillRect(con, CGRectMake(0, 0, size.width*2, size.height*2));
        [image drawInRect:CGRectMake(size.width/2.0, size.height/2.0, size.width, size.height) blendMode:kCGBlendModeNormal alpha:1.0];
        
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    } else {
        
        return image;
    }
}

+(UIImage*) drawImage:(UIImage*) fgImage
              inImage:(UIImage*) bgImage
              atPoint:(CGPoint)  point
{
    UIGraphicsBeginImageContextWithOptions(bgImage.size, FALSE, 0.0);
    [bgImage drawInRect:CGRectMake( 0, 0, bgImage.size.width, bgImage.size.height)];
    [fgImage drawInRect:CGRectMake( point.x, point.y, fgImage.size.width, fgImage.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


#pragma mark - String
+ (NSString*) md5: (NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString  stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4],
            result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12],
            result[13], result[14], result[15]
            ];
}

+ (NSString*)trimString:(NSString*)string
{
    if (string) {
        NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return trimmedString;
    } else {
        return @"";
    }
}

#pragma mark - Number
+ (BOOL) isNumeric:(NSString *)str
{
    NSScanner *sc = [NSScanner scannerWithString: str];
    if ( [sc scanFloat:NULL] )
    {
        return [sc isAtEnd];
    }
    return NO;
}

#pragma mark - Dictionary
+ (NSData*)dataFormDictionary:(NSDictionary*)dic
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dic forKey:@"fx"];
    [archiver finishEncoding];
    
    return data;
}

+ (NSDictionary*)dictionaryFormData:(NSData*)data
{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary *myDictionary = [unarchiver decodeObjectForKey:@"fx"];
    [unarchiver finishDecoding];
    
    return myDictionary;
}


#pragma mark - Validation
+ (BOOL) isEmailFormat:(NSString *)email
{
    NSString *emailRegEx =
    @"(?:[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[A-Za-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[A-Za-z0-9](?:[a-"
    @"z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[A-Za-z0-9-]*[A-Za-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:email];
    NSLog(@"check email result %i",myStringMatchesRegEx);
    return myStringMatchesRegEx;
}

+ (BOOL) isUrlFormat: (NSString *) url{
    NSString *theURL =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", theURL];
    return [urlTest evaluateWithObject:url];
}

#pragma mark - Device
+ (void) setDeviceToken:(NSString*) token
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:token forKey:@"DEVICE_TOKEN"];
    [prefs synchronize];
}

+ (NSString*) getDeviceToken
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *deviceToken = [prefs stringForKey:@"DEVICE_TOKEN"];
    if (deviceToken == NULL) {
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        deviceToken  = [Common md5:[dateFormat stringFromDate:today]];
        deviceToken = [NSString stringWithFormat:@"%@%@",deviceToken,deviceToken];
    }else{
        NSLog(@"device token : %@",deviceToken);
    }
    return deviceToken;
}

+ (BOOL) checkScreenIPhone5{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        if([UIScreen mainScreen].bounds.size.height == 568.0){
            return YES;
        }
        else{
            return NO;
        }
    }else{
        return NO;
    }
}

+ (BOOL) detectIPhone
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isPortrait
{
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationPortrait:
        {
            return YES;
            break;
        }
        case UIInterfaceOrientationLandscapeLeft:
        {
            return NO;
            break;
        }
        case UIInterfaceOrientationLandscapeRight:
        {
            return NO;
            break;
        }
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            return YES;
            break;
        }
        default:
            return NO;
            break;
    }
}
+ (BOOL) isIOS8
{
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if ([version floatValue] >= 8.0) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL) isIOS7
{
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if ([version floatValue] >= 7.0 && [version floatValue] < 8.0)  {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL) isIOS6
{
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if ([version floatValue] >= 6.0 && [version floatValue] < 7.0) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL) isIOS5
{
    NSString *version = [[UIDevice currentDevice] systemVersion];
    if ([version floatValue] >= 5.0 && [version floatValue] < 6.0) {
        return YES;
    }else {
        return NO;
    }
}


#pragma mark - XML
+ (NSString *) getXMLSpecialChars:(NSString *)str
{
    NSString * tempStr = [str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    return tempStr;
}

+ (NSString *) processXMLSpecialChars:(NSString *)str
{
    NSString * tempStr = [str stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
    return tempStr;
}

#pragma mark - JSON
+ (NSString*) formatJSONValue:(NSString*)str{
    
    NSString *temp = [NSString stringWithFormat:@"%@",str];
    
    if (str!=NULL) {
        if ([temp isEqualToString:@"null"] ||
            [temp isEqualToString:@"<null>"] ||
            [temp isEqualToString:@""]) {
            return @"";
        }else {
            return str;
        }
    }else {
        return @"";
    }
}

+ (int) formatJSONValueInt:(NSString*)str{
    
    NSString *temp = [NSString stringWithFormat:@"%@",str];
    
    if (str!=NULL) {
        if ([temp isEqualToString:@"null"] ||
            [temp isEqualToString:@"<null>"] ||
            [temp isEqualToString:@""]) {
            return 0 ;
        }else {
            return [str intValue];
        }
    }else {
        return 0;
    }
}

+ (float) formatJSONValueFloat:(NSString*)str{
    
    NSString *temp = [NSString stringWithFormat:@"%@",str];
    
    if (str!=NULL) {
        if ([temp isEqualToString:@"null"] ||
            [temp isEqualToString:@"<null>"] ||
            [temp isEqualToString:@""]) {
            return 0 ;
        }else {
            return [str floatValue];
        }
    }else {
        return 0;
    }
}

#pragma mark - Date
+ (NSDate *) convertDateTime:(NSString *)fromUTCDateTime serverTime:(NSString *)strServerTime{
    NSDateFormatter *srcDateFormatter = [[NSDateFormatter alloc] init];
    [srcDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [srcDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *serverDate = [srcDateFormatter dateFromString:strServerTime];
    
    
    NSDateFormatter *desDateFormatter = [[NSDateFormatter alloc] init];
    [desDateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [desDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *srcDate = [srcDateFormatter dateFromString:fromUTCDateTime];
    
    
    NSTimeInterval delta = [[NSDate date] timeIntervalSinceDate:serverDate];
    NSTimeInterval timeZoneOffset = [[NSTimeZone systemTimeZone] secondsFromGMT] + delta;
    NSDate *desDate = [NSDate dateWithTimeInterval:timeZoneOffset sinceDate:srcDate];
    NSLog(@"Correct Time%@", desDate);
    
    return desDate;
}

+ (NSString *) stringFromDate:(NSDate *)date withFormat:(NSString *)formatString
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = formatString;
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *) dateFromString:(NSString *)strDate withFormat:(NSString *)formatString{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
    
    NSDate *returnDate = [dateFormatter dateFromString:strDate];
    return returnDate;
}

+ (NSDate *) getDateFromStr: (NSString *)strDate{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
    
    NSDate *returnDate = [dateFormatter dateFromString:strDate];
    return returnDate;
}

+ (NSString *) getStrDateFromDate: (NSDate *)date{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"EN"]];
    
    NSString *returnStr = [dateFormatter stringFromDate:date];
    return returnStr;
}

+ (NSString *)timeAgoFromUnixTime:(double)seconds
{
    double difference = [[NSDate date] timeIntervalSince1970] - seconds;
    if (difference > 0) {
        NSMutableArray *periods = [NSMutableArray arrayWithObjects:@"second", @"minute", @"hour", @"day", @"week", @"month", @"year", @"decade", nil];
        NSArray *lengths = [NSArray arrayWithObjects:@60, @60, @24, @7, @4.35, @12, @10, nil];
        int j = 0;
        for(j=0; difference >= [[lengths objectAtIndex:j] doubleValue]; j++)
        {
            difference /= [[lengths objectAtIndex:j] doubleValue];
        }
        difference = roundl(difference);
        if(difference != 1)
        {
            [periods insertObject:[[periods objectAtIndex:j] stringByAppendingString:@"s"] atIndex:j];
        }
        return [NSString stringWithFormat:@"%li %@%@", (long)difference, [periods objectAtIndex:j], @" ago"];
    } else {
        return @"N/A";
    }
}

+ (NSString*) convertTimeToStringWithFormat:(NSString*)strFormat date:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    
    [formatter setLocale:locale];
    [formatter setDateFormat:strFormat];
    
    return [formatter stringFromDate:date];
}

+ (NSDate *) dateUTCFromString:(NSString *)strDate withFormat:(NSString *)formatString{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatString];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate *returnDate = [dateFormatter dateFromString:strDate];
    return returnDate;
}


#pragma mark - Sound
+ (void) playPushSound
{
    SystemSoundID soundID;
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"tick" ofType:@"mp3"];
    CFURLRef soundUrl = (__bridge CFURLRef) [NSURL fileURLWithPath:soundPath];
    //Use audio sevices to create the sound
    AudioServicesCreateSystemSoundID((CFURLRef)soundUrl, &soundID);
    //Use audio services to play the sound
    AudioServicesPlaySystemSound(soundID);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //CFRelease(soundUrl);
    
}

+ (void) playPushSoundWithCorrect:(BOOL)isCorrect
{
    NSString *fileName = isCorrect ? @"correct" : @"wrong";
    
    SystemSoundID soundID;
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    CFURLRef soundUrl = (__bridge CFURLRef) [NSURL fileURLWithPath:soundPath];
    //Use audio sevices to create the sound
    AudioServicesCreateSystemSoundID((CFURLRef)soundUrl, &soundID);
    //Use audio services to play the sound
    AudioServicesPlaySystemSound(soundID);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //CFRelease(soundUrl);
    
}

#pragma mark - Color
+ (UIColor*) getTintColorWithUserDefine{
    return [UIColor colorWithRed:89.0/255.0 green:7.0/255.0 blue:35.0/255.0 alpha:1.0];
}

+ (UIColor*) randomColor
{
    float red   = arc4random() % 256;
    float green = arc4random() % 256;
    float blue  = arc4random() % 256;
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

+ (UIColor*) mainColor1
{
    return [UIColor colorWithRed:60.0/255.0 green:184.0/255.0 blue:120.0/255.0 alpha:1.0];
}

#pragma mark - Others
+ (NSString *) extractYoutubeID:(NSString *)youtubeURL
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"?.*v=(.*)" options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:youtubeURL options:0 range:NSMakeRange(0, [youtubeURL length])];
    if(!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0)))
    {
        NSString *substringForFirstMatch = [youtubeURL substringWithRange:rangeOfFirstMatch];
        
        return substringForFirstMatch;
    }
    return nil;
}

+ (BOOL) isNetworkAvailable
{
    Reachability *r = [Reachability reachabilityForInternetConnection];
    return !( [r currentReachabilityStatus] == NotReachable);
}






































@end

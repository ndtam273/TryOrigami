//
//  NSDictionary+GGWSParseJSON.m
//  YouLook
//
//  Created by Tien Le Phuong on 6/4/14.
//  Copyright (c) 2014 TienLP. All rights reserved.
//

#import "NSDictionary+GGWSParseJSON.h"

@implementation NSDictionary (GGWSParseJSON)


- (NSString*)trimString:(NSString*)string
{
    if (string) {
        NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return trimmedString;
    } else {
        return @"";
    }
}


- (BOOL) checkNumeric:(NSString *)s
{
    NSScanner *sc = [NSScanner scannerWithString: s];
    if ( [sc scanFloat:NULL] )
    {
        return [sc isAtEnd];
    }
    return NO;
}


- (id) parseObjectForKey:(NSString*)key
{
    return [self objectForKey:key];
}

- (NSDictionary*) dictionaryForKey:(NSString*)key
{
    return ([[self objectForKey:key] isKindOfClass:[NSDictionary class]]) ? [self objectForKey:key] : nil;
    
}

- (NSArray*) arrayForKey:(NSString*)key
{
     return ([[self objectForKey:key] isKindOfClass:[NSArray class]]) ? [self objectForKey:key] : nil;
}

- (NSString*) stringForKey:(NSString*)key
{
    NSString *temp = [NSString stringWithFormat:@"%@",[self objectForKey:key]];
    
    if ([self objectForKey:key] != NULL ) {
        
        if ([temp isEqualToString:@"null"] ||
            [temp isEqualToString:@"<null>"] ||
            [temp isEqualToString:@""]) {
            
            return @"";
            
        }else {
            
            temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            return temp;
        }
    }else {
        return @"";
    }
}

- (int) intForKey:(NSString*)key
{
    NSString *temp = [NSString stringWithFormat:@"%@",[self objectForKey:key]];
    
    if ([self objectForKey:key] != NULL) {
        if ([temp isEqualToString:@"null"] ||
            [temp isEqualToString:@"<null>"] ||
            [temp isEqualToString:@""]) {
            return 0 ;
        }else {
            if ([self checkNumeric:temp]) {
                return [temp intValue];
            } else {
                return 0;
            }
        }
    }else {
        return 0;
    }
}

- (float) floatForKey:(NSString*)key
{
    NSString *temp = [NSString stringWithFormat:@"%@",[self objectForKey:key]];
    
    if ([self objectForKey:key] != NULL) {
        if ([temp isEqualToString:@"null"] ||
            [temp isEqualToString:@"<null>"] ||
            [temp isEqualToString:@""]) {
            return 0 ;
        }else {
            if ([self checkNumeric:temp]) {
                return [temp floatValue];
            } else {
                return 0;
            }
        }
    }else {
        return 0;
    }
}

@end

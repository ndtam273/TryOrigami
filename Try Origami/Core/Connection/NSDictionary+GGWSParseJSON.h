//
//  NSDictionary+GGWSParseJSON.h
//  YouLook
//
//  Created by Tien Le Phuong on 6/4/14.
//  Copyright (c) 2014 TienLP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GGWSParseJSON)

- (BOOL) checkNumeric:(NSString *)s;

- (id) parseObjectForKey:(NSString*)key;
- (NSDictionary*) dictionaryForKey:(NSString*)key;
- (NSArray*) arrayForKey:(NSString*)key;
- (NSString*) stringForKey:(NSString*)key;
- (int) intForKey:(NSString*)key;
- (float) floatForKey:(NSString*)key;

@end

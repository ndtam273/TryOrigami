//
//  FXWSParse.h
//  FXStencil
//
//  Created by Le Phuong Tien on 1/23/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "XMLDictionary.h"
#import "FXError.h"
#import "NSDictionary+GGWSParseJSON.h"

//-------------- BLOCK Define--------------//
typedef void (^FXParseJSONBlock) (NSDictionary *dataDic, FXError *error);

typedef void (^FXParseLogin) (NSDictionary *dataDic, FXError *error);



// ---------------------------- //

@interface FXWSParse : NSObject
    
// basic
+ (NSMutableDictionary*) parseDataJSONWithData:(NSData*)data;

+ (void) parseDataJSONBlockWith:(NSData*)data complete:(FXParseJSONBlock)complete;


@end

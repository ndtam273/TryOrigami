//
//  FXWSParse.m
//  FXStencil
//
//  Created by Le Phuong Tien on 1/23/14.
//  Copyright (c) 2014 Le Phuong Tien. All rights reserved.
//

#import "FXWSParse.h"
#import "Common.h"
#import "NSDictionary+GGWSParseJSON.h"


//item

@implementation FXWSParse

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    
}

#pragma mark - Class Methods

+ (NSMutableDictionary*) parseDataJSONWithData:(NSData*)data
{
    NSString *tempStr = [[NSString alloc] initWithBytes: [data bytes]
                                                 length:[data length]
                                               encoding:NSUTF8StringEncoding];
    
    return [tempStr JSONValue];
}

+ (void) parseDataJSONBlockWith:(NSData*)data complete:(FXParseJSONBlock)complete
{
    NSString *tempStr = [[NSString alloc] initWithBytes: [data bytes]
                                                 length:[data length]
                                               encoding:NSUTF8StringEncoding];
  
    
    NSDictionary *dic   = [tempStr JSONValue];
    FXError *error      = [FXError error];
    
  
    
    NSDictionary *meta = [dic dictionaryForKey:@"meta"];
    int code = [meta intForKey:@"code"];
       if (code / 100 == 2) {
        NSDictionary *data = [dic dictionaryForKey:@"data"];
  
        complete(data, nil);
        
            }
    else {
                error.error_id  = 1;
                error.error_msg = [meta stringForKey:@"error_message"];
              
                complete(nil, error);

         }
    
}



@end

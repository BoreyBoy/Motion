//
//  NSString+CTExtensions.m
//  Motion
//
//  Created by BOREY on 14-4-3.
//  Copyright (c) 2014年 ctrip. All rights reserved.
//

#import "NSString+CTExtensions.h"

static NSDateFormatter *dateFormat = nil  ;

@implementation NSString (CTExtensions)
- (NSDate*) dateWithFormat:(NSString*)format {
    if(dateFormat==nil) {
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    }
    return [dateFormat dateFromString:format] ;
}
@end



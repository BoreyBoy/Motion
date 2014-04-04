//
//  NSDate+CTExtensions.m
//  Motion
//
//  Created by BOREY on 14-4-3.
//  Copyright (c) 2014年 ctrip. All rights reserved.
//

#import "NSDate+CTExtensions.h"

static NSDateFormatter *dateFormat = nil  ;

@implementation NSDate (CTExtensions)
- (NSString*) stringWithFormat:(NSString*)format {
    if(dateFormat==nil) {
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    }
    [dateFormat setDateFormat:format] ;
    
    return [dateFormat stringFromDate:self] ;
}
@end

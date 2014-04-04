//
//  CTMotionDayView.m
//  Motion
//
//  Created by BOREY on 14-3-31.
//  Copyright (c) 2014年 ctrip. All rights reserved.
//

#import "CTMotionDayView.h"

@interface CTMotionDayView(){
    CMStepCounter* stepCounter ;
    CMMotionActivityManager* motionActivityManager ;
}
@property(nonatomic, strong) NSOperationQueue* operationQueue ;

@property (strong, nonatomic) IBOutlet UILabel *labelStepCount;

@end

@implementation CTMotionDayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSOperationQueue*) operationQueue {
    if(_operationQueue==nil) {
        _operationQueue = [[NSOperationQueue alloc] init] ;
    }
    return _operationQueue ;
}

//查询某天的计步器
- (void) queryStepCount {
    if ([CMStepCounter isStepCountingAvailable]==NO) {
        //不支持
    }
    stepCounter = [[CMStepCounter alloc] init] ;
    
    [stepCounter queryStepCountStartingFrom:nil to:nil toQueue:self.operationQueue withHandler:^(NSInteger numberOfSteps, NSError *error){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^(void){
            self.labelStepCount.text = [NSString stringWithFormat:@"%d", numberOfSteps] ;
        }] ;
    }] ;
}

//查询活动日志
- (void) queryMotionActivity {
    if([CMMotionActivityManager isActivityAvailable]==NO) {
        //不支持
    }
    motionActivityManager = [[CMMotionActivityManager alloc] init] ;
    [motionActivityManager queryActivityStartingFromDate:nil toDate:nil toQueue:self.operationQueue withHandler:^(NSArray *activities, NSError *error){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^(void){
            
        }] ;
    }] ;
}

@end

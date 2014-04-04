//
//  CTStepCounterController.m
//  Motion
//
//  Created by BOREY on 14-4-1.
//  Copyright (c) 2014年 ctrip. All rights reserved.
//

#import "CTStepCounterController.h"

@interface CTStepCounterController () {
    BOOL isStart ;//是否已经开始
    NSDate* startDate ;//开始时间
    NSInteger totalSeconds ;//已经花费的时间，
    NSInteger totalStepCnt ;//已经花费的步伐
    
    NSInteger currentSeconds ;//现在花费的时间，
    NSInteger currentStepCnt ;//现在花费的步伐，
}
@property(nonatomic, strong) CMStepCounter* stepCounter ;
@property(nonatomic, strong) NSOperationQueue* operationQueue ;

@property (strong, nonatomic) IBOutlet UIButton *btnStart;
@property (strong, nonatomic) IBOutlet UIButton *btnReset;


@property (strong, nonatomic) IBOutlet UILabel *labelValueHour;
@property (strong, nonatomic) IBOutlet UILabel *labelTitleHour;
@property (strong, nonatomic) IBOutlet UILabel *labelValueMinute;
@property (strong, nonatomic) IBOutlet UILabel *labelTitleMinute;
@property (strong, nonatomic) IBOutlet UILabel *labelValueSecond;
@property (strong, nonatomic) IBOutlet UILabel *labelTitleSecond;
@property (strong, nonatomic) IBOutlet UILabel *labelValueStepCnt;

@end

@implementation CTStepCounterController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stepCounter = [[CMStepCounter alloc] init] ;
    self.operationQueue = [[NSOperationQueue alloc] init] ;
    
    // Do any additional setup after loading the view from its nib.
    isStart = [[NSUserDefaults standardUserDefaults] boolForKey:@"isStart"] ;
    if(isStart) {
        NSString* string = [[NSUserDefaults standardUserDefaults] stringForKey:@"startDate"] ;
        startDate = [string dateWithFormat:@"yyyyMMddHHmmss"] ;
        totalSeconds = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalSeconds"] ;
        totalStepCnt = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalStepCnt"] ;
        
        //查询历史
        NSDate* currentData = [NSDate date] ;
        [self.stepCounter queryStepCountStartingFrom:startDate to:currentData toQueue:[NSOperationQueue mainQueue] withHandler:^(NSInteger numberOfSteps, NSError *error){
            currentStepCnt += numberOfSteps ;
            currentSeconds += [currentData timeIntervalSinceDate:startDate] ;
            
            [self updateTimeWithSeconds:totalSeconds+currentSeconds] ;
            [self updateStepWithCount:totalStepCnt+currentStepCnt] ;
            
            [self handleEventStart] ;
        }] ;
    }
}

//更新步伐标签
- (void) updateStepWithCount:(NSInteger)numberOfStep {
    self.labelValueStepCnt.text = [NSString stringWithFormat:@"%d", numberOfStep] ;
}

//更新时间标签
- (void) updateTimeWithSeconds:(NSInteger)numberOfSecond {
    //分解
    int second = numberOfSecond % 60 ;
    int minute = (numberOfSecond / 60) % 60 ;
    int hour   = numberOfSecond / 3600 ;
    //时、分若是0，不显示
    if (hour==0) {
        self.labelTitleHour.hidden = self.labelValueHour.hidden = YES ;
    }
    else {
        self.labelTitleHour.hidden = self.labelValueHour.hidden = NO ;
        self.labelValueHour.text = [NSString stringWithFormat:@"%d", hour] ;
    }
    //时、分若是0，不显示
    if (minute==0) {
        self.labelValueMinute.hidden = self.labelTitleMinute.hidden = YES ;
    }
    else {
        self.labelValueMinute.hidden = self.labelTitleMinute.hidden = NO ;
        self.labelValueMinute.text = [NSString stringWithFormat:@"%d", minute] ;
    }
    //秒
    self.labelValueSecond.text = [NSString stringWithFormat:@"%d", second] ;
}

- (IBAction)onButtonStart:(id)sender {
    if (isStart==NO) {
        [self handleEventStart] ;
    }
    else {
        [self handleEventPause] ;
    }
}

- (IBAction)onButtonReset:(id)sender {
    [self handleEventReset] ;
}

//开始
- (void) handleEventStart {
    [self.stepCounter startStepCountingUpdatesToQueue:self.operationQueue updateOn:1 withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error){
        currentStepCnt += 1 ;
        currentSeconds = [timestamp timeIntervalSinceDate:startDate] ;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^(void){
            [self updateTimeWithSeconds:totalSeconds+currentSeconds] ;
            [self updateStepWithCount:totalStepCnt+currentStepCnt] ;
        }] ;
    }] ;
}

//暂停
- (void) handleEventPause {
    [self.stepCounter stopStepCountingUpdates] ;
    
    [[NSUserDefaults standardUserDefaults] setInteger:totalSeconds+currentSeconds forKey:@"totalSeconds"] ;
    [[NSUserDefaults standardUserDefaults] setInteger:totalStepCnt+currentStepCnt forKey:@"totalStepCnt"] ;
    [[NSUserDefaults standardUserDefaults] synchronize] ;
    
    currentSeconds = 0 ;
    currentStepCnt = 0 ;
    startDate = nil ;
}

//重置
- (void) handleEventReset {
    [self.stepCounter stopStepCountingUpdates] ;
    
    isStart = NO ;
    totalSeconds = 0 ;
    totalStepCnt = 0 ;
    
    [[NSUserDefaults standardUserDefaults] setBool:isStart forKey:@"isStart"] ;
    [[NSUserDefaults standardUserDefaults] setInteger:totalSeconds forKey:@"totalSeconds"] ;
    [[NSUserDefaults standardUserDefaults] setInteger:totalStepCnt forKey:@"totalStepCnt"] ;
    [[NSUserDefaults standardUserDefaults] synchronize] ;

    [self updateTimeWithSeconds:totalSeconds] ;
    [self updateStepWithCount:totalStepCnt] ;
}

//保存状态
- (void) saveStates {
    [[NSUserDefaults standardUserDefaults] setBool:isStart forKey:@"isStart"] ;
    [[NSUserDefaults standardUserDefaults] setInteger:totalSeconds forKey:@"totalSeconds"] ;
    [[NSUserDefaults standardUserDefaults] setInteger:totalStepCnt forKey:@"totalStepCnt"] ;
    [[NSUserDefaults standardUserDefaults] synchronize] ;
}

@end

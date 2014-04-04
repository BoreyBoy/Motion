//
//  CTStepCounterController.m
//  Motion
//
//  Created by BOREY on 14-4-1.
//  Copyright (c) 2014年 ctrip. All rights reserved.
//

#import "CTStepCounterController.h"

typedef NS_ENUM(NSInteger, CTButtonStartType) {
    CTButtonStartTypeReset = 0  ,    // 默认，复位状态
    CTButtonStartTypeRunning    ,    // Running状态
    CTButtonStartTypePause      ,    // 暂停状态
};

@interface CTStepCounterController () {
    NSDate* startDate ;//开始时间
    NSInteger totalSeconds ;//已经花费的时间，
    NSInteger totalStepCnt ;//已经花费的步伐
    
    NSInteger currentSeconds ;//现在花费的时间，
    NSInteger currentStepCnt ;//现在花费的步伐，
}
@property(nonatomic, assign) CTButtonStartType startType ;
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
    self.startType = [[NSUserDefaults standardUserDefaults] integerForKey:@"startType"] ;
    
    //Running
    if(self.startType==CTButtonStartTypeRunning) {
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
            
            [self startStepCounterTimer] ;
        }] ;
    }
    //Pause
    else if(self.startType==CTButtonStartTypePause) {
        totalSeconds = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalSeconds"] ;
        totalStepCnt = [[NSUserDefaults standardUserDefaults] integerForKey:@"totalStepCnt"] ;
        
        [self updateTimeWithSeconds:totalSeconds] ;
        [self updateStepWithCount:totalStepCnt] ;
    }
    
    //更新Buttons
    [self updateButtonStates] ;
}

//更新Buttons
- (void) updateButtonStates {
    //Running
    if(self.startType==CTButtonStartTypeRunning) {
        [self.btnStart setTitle:@"停止" forState:UIControlStateNormal] ;
        [self.btnReset setTitle:@"复位" forState:UIControlStateNormal] ;
    }
    //Pause
    else if(self.startType==CTButtonStartTypePause) {
        [self.btnStart setTitle:@"继续" forState:UIControlStateNormal] ;
        [self.btnReset setTitle:@"复位" forState:UIControlStateNormal] ;
    }
    //Reset
    else if(self.startType==CTButtonStartTypeReset) {
        [self.btnStart setTitle:@"开始" forState:UIControlStateNormal] ;
        [self.btnReset setTitle:@"复位" forState:UIControlStateNormal] ;
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
    //Running
    if(self.startType==CTButtonStartTypeRunning) {
        [self.stepCounter stopStepCountingUpdates] ;
        self.startType = CTButtonStartTypePause ;

        totalSeconds += currentSeconds ;
        totalStepCnt += currentStepCnt ;
        currentSeconds = currentStepCnt = 0 ;
    }
    //Pause & Reset
    else {
        startDate = [NSDate date] ;
        [self startStepCounterTimer] ;
        self.startType = CTButtonStartTypeRunning ;
    }
    [self updateButtonStates] ;
    [self saveStates] ;
}

- (IBAction)onButtonReset:(id)sender {
    [self.stepCounter stopStepCountingUpdates] ;
    self.startType = CTButtonStartTypeReset ;

    currentSeconds = currentStepCnt = 0 ;
    totalSeconds = 0 ;
    totalStepCnt = 0 ;
    
    [self updateTimeWithSeconds:totalSeconds] ;
    [self updateStepWithCount:totalStepCnt] ;
    [self updateButtonStates] ;
    [self saveStates] ;
}

//开始
- (void) startStepCounterTimer {
    self.startType = CTButtonStartTypeRunning ;
    [self.stepCounter startStepCountingUpdatesToQueue:self.operationQueue updateOn:1 withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error){
        currentStepCnt += 1 ;
        currentSeconds = [timestamp timeIntervalSinceDate:startDate] ;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^(void){
            [self updateTimeWithSeconds:totalSeconds+currentSeconds] ;
            [self updateStepWithCount:totalStepCnt+currentStepCnt] ;
        }] ;
    }] ;
}

//保存状态
- (void) saveStates {
    if(self.startType==CTButtonStartTypeRunning && startDate) {
        NSString* string = [startDate stringWithFormat:@"yyyyMMddHHmmss"] ;
        [[NSUserDefaults standardUserDefaults] setObject:string forKey:@"startDate"] ;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:self.startType forKey:@"startType"] ;
    [[NSUserDefaults standardUserDefaults] setInteger:totalSeconds forKey:@"totalSeconds"] ;
    [[NSUserDefaults standardUserDefaults] setInteger:totalStepCnt forKey:@"totalStepCnt"] ;
    [[NSUserDefaults standardUserDefaults] synchronize] ;
}

@end

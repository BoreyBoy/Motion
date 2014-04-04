//
//  CTMainController.m
//  Motion
//
//  Created by BOREY on 14-3-31.
//  Copyright (c) 2014年 ctrip. All rights reserved.
//

#import "CTMainController.h"
#import "CTMotionDayView.h"

@interface CTMainController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation CTMainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"主页面" ;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone ;
    }
    [self loadMotionDays] ;
}

//加载日历
- (void) loadMotionDays {
    int dayCount = 7 ;
    NSDate* today = [NSDate date] ;
    for (int i=0; i<dayCount; i++) {
        CTMotionDayView* dayView = [CTMotionDayView ctViewFromClassXibWithOwner:nil] ;
        dayView.ctLeft = self.scrollView.ctWidth * i ;
        dayView.date = today ;
        [self.scrollView addSubview:dayView] ;
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.ctWidth*dayCount, self.scrollView.ctHeight) ;
}


@end

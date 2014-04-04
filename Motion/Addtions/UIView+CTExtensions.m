//
//  UIView+CTExtensions.m
//  CTRIP_WIRELESS_HD
//
//  Created by BOREY on 13-11-19.
//  Copyright (c) 2013年 ctrip. All rights reserved.
//

#import "UIView+CTExtensions.h"


@implementation UIView (CTExtensions)

- (void) setCtHeight:(CGFloat)ctHeight
{
    CGRect frame = self.frame;
    frame.size.height = ctHeight;
    self.frame = frame;
}
- (void) setCtWidth:(CGFloat)ctWidth {
    CGRect frame = self.frame;
    frame.size.width = ctWidth;
    self.frame = frame;
}

- (void) setCtLeft:(CGFloat)ctLeft
{
    CGRect frame = self.frame;
    frame.origin.x = ctLeft;
    self.frame = frame;
}

- (void) setCtRight:(CGFloat)ctRight {
    CGRect frame = self.frame;
    frame.origin.x = ctRight - frame.size.width ;
    self.frame = frame;
}

- (void) setCtBottom:(CGFloat)ctBottom {
    CGRect frame = self.frame;
    frame.origin.y = ctBottom - frame.size.height ;
    self.frame = frame;
}

- (void) setCtTop:(CGFloat)ctTop {
    CGRect frame = self.frame;
    frame.origin.y = ctTop;
    self.frame = frame;
}
- (void) setCtSize:(CGSize)ctSize {
    CGRect frame = self.frame;
    frame.size = ctSize;
    self.frame = frame;
}
- (void) setCtOrigin:(CGPoint)ctOrigin {
    CGRect frame = self.frame;
    frame.origin = ctOrigin;
    self.frame = frame;
}
- (CGFloat) ctLeft { return self.frame.origin.x; }
- (CGFloat) ctTop { return self.frame.origin.y; }
- (CGFloat) ctHeight { return self.frame.size.height; }
- (CGFloat) ctWidth { return self.frame.size.width; }
- (CGSize) ctSize { return self.frame.size;}
- (CGPoint) ctOrigin { return self.frame.origin;}

- (CGFloat) ctRight { return self.frame.origin.x + self.frame.size.width; }
- (CGFloat) ctBottom { return self.frame.origin.y + self.frame.size.height; }

#pragma mark 初始化
/**
 *  view的代码初始化方法
 *
 *  @param rect  view的默认frame
 *  @param color view的默认背景色
 *
 *  @return 返回对象
 */
+ (id) ctViewWithFrame:(CGRect)rect backgroundColor:(UIColor*)color
{
    UIView* view = [[self alloc] initWithFrame:rect];
    view.backgroundColor = color;
    return view;
}

+ (id) ctViewWithFrame:(CGRect)rect backgroundColor:(UIColor*)color borderWidth:(CGFloat)borderWidth borderColor:(CGColorRef)borderColor borderRadius:(CGFloat)borderRadius
{
    UIView* view = [self ctViewWithFrame:rect backgroundColor:color];
    view.layer.borderColor = borderColor;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = borderWidth;
    view.layer.cornerRadius = borderRadius;
    return view;
}
/**
 *  view的xib初始化方法
 *
 *  @param xibName xib名称
 *  @param owner   xib元素的file's owner
 *
 *  @return 返回初始化结果
 */
+ (id) ctViewWithXibNamed:(NSString*) xibName owner:(id)owner
{
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:xibName owner:owner options:nil];
    if (views.count>0)
    {
        for (UIView* view in views)
        {
            if ([view isKindOfClass:self])
            {
                return view;
            }
        }
    }
    return nil ;
}

+ (id) ctViewFromClassXibWithOwner:(id)owner
{
    return [self ctViewWithXibNamed:NSStringFromClass(self) owner:owner] ;
}


- (void) ctCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds= YES ;
}

- (void) ctCornerRounded {
    [self ctCornerRadius:4] ;
}

- (void) ctCornerWithRoundingCorners:(UIRectCorner)corners {
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(4, 4)] ;
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];    
    self.layer.mask = shape ;
}



#pragma mark frame属性
/**
 *  只设置view的坐标x
 *
 *  @param x 坐标x
 */
- (void) ctSetOriginX:(int)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
/**
 *  只设置view的坐标y
 *
 *  @param y 坐标y
 */
- (void) ctSetOriginY:(int)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

/**
 *  只设置view的宽
 *
 *  @param width 宽度
 */
- (void) ctSetSizeWidth:(int)width
{
    CGRect rect = self.frame;
    rect.size.width = width ;
    self.frame = rect;
}
/**
 *  只设置view的高
 *
 *  @param height 高度
 */
- (void) ctSetSizeHeight:(int)height
{
    CGRect rect = self.frame;
    rect.size.height = height ;
    self.frame = rect;
}

/**
 *  设置view的坐标x、y
 *
 *  @param x 坐标x
 *  @param y 坐标y
 */
- (void) ctSetOriginX:(int)x originY:(int)y
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    rect.origin.y = y;
    self.frame = rect;
}

/**
 *  设置view的宽度和高度
 *
 *  @param width  宽度
 *  @param height 高度
 */
- (void) ctSetSizeWidth:(int)width sizeHeight:(int)height
{
    CGRect rect = self.frame;
    rect.size.width = width ;
    rect.size.height = height ;
    self.frame = rect;
}


/**
 *  view的frame右边界坐标
 *
 *  @return 返回view的frame右边界坐标
 */
- (NSInteger) ctGetFramePositionRight
{
    return self.frame.size.width + self.frame.origin.x ;
}
/**
 *  view的frame下边界坐标
 *
 *  @return 返回view的frame下边界坐标
 */
- (NSInteger) ctGetFramePositionBottom
{
    return self.frame.size.height + self.frame.origin.y ;
}

/**
 *  获取view的宽度
 *
 *  @return 返回view的宽度
 */
- (NSInteger) ctGetFrameWidth
{
    return self.bounds.size.width ;
}
/**
 *  获取view的高度
 *
 *  @return 返回view的高度
 */
- (NSInteger) ctGetFrameHeight
{
    return self.bounds.size.height ;    
}

- (void) ct_SetCenterPosition {
    NSInteger x = (self.superview.ctWidth - self.ctWidth)/2 ;
    NSInteger y = (self.superview.ctHeight - self.ctHeight)/2 ;
    [self ctSetOriginX:x originY:y] ;
}


#pragma mark SubViews
/**
 *  清除所有子view
 */
- (void) ctClearAllSubviews
{
    for (UIView* view in self.subviews)
    {
        [view removeFromSuperview];
    }
}
/**
 *  清除标示tag的子view，
 *
 *  @param tag 被清除的子view的tag，注意如果子view的tag不是传入参数，而子view的子view是此，却不清除
 */
- (void) ctClearSubviewsWithTag:(NSInteger)tag
{
    for (int i=self.subviews.count-1; i>=0; --i) {
        UIView* subView = [self.subviews objectAtIndex:i] ;
        if (subView.tag==tag)
        {
            [subView removeFromSuperview] ;
        }
    }
}

#pragma mark 排版
/**
 *  左边靠近rightView排版
 *
 *  @param rightView 右边的view
 */
- (void) ctLeftCloseToView:(UIView*)rightView
{
    [self ctLeftCloseToView:rightView space:0] ;
}


/**
 *  右边靠近label
 *
 *  @param leftView 左边的view
 */
- (void) ctRightCloseToView:(UIView*)leftView
{
    [self ctRightCloseToView:leftView space:0] ;
}

/**
 *  左边靠近rightView排版, 有space参数
 *
 *  @param rightView 右边的view
 *  @param space 两view之间间隙
 */
- (void) ctLeftCloseToView:(UIView*)rightView space:(NSInteger)space
{
    [self ctSetOriginX:rightView.frame.origin.x - self.frame.size.width - space] ;
}

/**
 *  右边靠近leftView排版, 有space参数
 *
 *  @param leftView 左边view
 *  @param space    两view之间间隙
 */
- (void) ctRightCloseToView:(UIView*)leftView space:(NSInteger)space
{
    [self ctSetOriginX:leftView.frame.origin.x + leftView.frame.size.width + space] ;
    
}


- (UIView *) parentForClass:(Class)_class {
    UIView *_pView = self;
    do  {
        if( ![_pView respondsToSelector:@selector(superview)] ) {
            return nil;
        }
        
        if( !_pView.superview) return nil;
        
        if( [_pView.superview isKindOfClass:_class] ) {
            return _pView.superview;
        }
        
        _pView = _pView.superview;
    } while ( true );
    
    return nil;
}

+ (BOOL) ctIsBigView:(CGFloat) width {
    return width > 340;
}
+ (BOOL) ctIsSmallView:(CGFloat) width{
    return width < 340;
}

- (BOOL) ctIsBigView
{
    return [UIView ctIsBigView:self.ctWidth];
}
- (BOOL) ctIsSmallView
{
    return [UIView ctIsSmallView:self.ctWidth];
}

- (UIView *)viewOfViewClass:(Class)viewClass
{
    if ([self isKindOfClass:viewClass]) {
        return self;
    }
    for (UIView *view in self.subviews) {
        return [view viewOfViewClass:viewClass];
    }
    return nil;
}
@end

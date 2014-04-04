//
//  UIView+CTExtensions.h
//  CTRIP_WIRELESS_HD
//
//  Created by BOREY on 13-11-19.
//  Copyright (c) 2013年 ctrip. All rights reserved.
//

/**
 *  UIView的扩展
 */
@interface UIView (CTExtensions)

@property (nonatomic) CGFloat ctWidth;
@property (nonatomic) CGFloat ctHeight;
@property (nonatomic) CGFloat ctTop;
@property (nonatomic) CGFloat ctLeft;
@property (nonatomic) CGFloat ctRight;
@property (nonatomic) CGFloat ctBottom;

@property (nonatomic) CGSize ctSize;
@property (nonatomic) CGPoint ctOrigin;

#pragma mark 初始化
/**
 *  view的代码初始化方法
 *
 *  @param rect  view的默认frame
 *  @param color view的默认背景色
 *
 *  @return 返回初始化结果
 */
+ (id) ctViewWithFrame:(CGRect)rect backgroundColor:(UIColor*)color ;

/**
 *  view的代码初始化方法
 *
 *  @param rect  view的默认frame
 *  @param color view的默认背景色
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *  @param borderRadius 边框圆角
 *
 *  @return 返回初始化结果
 */
+ (id) ctViewWithFrame:(CGRect)rect backgroundColor:(UIColor*)color borderWidth:(CGFloat)borderWidth borderColor:(CGColorRef)borderColor borderRadius:(CGFloat)borderRadius;
/**
 *  view的xib初始化方法
 *
 *  @param xibName xib名称
 *  @param owner   xib元素的file's owner
 *
 *  @return 返回对象
 */
+ (id) ctViewWithXibNamed:(NSString*) xibName owner:(id)owner;

/**
 *  view的xib初始化方法, xib为其类名
 *
 *  @param owner   xib元素的file's owner
 *
 *  @return 返回对象
 */
+ (id) ctViewFromClassXibWithOwner:(id)owner;


#pragma mark frame属性
/**
 *  只设置view的坐标x
 *
 *  @param x 坐标x
 */
- (void) ctSetOriginX:(int)x;
/**
 *  只设置view的坐标y
 *
 *  @param y 坐标y
 */
- (void) ctSetOriginY:(int)y;

/**
 *  只设置view的宽
 *
 *  @param width 宽度
 */
- (void) ctSetSizeWidth:(int)width ;
/**
 *  只设置view的高
 *
 *  @param height 高度
 */
- (void) ctSetSizeHeight:(int)height ;

/**
 *  设置view的坐标x、y
 *
 *  @param x 坐标x
 *  @param y 坐标y
 */
- (void) ctSetOriginX:(int)x originY:(int)y;
/**
 *  设置view的宽度和高度
 *
 *  @param width  宽度
 *  @param height 高度    
 */
- (void) ctSetSizeWidth:(int)width sizeHeight:(int)height ;

/**
 *  view的frame右边界坐标
 *
 *  @return 返回view的frame右边界坐标
 */
- (NSInteger) ctGetFramePositionRight ;
/**
 *  view的frame下边界坐标
 *
 *  @return 返回view的frame下边界坐标
 */
- (NSInteger) ctGetFramePositionBottom ;

/**
 *  获取view的宽度
 *
 *  @return 返回view的宽度
 */
- (NSInteger) ctGetFrameWidth ; 
/**
 *  获取view的高度
 *
 *  @return 返回view的高度
 */
- (NSInteger) ctGetFrameHeight ;

/** 设置中心点 */
- (void) ct_SetCenterPosition ;

#pragma mark SubView操作
/**
 *  清除所有子view
 */
- (void) ctClearAllSubviews;
/**
 *  清除标示tag的子view，
 *
 *  @param tag 被清除的子view的tag，注意如果子view的tag不是传入参数，而子view的子view是此，却不清除
 */
- (void) ctClearSubviewsWithTag:(NSInteger)tag ;

#pragma mark 位置排版
/**
 *  左边靠近rightView排版
 *
 *  @param rightView 右边的view
 */
- (void) ctLeftCloseToView:(UIView*)rightView ;

/**
 *  右边靠近label
 *
 *  @param leftView 左边的view
 */
- (void) ctRightCloseToView:(UIView*)leftView ;

/**
 *  左边靠近rightView排版, 有space参数
 *
 *  @param rightView 右边的view
 *  @param space 两view之间间隙
 */
- (void) ctLeftCloseToView:(UIView*)rightView space:(NSInteger)space ;

/**
 *  右边靠近leftView排版, 有space参数
 *
 *  @param leftView 左边view
 *  @param space    两view之间间隙
 */
- (void) ctRightCloseToView:(UIView*)leftView space:(NSInteger)space ;

- (UIView *) parentForClass:(Class) _class;

/**
 *  是否为大小View
 *
 *  @return
 */
- (BOOL) ctIsBigView;
- (BOOL) ctIsSmallView;
+ (BOOL) ctIsBigView:(CGFloat) width;
+ (BOOL) ctIsSmallView:(CGFloat) width;

/**
 *  view的圆角
 *
 */
- (void) ctCornerRadius:(CGFloat)cornerRadius;
- (void) ctCornerRounded;
/**
 *  view的圆角, 默认4
 *
 */
- (void) ctCornerWithRoundingCorners:(UIRectCorner)corners ;

/**
 *  取得view中某个类型的子view(包括view本身）
 *
 */
- (UIView *)viewOfViewClass:(Class)viewClass;

@end

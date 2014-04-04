//
//  UITableViewCell+CTExtensions.m
//  CTRIP_WIRELESS_HD
//
//  Created by BOREY on 13-11-19.
//  Copyright (c) 2013年 ctrip. All rights reserved.
//

#import "UITableViewCell+CTExtensions.h"
#import "UIView+CTExtensions.h"

@implementation UITableViewCell (CTExtensions)
/**
 *  从同名xib文件获取此cell, 能取到reused cell
 *
 *  @param tableView  cell所在tableView
 *  @param ownerOrNil xib的file's owner
 *
 *  @return 返回一个可使用cell
 */
+ (id)ctCellForTable:(UITableView*)tableView withOwner:(id)ownerOrNil
{
    return [self ctCellForTable:tableView withOwner:ownerOrNil xibNamed:NSStringFromClass(self)] ;
}

/**
 *  获取此cell, 自定义xibName, 能取到reused cell
 *
 *  @param tableView  cell所在tableView
 *  @param ownerOrNil xib的file's owner
 *  @param xibName    xib的Name
 *
 *  @return 返回一个可使用cel
 */
+ (id)ctCellForTable:(UITableView*)tableView withOwner:(id)ownerOrNil xibNamed:(NSString*)xibName
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:xibName] ;
    if (cell!=nil)
    {
        return cell ;
    }
    cell = [self ctViewWithXibNamed:xibName owner:ownerOrNil] ;
    if(cell)
    {
        return cell ;
    }
    return [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NillCell"] ;
}
@end

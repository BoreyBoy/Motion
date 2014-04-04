//
//  UITableViewCell+CTExtensions.h
//  CTRIP_WIRELESS_HD
//
//  Created by BOREY on 13-11-19.
//  Copyright (c) 2013年 ctrip. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (CTExtensions)
/**
 *  从同名xib文件获取此cell, 能取到reused cell， 如果创建失败，则代码初始化一个，防止崩溃
 *
 *  @param tableView  cell所在tableView
 *  @param ownerOrNil xib的file's owner
 *
 *  @return 返回一个可使用cell
 */
+ (id)ctCellForTable:(UITableView*)tableView withOwner:(id)ownerOrNil;

/**
 *  获取此cell, 自定义xibName, 能取到reused cell, 如果创建失败，则代码初始化一个，防止崩溃
 *
 *  @param tableView  cell所在tableView
 *  @param ownerOrNil xib的file's owner
 *  @param xibName    xib的Name
 *
 *  @return 返回一个可使用cel
 */
+ (id)ctCellForTable:(UITableView*)tableView withOwner:(id)ownerOrNil xibNamed:(NSString*)xibName;
@end

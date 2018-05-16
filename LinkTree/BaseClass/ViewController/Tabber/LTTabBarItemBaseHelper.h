//
//  LTTabBarItemHelper.h
//  YZCommunity
//
//  Created by lizhan on 2018/2/26.
//  Copyright © 2018年 压寨团队. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTTabBarItemModel.h"

#define TABBAR_ITEM_SELECT_NOTIFICATION @"TABBAR_ITEM_SELECT_NOTIFICATION"

@interface LTTabBarItemBaseHelper : NSObject

// 返回需要展示tabbar item的模型数组
+ (NSArray <LTTabBarItemModel *>*)displayTabBarItem;


// 返回默认选中哪个item
+ (NSInteger)selectTabbarItemIndex;


// 返回所有的navigation
+ (NSArray <UINavigationController *>*)navigationControllers;

// 返回所有的viewController
+ (NSArray <UIViewController *>*)viewControllers;

//重载所有控制器
+ (void)reloadViewControllers;

//删除所有控制器
+ (void)removeAllViewControllers;



@end

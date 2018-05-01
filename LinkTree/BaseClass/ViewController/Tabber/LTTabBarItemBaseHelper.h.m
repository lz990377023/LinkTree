//
//  LTTabBarItemHelper.m
//  YZCommunity
//
//  Created by lizhan on 2018/2/26.
//  Copyright © 2018年 压寨团队. All rights reserved.
//

#import "LTTabBarItemBaseHelper.h"
#import "LTTabBarAdapter.h"

@implementation LTTabBarItemBaseHelper

+ (NSArray <LTTabBarItemModel *>*)displayTabBarItem{
    return [self displayTabBarItem];
}

+ (NSInteger)selectTabbarItemIndex{
    return 1;
}

+ (NSArray <UINavigationController *>*)navigationControllers{
    return [LTTabBarAdapter sharedInstance].navigations;
}

+ (NSArray <UIViewController *>*)viewControllers{
    return [LTTabBarAdapter sharedInstance].viewControllers;
}

+ (void)reloadViewControllers{
    [[LTTabBarAdapter sharedInstance] reloadViewControllers];
}

+ (void)removeAllViewControllers{
    [[LTTabBarAdapter sharedInstance] removeAllViewControllers];
}


@end

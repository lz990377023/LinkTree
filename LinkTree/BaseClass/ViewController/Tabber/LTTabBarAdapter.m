//
//  LTTabBarAdapter.m
//  YZCommunity
//
//  Created by lizhan on 2018/2/26.
//  Copyright © 2018年 压寨团队. All rights reserved.
//

#import "LTTabBarAdapter.h"
#import "LTTabBarItemBaseHelper.h"
@implementation LTTabBarAdapter
+ (instancetype)sharedInstance{
    static LTTabBarAdapter * _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self loadTabBarItem];
    }
    return self;
}

- (void)loadTabBarItem{
    NSMutableArray *navigatArray = [NSMutableArray array];
    NSMutableArray *controlArray = [NSMutableArray array];
    [[LTTabBarItemBaseHelper displayTabBarItem] enumerateObjectsUsingBlock:^(LTTabBarItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [[obj.viewControllerClss alloc]init];
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:nil image:nil tag:idx];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:vc];
        [controlArray addObject:vc];
        [navigatArray addObject:navigation];
        obj->idx = idx;
        obj->viewControl = vc;
        obj->navigation = navigation;
    }];
    _viewControllers = [controlArray copy];
    _navigations = [navigatArray copy];
}

- (NSInteger)currentSelectIndex{
    return currentSelectIndex;
}

- (UINavigationController *)currentSelectNavigtion{
    if (currentSelectIndex<_navigations.count) {
        return _navigations[currentSelectIndex];
    }
    return nil;
}

- (UIViewController *)currentSelectViewControl{
    if (currentSelectIndex<_viewControllers.count) {
        return _viewControllers[currentSelectIndex];
    }
    return nil;
}

- (void)reoadViewControllers{
    [self loadTabBarItem];
}


- (void)removeAllViewControllers{
    _viewControllers = nil;
    _navigations = nil;
}



@end

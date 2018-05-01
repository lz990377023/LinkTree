//
//  LTTabBarAdapter.h
//  YZCommunity
//
//  Created by lizhan on 2018/2/26.
//  Copyright © 2018年 压寨团队. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LTTabBarAdapter : NSObject
{
    @package
    NSInteger currentSelectIndex;
}

// 获取当前选择的index
@property (nonatomic ,assign ,readonly) NSInteger currentSelectIndex;

// 获取当前选择的Navigtion
@property (nonatomic ,strong ,readonly) UINavigationController *currentSelectNavigtion;

// 获取当前选择的ViewControl
@property (nonatomic ,strong ,readonly) UIViewController *currentSelectViewControl;

// 获取所有的Navigtion
@property (nonatomic ,strong,readonly) NSArray <UINavigationController *>*navigations;

// 获取所有的ViewControl
@property (nonatomic ,strong,readonly) NSArray <UIViewController *>*viewControllers;

+ (instancetype)sharedInstance;

//重载所有控制器
- (void)reloadViewControllers;

//删除所有控制器
- (void)removeAllViewControllers;

@end

//
//  LTCustomTabBar.h
//  YZCommunity
//
//  Created by lizhan on 2018/2/26.
//  Copyright © 2018年 压寨团队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinkTree.h"
@interface LTCustomTabBar : UIView
@property (nonatomic ,strong,readonly) NSArray <UIButton *>*tabBarItems;
+ (instancetype)creatView;
- (void)reloadItem;
@end

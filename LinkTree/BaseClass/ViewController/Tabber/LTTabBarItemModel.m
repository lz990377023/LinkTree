//
//  LTTabBarItemModel.m
//  YZCommunity
//
//  Created by lizhan on 2018/2/26.
//  Copyright © 2018年 压寨团队. All rights reserved.
//

#import "LTTabBarItemModel.h"

@implementation LTTabBarItemModel

+ (instancetype)creatItem{
    LTTabBarItemModel *model = [[LTTabBarItemModel alloc]init];
    return model;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _viewControllerClss = nil;
        _title = @"";
        _selectImage = nil;
        _normalImage = nil;
        _itemTitleColorNormal = nil;
        _itemTitleColorSelect = nil;
        _soundName = @"";
        _isShowMessageBubble = NO;
        _bulgeOutEnabled = NO;
        _sendNotice = LTItemSendNoticeNot;
        _animationEnabled = NO;
        _titleEdgeInsets = UIEdgeInsetsZero;
        _imageEdgeInsets = UIEdgeInsetsZero;
        _isHideBottomLine = NO;
    }
    return self;
}


- (NSInteger)idx{
    return idx;
}

- (BOOL)isTabbarItemSelect{
    return isTabbarItemSelect;
}

- (UINavigationController *)navigation{
    return navigation;
}

- (UIViewController *)viewControl{
    return viewControl;
}


@end

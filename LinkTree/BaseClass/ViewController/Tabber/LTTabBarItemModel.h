//
//  LTTabBarItemModel.h
//  YZCommunity
//
//  Created by lizhan on 2018/2/26.
//  Copyright © 2018年 压寨团队. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LTItemSendNotice){
    LTItemSendNoticeNot, //不发送通知
    LTItemSendNoticeNormal, //item没选中点击时发送通知
    LTItemSendNoticeSelect, //item处于选中再次点击发送通知
};
@interface LTTabBarItemModel : NSObject
{
    @package
    NSInteger idx;
    BOOL isTabbarItemSelect;
    UIViewController *viewControl;
    UINavigationController *navigation;
}

// 控制器的class
@property (nonatomic ,assign) Class viewControllerClss;

// item的title
@property (nonatomic ,strong) NSString *title;

// 选中的图片
@property (nonatomic ,strong) UIImage *selectImage;

// 默认的图片
@property (nonatomic ,strong) UIImage *normalImage;

@property (nonatomic ,assign) UIEdgeInsets titleEdgeInsets;
@property (nonatomic ,assign) UIEdgeInsets imageEdgeInsets;

// 选中title的颜色
@property (nonatomic ,strong) UIColor *itemTitleColorSelect;

// 默认title的颜色
@property (nonatomic ,strong) UIColor *itemTitleColorNormal;

// item的音效
@property (nonatomic ,strong) NSString *soundName;

// item发送通知
@property (nonatomic ,assign) LTItemSendNotice sendNotice;

// item是否要激活动画
@property (nonatomic ,assign) BOOL animationEnabled;

// 是否显示消息红点
@property (nonatomic ,assign) BOOL isShowMessageBubble;

// 是否激活item的凸起效果
@property (nonatomic ,assign) BOOL bulgeOutEnabled;

//是否隐藏底部的通知view
@property (nonatomic ,assign) BOOL isHideBottomLine;


#pragma mark 只读属性
// index标识
@property (nonatomic ,assign, readonly) NSInteger idx;

// tabbaritem是否为选中状态
@property (nonatomic ,assign, readonly) BOOL isTabbarItemSelect;

// 模型对应的控制器
@property (nonatomic ,strong ,readonly) UIViewController *viewControl;

//模型对应的导航条
@property (nonatomic ,strong ,readonly) UINavigationController *navigation;


+ (instancetype)creatItem;

@end

static inline LTTabBarItemModel *YATabBarItem(Class viewControllerClss){
    LTTabBarItemModel * model = [LTTabBarItemModel creatItem];
    model.viewControllerClss = viewControllerClss;
    return model;
}

static inline LTTabBarItemModel *YATabBarItemWithTitle(Class viewControllerClss,NSString *title){
    LTTabBarItemModel * model = [LTTabBarItemModel creatItem];
    model.viewControllerClss = viewControllerClss;
    model.title = title;
    return model;
}





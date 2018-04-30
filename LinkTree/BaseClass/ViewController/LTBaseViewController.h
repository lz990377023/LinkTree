//
//  LTBaseViewController.h
//  LinkTree
//
//  Created by 李沾 on 2018/4/30.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinkTree.h"
typedef NS_ENUM(NSInteger,LTBackType){
    LTBackTypePopVC,
    LTBackTypePopRootVC,
    LTBackTypeDismissVC,
};

@interface LTBaseViewController : UIViewController
#define ITEM_TEXT(text)  self.creatTextBarItem(text)
#define ITEM_IMAGE(text) self.creatImageBarItem(text)

#define LEFT_ITEMS(...)  self.addLeftItems(__VA_ARGS__)
#define RIGHT_ITEMS(...) self.addRightItems(__VA_ARGS__)

#define LEFT_SELECT_INDEX(block,...) [self addLeftItemsSelectIndex:(__VA_ARGS__,block)]
#define RIGHT_SELECT_INDEX(block,...) [self addRightItemsSelectIndex:(__VA_ARGS__,block)]





/**
 *  创建带文字的BarItem
 */
@property (nonatomic ,copy)LTBaseButton *(^creatTextBarItem)(NSString *title);

/**
 *  创建带图片的BarItem
 */
@property (nonatomic ,copy)LTBaseButton *(^creatImageBarItem)(NSString *imageName);

/**
 *  设置隐藏navigationbar
 */
- (LTBaseViewController *(^)(BOOL hiddenNavigationBar,BOOL isAnimated))hiddenNavigationBar;

/**
 *  设置返回的类型，是否需要返回动画（BackType：选择返回类型   isAnimated：YES为打开动画，NO为关闭动画）
 */
- (LTBaseViewController *(^)(LTBackType type,BOOL isAnimated))backTypeAndAnimated;

/**
 *  添加左边的Item（item,...添加多个item）
 */
- (LTBaseViewController* (^)(LTBaseButton *item,...))addLeftItems;

- (LTBaseViewController* (^)(LTBaseButton *item,...))addLeftItemsSelectIndex:(void(^)(NSInteger selectIndex,BOOL *isHoldUpBack))selectIndex;

/**
 *  接收左边按钮的点击回调（selectIndex：根据item添加顺序返回值，*isHoldUpBack：是否拦截返回点击按钮，YES为拦截，NO为不拦截，默认不拦截）
 */
- (LTBaseViewController *)leftSelectIndex:(void(^)(NSInteger selectIndex,BOOL *isHoldUpBack))selectIndex;

/**
 *  添加右边的Item（item,...添加多个item）
 */
- (LTBaseViewController* (^)(LTBaseButton *item,...))addRightItems;

- (LTBaseViewController* (^)(LTBaseButton *item,...))addRightItemsSelectIndex:(void(^)(NSInteger selectIndex))selectIndex;

/**
 *  接收左边按钮的点击回调（selectIndex：根据item添加顺序返回值)
 */
- (LTBaseViewController *)rightSelectIndex:(void(^)(NSInteger selectIndex))selectIndex;

/**
 *  侧滑返回成功的回调
 */
- (LTBaseViewController *)swipeGesturesFinishBlock:(void (^)(double value))finish;

/**
 *  禁止侧滑返回（isEnable：是否可以使用：YES为可以使用，NO为不可以使用，默认为YES);
 */
- (LTBaseViewController *(^)(BOOL isEnable))swipeGesturesEnable;

- (LTBaseViewController *)And;
@end

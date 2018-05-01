//
//  LTBaseViewController.m
//  LinkTree
//
//  Created by 李沾 on 2018/4/30.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "LTBaseViewController.h"


#define LEFT_ITEM_DEFAULT_TAG 10
#define RIGHT_ITEM_DEFAULT_TAG 20

@interface LTBaseViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
/**
 *  接收左边按钮的点击的Block
 */
@property (nonatomic ,copy)void (^leftSelectIndex)(NSInteger index,BOOL *isHoldUpBack);
/**
 *  接收右边按钮的点击的Block
 */
@property (nonatomic ,copy)void (^rightSelectIndex)(NSInteger index);
/**
 *  接收返回按钮的类型
 */
@property (nonatomic ,assign) LTBackType backTotype;
/**
 *  接收是否需要返回动画
 */
@property (nonatomic ,assign) BOOL isPopAnimated;
/**
 *  接收是否隐藏导航条
 */
@property (nonatomic ,assign) BOOL isHiddenNavigationBar;
/**
 *  接收是否需要导航条的动画
 */
@property (nonatomic ,assign) BOOL isHiddenNavigationBarAnimated;
/**
 *  接收是否视图已经展示完成
 */
@property (nonatomic ,assign) BOOL isDidAppear;
@end

@implementation LTBaseViewController

#pragma  mark --------------生命周期------------------

- (void)loadView{
    [super loadView];
    self.swipeGesturesEnable(YES);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defaultConfig];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    // 设置状态栏为黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _isDidAppear = YES;
}

#pragma mark ------UINavigationControllerDelegate-------
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:_isHiddenNavigationBar animated:_isHiddenNavigationBarAnimated];
}


- (void)defaultConfig{
Navigation:{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"TabBar_Shadow_Line"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:18 weight:UIFontWeightRegular]}];
    // 导航栏不透明且占空间位置
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = YES;
    // 设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //使黑色线消失
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}
}

#pragma mark ----------创建NavigationBarItem------------
/**
 *  创建带文字的BarItem
 */
-(LTBaseButton *(^)(NSString *))creatTextBarItem{
    return ^(NSString *text){
        LTBaseButton *button = [LTBaseButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 60, 44);
        [button setTitle:text forState:UIControlStateNormal];
        return button;
    };
}

/**
 *  创建带图片的BarItem
 */
-(LTBaseButton *(^)(NSString *))creatImageBarItem{
    return ^(NSString *path){
        LTBaseButton *button = [LTBaseButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 60, 44);
        [button setImage:[UIImage imageNamed:path] forState:UIControlStateNormal];
        return button;
    };
}

#pragma mark--------------设置跳转样式----------------
/**
 *  设置返回的类型，是否需要返回动画（LTBackType：选择返回类型   isAnimated：YES为打开动画，NO为关闭动画）
 */
-(LTBaseViewController *(^)(LTBackType, BOOL))backTypeAndAnimated{
    @lt_weakify(self)
    return ^(LTBackType type,BOOL isAnimated){
        weak_self.backTotype = type;
        weak_self.isPopAnimated = isAnimated;
        return weak_self;
    };
}


-(LTBaseViewController *(^)(BOOL, BOOL))hiddenNavigationBar{
    @lt_weakify(self);
    return ^(BOOL isHiddenNavigationBar, BOOL isAnimated){
        weak_self.isHiddenNavigationBar = isHiddenNavigationBar;
        weak_self.isHiddenNavigationBarAnimated = isAnimated;
        if (weak_self.isDidAppear) {
            [weak_self.navigationController setNavigationBarHidden:isHiddenNavigationBar animated:isAnimated];
        }
        return weak_self;
    };
}

#pragma mark -------设置leftBarButtonItems和rightBarButtonItems-----------
/**
 *  添加左边的Item（item,...添加多个item）
 */
-(LTBaseViewController *(^)(LTBaseButton *, ...)) addLeftItems{
    @lt_weakify(self)
    return ^(LTBaseButton *item,...){
        NSMutableArray *items = [NSMutableArray array];
        if (item) {
            va_list args;
            va_start(args, item);
            LTBaseButton *tempItem;
            int tag = LEFT_ITEM_DEFAULT_TAG;
            while ((tempItem = va_arg(args, LTBaseButton *))) {
                tempItem.tag = tag;
                [tempItem addTarget:weak_self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
                [items addObject:tempItem];
                tag++;
            }
            va_end(args);
        }
        weak_self.navigationItem.leftBarButtonItems = [items copy];
        return weak_self;
    };
}

- (LTBaseViewController* (^)(LTBaseButton *item,...))addLeftItemsSelectIndex:(void(^)(NSInteger selectIndex,BOOL *isHoldUpBack))selectIndex{
    _leftSelectIndex = selectIndex;
    return [self addLeftItems];
}

/**
 *  添加右边的Item（item,...添加多个item）
 */
-(LTBaseViewController *(^)(LTBaseButton *, ...))addRightItems{
    @lt_weakify(self)
    return ^(LTBaseButton *item,...){
        NSMutableArray *items = [NSMutableArray array];
        if (item) {
            va_list args;
            va_start(args, item);
            LTBaseButton *tempItem;
            int tag = RIGHT_ITEM_DEFAULT_TAG;
            while ((tempItem = va_arg(args, LTBaseButton *) )) {
                tempItem.tag = tag;
                [tempItem addTarget:weak_self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
                [items addObject:tempItem];
                tag++;
            }
            va_end(args);
        }
        weak_self.navigationItem.rightBarButtonItems = [items copy];
        return weak_self;
    };
}

- (LTBaseViewController* (^)(LTBaseButton *item,...))addRightItemsSelectIndex:(void(^)(NSInteger selectIndex))selectIndex{
    _rightSelectIndex = selectIndex;
    return [self addRightItems];
}

#pragma mark ---------设置点击回调-----------
/**
 *  接收左边按钮的点击回调（selectIndex：根据item添加顺序返回的值，*isHoldUpBack：是否拦截返回点击按钮，YES为拦截，NO为不拦截）
 */
- (LTBaseViewController *)leftSelectIndex:(void (^)(NSInteger, BOOL *))selectIndex{
    _leftSelectIndex = selectIndex;
    return self;
}

/**
 *  接收左边按钮的点击回调（selectIndex：根据item添加顺序返回的值)
 */
- (LTBaseViewController *)rightSelectIndex:(void (^)(NSInteger))selectIndex{
    _rightSelectIndex = selectIndex;
    return self;
}

/**
 *  点击按钮的回调
 */

- (void)rightItemClick:(LTBaseButton *)button{
    if (_rightSelectIndex) {
        _rightSelectIndex(button.tag-RIGHT_ITEM_DEFAULT_TAG);
    }
}

- (void)leftItemClick:(LTBaseButton *)button{
    if (_leftSelectIndex) {
        BOOL isHoldUpBack = NO;
        _leftSelectIndex(button.tag - LEFT_ITEM_DEFAULT_TAG,&isHoldUpBack);
        if (button.tag == LEFT_ITEM_DEFAULT_TAG) {
            if (!isHoldUpBack) {
                switch (_backTotype) {
                    case LTBackTypePopVC:{[self.navigationController popViewControllerAnimated:_isPopAnimated];}break;
                    case LTBackTypePopRootVC:{[self.navigationController popToRootViewControllerAnimated:_isPopAnimated];}break;
                    case LTBackTypeDismissVC:{[self dismissViewControllerAnimated:_isPopAnimated completion:nil];}break;
                }
            }
        }
    }
}

#pragma mark ------侧滑返回成功回调---------
/**
 *  侧滑返回成功的回调
 */
- (LTBaseViewController *)swipeGesturesFinishBlock:(void (^)(double))finish{
    return self;
}

/**
 *  禁止侧滑返回（isEnable：是否可以使用：YES为可以使用，NO为不可以使用，默认为YES);
 */
- (LTBaseViewController *(^)(BOOL))swipeGesturesEnable{
    return ^(BOOL isEnable){
//        [self.navigationController swipeGesturesEnable:isEnable];
        return self;
    };
}
- (LTBaseViewController *)And{
    return self;
};

- (void)dealloc{
    _leftSelectIndex = nil;
    _rightSelectIndex = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

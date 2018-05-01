//
//  LTCustomTabBar.m
//  YZCommunity
//
//  Created by lizhan on 2018/2/26.
//  Copyright © 2018年 压寨团队. All rights reserved.
//

#import "LTCustomTabBar.h"
#import "LTTabBarItemBaseHelper.h"
@interface LTCustomTabBar()
@property (strong, nonatomic) NSArray <UIButton *>*messageItems;
@end

@implementation LTCustomTabBar

+(instancetype)creatView{
    LTCustomTabBar *tabBarView = [[LTCustomTabBar alloc]initWithFrame:CGRectMake(0, 0, LT_DEVICE_WIDTH, LT_TABBAR_HEIGHT)];
    return tabBarView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatTabBarItem];
        
    }
    return self;
}

- (void)creatTabBarItem{
    NSMutableArray *itemsArray = [NSMutableArray array];
    NSMutableArray *messageArray = [NSMutableArray array];
    [[LTTabBarItemBaseHelper displayTabBarItem] enumerateObjectsUsingBlock:^(LTTabBarItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (obj.bulgeOutEnabled) {
            btn.frame = CGRectMake((self.frame.size.width/[LTTabBarItemBaseHelper displayTabBarItem].count)*idx, -20, self.frame.size.width/[LTTabBarItemBaseHelper displayTabBarItem].count,self.frame.size.height+20);
        }else{
            btn.frame = CGRectMake((self.frame.size.width/[LTTabBarItemBaseHelper displayTabBarItem].count)*idx, 0, self.frame.size.width/[LTTabBarItemBaseHelper displayTabBarItem].count,self.frame.size.height);
        }
        [btn setImage:obj.normalImage forState:UIControlStateNormal];
        [btn setImage:obj.selectImage forState:UIControlStateSelected];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        if (obj.title.length>0) {
           [btn setTitle:obj.title forState:UIControlStateNormal];
        }
        if (obj.itemTitleColorNormal) {
            [btn setTitleColor:obj.itemTitleColorNormal forState:UIControlStateNormal];
        }
        if (obj.itemTitleColorSelect) {
            [btn setTitleColor:obj.itemTitleColorSelect forState:UIControlStateSelected];
        }
        btn.titleEdgeInsets = UIEdgeInsetsMake(0+obj.titleEdgeInsets.top, -btn.imageView.frame.size.width+obj.titleEdgeInsets.left, -btn.imageView.frame.size.height-0+obj.titleEdgeInsets.bottom, 0+obj.titleEdgeInsets.right);
        btn.imageEdgeInsets = UIEdgeInsetsMake( -btn.titleLabel.frame.size.height-0+obj.imageEdgeInsets.top,0+obj.imageEdgeInsets.left, 0+obj.imageEdgeInsets.bottom, -btn.titleLabel.frame.size.width+obj.imageEdgeInsets.right);
        [self addSubview:btn];
        [itemsArray addObject:btn];
        if (obj.isShowMessageBubble) {
            UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [messageBtn setBackgroundImage:[UIImage imageNamed:@"ZhaiXin_Cell_Unread_Ellipse"] forState:UIControlStateNormal];
            messageBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            messageBtn.hidden = YES;
            [messageBtn sizeToFit];
            [btn addSubview:messageBtn];
            [messageArray addObject:messageBtn];
        }
    }];
    _tabBarItems = [itemsArray copy];
    _messageItems = [messageArray copy];
}

- (void)reloadItem{
    [_messageItems enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [_tabBarItems enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    _messageItems = nil;
    _tabBarItems = nil;
    [self creatTabBarItem];
}

- (void)refreshMessageFrame{
    for (UIButton *btn in _messageItems) {
        [btn sizeToFit];
        UIButton *itemBtn = (UIButton *)[btn superview];
        btn.frame = CGRectMake(itemBtn.frame.size.width/2+20-btn.frame.size.width/2, itemBtn.frame.size.height/2-btn.frame.size.height/2-8, btn.frame.size.width, btn.frame.size.height);
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

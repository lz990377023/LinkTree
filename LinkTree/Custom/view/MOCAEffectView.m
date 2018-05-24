//
//  MOCAEffectView.m
//  LinkTree
//
//  Created by 李沾 on 2018/5/25.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "MOCAEffectView.h"

@interface MOCAEffectView()
@property (nonatomic ,strong) UIBlurEffect *blurEffect;
@property (nonatomic ,strong) UIVisualEffectView *effectView;
@end

@implementation MOCAEffectView


- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame blurStyle:MOCABlurEffectStyleLight];
}

- (instancetype)initWithFrame:(CGRect)frame blurStyle:(MOCABlurEffectStyle)blurStyle{
    self = [super initWithFrame:frame];
    if (self) {
        _blurStyle = blurStyle;
        [self initBlurEffect];
        [self initEffectView];
    }
    return self;
}

- (void)initBlurEffect{
    switch (_blurStyle) {
        case MOCABlurEffectStyleExtraLight:{
            _blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        }break;
        case MOCABlurEffectStyleLight:{
            _blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        }break;
        case MOCABlurEffectStyleDark:{
            _blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        }break;
    }
}

- (void)initEffectView{
    _effectView = [[UIVisualEffectView alloc]initWithEffect:_blurEffect];
    [self addSubview:_effectView];
    @lt_weakify(self)
    [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weak_self.mas_left);
        make.bottom.equalTo(weak_self.mas_bottom);
        make.right.equalTo(weak_self.mas_right);
        make.top.equalTo(weak_self.mas_top);
    }];
}

- (void)setBlurStyle:(MOCABlurEffectStyle)blurStyle{
    [self initBlurEffect];
    _effectView.effect = _blurEffect;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

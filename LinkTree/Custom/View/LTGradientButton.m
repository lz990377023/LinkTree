//
//  LTGradientButton.m
//  LinkTree
//
//  Created by 李沾 on 2018/5/2.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "LTGradientButton.h"
#import "LinkTree.h"
@implementation LTGradientButton


- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor lt_gradientColorFromColor:LT_HEX_COLOR(@"#6950FB") toColor:LT_HEX_COLOR(@"#B83AF3") withSize:self.frame.size];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

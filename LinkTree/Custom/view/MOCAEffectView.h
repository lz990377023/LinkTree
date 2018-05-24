//
//  MOCAEffectView.h
//  LinkTree
//
//  Created by 李沾 on 2018/5/25.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,MOCABlurEffectStyle){
    MOCABlurEffectStyleExtraLight,
    MOCABlurEffectStyleLight,
    MOCABlurEffectStyleDark,
};

@interface MOCAEffectView : UIView
@property (nonatomic ,assign) MOCABlurEffectStyle blurStyle;
- (instancetype)initWithFrame:(CGRect)frame blurStyle:(MOCABlurEffectStyle)blurStyle;
@end

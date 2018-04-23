//
//  LTUIHelper.h
//  LinkTree
//
//  Created by lizhan on 2018/4/10.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTUIHelper : NSObject
+ (instancetype _Nonnull)shareInstance;

/// 获取一像素的大小
+ (CGFloat)lt_pixelOne;

//判断屏幕尺寸
+ (BOOL)lt_is58InchScreen;
+ (BOOL)lt_is55InchScreen;
+ (BOOL)lt_is47InchScreen;
+ (BOOL)lt_is40InchScreen;
+ (BOOL)lt_is35InchScreen;

//获取屏幕尺寸大小
+ (CGSize)lt_screenSizeFor58Inch;
+ (CGSize)lt_screenSizeFor55Inch;
+ (CGSize)lt_screenSizeFor47Inch;
+ (CGSize)lt_screenSizeFor40Inch;
+ (CGSize)lt_screenSizeFor35Inch;

// 获取 iPhoneX 安全区域的 insets
+ (UIEdgeInsets)lt_safeAreaInsetsForIPhoneX;


/**
 *  @param speaker   是否转为扬声器，NO则听筒
 *  @param temporary 决定使用kAudioSessionProperty_OverrideAudioRoute还是kAudioSessionProperty_OverrideCategoryDefaultToSpeaker
 */
+ (void)lt_redirectAudioRouteWithSpeaker:(BOOL)speaker temporary:(BOOL)temporary;

@end

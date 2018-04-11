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
+ (CGFloat)pixelOne;

//判断屏幕尺寸
+ (BOOL)is58InchScreen;
+ (BOOL)is55InchScreen;
+ (BOOL)is47InchScreen;
+ (BOOL)is40InchScreen;
+ (BOOL)is35InchScreen;

//获取屏幕尺寸大小
+ (CGSize)screenSizeFor58Inch;
+ (CGSize)screenSizeFor55Inch;
+ (CGSize)screenSizeFor47Inch;
+ (CGSize)screenSizeFor40Inch;
+ (CGSize)screenSizeFor35Inch;

// 获取 iPhoneX 安全区域的 insets
+ (UIEdgeInsets)safeAreaInsetsForIPhoneX;


/**
 *  @param speaker   是否转为扬声器，NO则听筒
 *  @param temporary 决定使用kAudioSessionProperty_OverrideAudioRoute还是kAudioSessionProperty_OverrideCategoryDefaultToSpeaker
 */
+ (void)redirectAudioRouteWithSpeaker:(BOOL)speaker temporary:(BOOL)temporary;

@end

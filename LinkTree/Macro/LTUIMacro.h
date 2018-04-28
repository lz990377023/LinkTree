//
//  LTUIMacro.h
//  LinkTree
//
//  Created by lizhan on 2018/4/8.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#ifndef LTUIMacro_h
#define LTUIMacro_h


// 是否Retina
#define IS_RETINASCREEN ([[UIScreen mainScreen] scale] >= 2.0)

// 是否放大模式（iPhone 6及以上的设备支持放大模式）
#define IS_ZOOMEDMODE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeScale)] ? (ScreenNativeScale > ScreenScale) : NO)

// 是否横竖屏(用户界面横屏了才会返回YES)
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])

// 屏幕宽度，会根据横竖屏的变化而变化
#define LT_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

// 屏幕高度，会根据横竖屏的变化而变化
#define LT_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

// 屏幕宽度，跟横竖屏无关
#define LT_DEVICE_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

// 屏幕高度，跟横竖屏无关
#define LT_DEVICE_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

// 状态栏高度
#define LT_StatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)

// navigationBar相关frame
#define LT_NavigationBarHeight (IS_LANDSCAPE ? PreferredVarForDevices(44, 32, 32, 32) : 44)

// 获取一个像素
#define LT_PixelOne 1 / [[UIScreen mainScreen] scale]

#define LT_FontSize(size) [UIFont systemFontOfSize:size]
#define LT_FontBoldSize(size) [UIFont boldSystemFontOfSize:size]

#define LT_ColorWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]


#endif /* LTUIMacro_h */
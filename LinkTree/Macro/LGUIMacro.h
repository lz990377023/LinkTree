//
//  LGUIMacro.h
//  LinkTree
//
//  Created by lizhan on 2018/4/8.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#ifndef LGUIMacro_h
#define LGUIMacro_h

// 设备屏幕尺寸
// iPhoneX
#define IS_58INCH_SCREEN CGSizeMake(375, 812);
// iPhone6/7/8 Plus
#define IS_55INCH_SCREEN CGSizeMake(414, 736);
// iPhone6/7/8
#define IS_47INCH_SCREEN CGSizeMake(375, 667);
// iPhone5/5s/SE
#define IS_40INCH_SCREEN CGSizeMake(320, 568);
// iPhone4/4s
#define IS_35INCH_SCREEN CGSizeMake(320, 480);

// 是否Retina
#define IS_RETINASCREEN ([[UIScreen mainScreen] scale] >= 2.0)

// 是否放大模式（iPhone 6及以上的设备支持放大模式）
#define IS_ZOOMEDMODE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeScale)] ? (ScreenNativeScale > ScreenScale) : NO)

// 是否横竖屏
// 用户界面横屏了才会返回YES
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])

// 状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算)
#define LG_StatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)

// navigationBar相关frame
#define LG_NavigationBarHeight (IS_LANDSCAPE ? PreferredVarForDevices(44, 32, 32, 32) : 44)

// 获取一个像素
#define LG_PixelOne 1 / [[UIScreen mainScreen] scale]

#define LG_FontSize(size) [UIFont systemFontOfSize:size]
#define LG_FontBoldSize(size) [UIFont boldSystemFontOfSize:size]

#define LG_ColorWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]


#endif /* LGUIMacro_h */

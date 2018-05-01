//
//  LTUIHelper.m
//  LinkTree
//
//  Created by lizhan on 2018/4/10.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "LTUIHelper.h"
#import "LTUIMacro.h"
#import <AVFoundation/AVFoundation.h>
@implementation  LTUIHelper
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static LTUIHelper *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self shareInstance];
}

+ (CGFloat)lt_pixelOne{
    return 1 / [[UIScreen mainScreen] scale];
}

static NSInteger is58InchScreen = -1;
+ (BOOL)lt_is58InchScreen {
    if (is58InchScreen < 0) {
        is58InchScreen = (LT_DEVICE_WIDTH == self.lt_screenSizeFor58Inch.width && LT_DEVICE_WIDTH == self.lt_screenSizeFor58Inch.height) ? 1 : 0;
    }
    return is58InchScreen > 0;
}

static NSInteger is55InchScreen = -1;
+ (BOOL)lt_is55InchScreen {
    if (is55InchScreen < 0) {
        is55InchScreen = (LT_DEVICE_WIDTH == self.lt_screenSizeFor55Inch.width && LT_DEVICE_WIDTH == self.lt_screenSizeFor55Inch.height) ? 1 : 0;
    }
    return is55InchScreen > 0;
}

static NSInteger is47InchScreen = -1;
+ (BOOL)lt_is47InchScreen {
    if (is47InchScreen < 0) {
        is47InchScreen = (LT_DEVICE_WIDTH == self.lt_screenSizeFor47Inch.width && LT_DEVICE_WIDTH == self.lt_screenSizeFor47Inch.height) ? 1 : 0;
    }
    return is47InchScreen > 0;
}

static NSInteger is40InchScreen = -1;
+ (BOOL)lt_is40InchScreen {
    if (is40InchScreen < 0) {
        is40InchScreen = (LT_DEVICE_WIDTH == self.lt_screenSizeFor40Inch.width && LT_DEVICE_WIDTH == self.lt_screenSizeFor40Inch.height) ? 1 : 0;
    }
    return is40InchScreen > 0;
}

static NSInteger is35InchScreen = -1;
+ (BOOL)lt_is35InchScreen {
    if (is35InchScreen < 0) {
        is35InchScreen = (LT_DEVICE_WIDTH == self.lt_screenSizeFor35Inch.width && LT_DEVICE_WIDTH == self.lt_screenSizeFor35Inch.height) ? 1 : 0;
    }
    return is35InchScreen > 0;
}

+ (CGSize)lt_screenSizeFor58Inch {
    return CGSizeMake(375, 812);
}

+ (CGSize)lt_screenSizeFor55Inch {
    return CGSizeMake(414, 736);
}

+ (CGSize)lt_screenSizeFor47Inch {
    return CGSizeMake(375, 667);
}

+ (CGSize)lt_screenSizeFor40Inch {
    return CGSizeMake(320, 568);
}

+ (CGSize)lt_screenSizeFor35Inch {
    return CGSizeMake(320, 480);
}

+ (UIEdgeInsets)lt_safeAreaInsetsForIPhoneX {
    if (![self lt_is58InchScreen]) {
        return UIEdgeInsetsZero;
    }
    if (@available(iOS 11.0, *)){
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
    
//    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
//
//    switch (orientation) {
//        case UIInterfaceOrientationPortrait:
//            return UIEdgeInsetsMake(44, 0, 34, 0);
//
//        case UIInterfaceOrientationPortraitUpsideDown:
//            return UIEdgeInsetsMake(34, 0, 44, 0);
//
//        case UIInterfaceOrientationLandscapeLeft:
//        case UIInterfaceOrientationLandscapeRight:
//            return UIEdgeInsetsMake(0, 44, 21, 44);
//
//        case UIInterfaceOrientationUnknown:
//        default:
//            return UIEdgeInsetsMake(44, 0, 34, 0);
//    }
}

+ (void)lt_redirectAudioRouteWithSpeaker:(BOOL)speaker temporary:(BOOL)temporary {
    if (![[AVAudioSession sharedInstance].category isEqualToString:AVAudioSessionCategoryPlayAndRecord]) {
        return;
    }
    if (temporary) {
        [[AVAudioSession sharedInstance] overrideOutputAudioPort:speaker ? AVAudioSessionPortOverrideSpeaker : AVAudioSessionPortOverrideNone error:nil];
    } else {
        [[AVAudioSession sharedInstance] setCategory:[AVAudioSession sharedInstance].category withOptions:speaker ? AVAudioSessionCategoryOptionDefaultToSpeaker : 0 error:nil];
    }
}



@end

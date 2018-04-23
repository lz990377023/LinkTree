//
//  UIColor+LTExtension.h
//  LinkTree
//
//  Created by 李沾 on 2018/4/17.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LTExtension)

// 返回使用rgb（0-255）参数生成的颜色
+ (UIColor *)lt_colorFromRGBColorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;

// 返回使用rgb（0-255）a（0-1）参数生成的颜色
+ (UIColor *)lt_colorFromRGBAColorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;

/**
 * 使用HEX命名方式的颜色生成一个UIColor对象
 * @param rgb 例（0xc5c5c5）
 * @alpha 透明度
 * @return UIColor对象
 */
+ (UIColor *)lt_colorFromHex:(NSUInteger)rgb alpha:(CGFloat)alpha;
+ (UIColor *)lt_colorFromHex:(NSUInteger)rgb;

/**
 * 使用HEX命名方式的字符串颜色生成一个UIColor对象
 * @param hex 例（@"#c5c5c5"）
 * @alpha 透明度
 * @return UIColor对象
 */
+ (UIColor *)lt_colorWithHexString:(NSString *)hex;

//随机颜色
+ (UIColor *)lt_randomColor;

// 返回当前颜色的16进制字符串
- (NSString *)lt_hexString;

@end

@interface UIColor (LTColor)

// 获取当前UIColor对象里的红色色值（0.0-1.0）
- (CGFloat)lt_redValue;

// 获取当前UIColor对象里的绿色色值（0.0-1.0）
- (CGFloat)lt_greenValue;

// 获取当前UIColor对象里的蓝色色值（0.0-1.0）
- (CGFloat)lt_blueValue;

// 获取当前UIColor对象里的透明色值（0.0-1.0）
- (CGFloat)lt_alphaValue;

// 获取当前UIColor对象里的hue（色相）
- (CGFloat)lt_hueValue;

// 获取当前UIColor对象里的saturation（饱和度）
- (CGFloat)lt_saturationValue;

// 获取当前UIColor对象里的brightness（亮度）
- (CGFloat)lt_brightnessValue;

// 判断当前颜色是否为深色（“YES”为深色）
- (BOOL)lt_colorIsDark;

@end

@interface UIColor (LTGradient)

/**
 *  颜色渐变
 *  @param toColor 目标颜色
 *  @param progress 变化程度，取值范围0.0f~1.0f
 */
- (UIColor *)lt_transitionToColor:(UIColor *)toColor progress:(CGFloat)progress;

/**
 *  颜色渐变
 *  @param fromColor 起始颜色
 *  @param toColor 目标颜色
 *  @param size 变化颜色size
 */
+ (UIColor *)lt_gradientColorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor withSize:(CGSize)size;

/**
 *  将颜色A渐变
 *  @param fromColor 起始颜色
 *  @param toColor 目标颜色
 *  @param progress 变化程度，取值范围0.0f~1.0f
 */
+ (UIColor *)lt_gradientColorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress;

@end



//
//  UIColor+LTExtension.m
//  LinkTree
//
//  Created by 李沾 on 2018/4/17.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import "UIColor+LTExtension.h"

@implementation UIColor (LTExtension)


+ (UIColor *)lt_colorFromRGBColorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b {
    return [self lt_colorFromRGBAColorWithRed:r green:g blue:b alpha:1.0];
}

+ (UIColor *)lt_colorFromRGBAColorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a {
    return [UIColor colorWithRed: r/255.0 green: g/255.0 blue: b/255.0 alpha:a];
}

+ (UIColor *)lt_colorFromHex:(NSUInteger)rgb {
    return [UIColor lt_colorFromHex:rgb alpha:1.0];
}

+ (UIColor *)lt_colorFromHex:(NSUInteger)rgb alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0
                           green:((float)((rgb & 0xFF00) >> 8))/255.0
                            blue:((float)(rgb & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)lt_colorWithHexString:(NSString *)hex {
    if ([hex length]!=6 && [hex length]!=3){return nil;}
    
    NSUInteger lt_digits = [hex length]/3;
    CGFloat lt_maxValue = (lt_digits==1)?15.0:255.0;
    
    CGFloat (^hexStringToFloat)(NSString *string) = ^CGFloat(NSString *string) {
        unsigned long lt_result = 0;
        sscanf([string UTF8String], "%lx", &lt_result);
        return lt_result/lt_maxValue;
    };
    
    CGFloat lt_redValue = hexStringToFloat([hex substringWithRange:NSMakeRange(0, lt_digits)]);
    CGFloat lt_greenValue = hexStringToFloat([hex substringWithRange:NSMakeRange(lt_digits, lt_digits)]);
    CGFloat lt_blueValue = hexStringToFloat([hex substringWithRange:NSMakeRange(2*lt_digits, lt_digits)]);
    
    return [UIColor colorWithRed:lt_redValue green:lt_greenValue blue:lt_blueValue alpha:1.0];
}


+ (UIColor *)lt_randomColor {
    NSInteger lt_redValue = arc4random() % 255;
    NSInteger lt_greenValue = arc4random() % 255;
    NSInteger lt_blueValue = arc4random() % 255;
    return [self lt_colorFromRGBAColorWithRed:lt_redValue green:lt_greenValue blue:lt_blueValue alpha:1];
}

- (NSString *)lt_hexString {
    
    NSString *lt_webColor = nil;
    
    size_t componentCount = CGColorGetNumberOfComponents(self.CGColor);
    
    // RGBA colors
    if (componentCount == 4)
    {
        // Get the red, green and blue components
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        
        // These components range from 0.0 till 1.0 and need to be converted to 0 till 255
        CGFloat lt_redValue = roundf(components[0] * 255.0);
        CGFloat lt_greenValue = roundf(components[1] * 255.0);
        CGFloat lt_blueValue = roundf(components[2] * 255.0);
        
        // Convert with %02x (use 02 to always get two chars)
        lt_webColor = [NSString stringWithFormat:@"%02lx%02lx%02lx", (long)lt_redValue, (long)lt_greenValue, (long)lt_blueValue];
    } else if (componentCount == 2) {   // Greyscale colors
        // Get the white and alpha components
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        
        // Same as above, but only using a single component
        CGFloat white = roundf(components[0] * 255.0);
        
        lt_webColor = [NSString stringWithFormat:@"%02lx%02lx%02lx", (long)white, (long)white, (long)white];
    }
    
    return lt_webColor;
}


@end

@implementation UIColor (LTColor)

- (CGFloat)lt_redValue {
    CGFloat r;
    if ([self getRed:&r green:0 blue:0 alpha:0]) {
        return r;
    }
    return 0.f;
}

- (CGFloat)lt_greenValue {
    CGFloat g;
    if ([self getRed:0 green:&g blue:0 alpha:0]) {
        return g;
    }
    return 0.f;
}

- (CGFloat)lt_blueValue {
    CGFloat b;
    if ([self getRed:0 green:0 blue:&b alpha:0]) {
        return b;
    }
    return 0.f;
}

- (CGFloat)lt_alphaValue {
    CGFloat a;
    if ([self getRed:0 green:0 blue:0 alpha:&a]) {
        return a;
    }
    return 0.f;
}

- (CGFloat)lt_hueValue {
    CGFloat h;
    if ([self getHue:&h saturation:0 brightness:0 alpha:0]) {
        return h;
    }
    return 0.f;
}

- (CGFloat)lt_saturationValue {
    CGFloat s;
    if ([self getHue:0 saturation:&s brightness:0 alpha:0]) {
        return s;
    }
    return 0.f;
}

- (CGFloat)lt_brightnessValue {
    CGFloat b;
    if ([self getHue:0 saturation:0 brightness:&b alpha:0]) {
        return b;
    }
    return 0.f;
}

- (BOOL)lt_colorIsDark {
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    float referenceValue = 0.411;
    float colorDelta = ((red * 0.299) + (green * 0.587) + (blue * 0.114));
    return 1.0 - colorDelta > referenceValue;
}

@end


@implementation UIColor (LTGradient)

- (UIColor *)lt_transitionToColor:(UIColor *)toColor progress:(CGFloat)progress {
    return [UIColor lt_gradientColorFromColor:self toColor:toColor progress:progress];
}

+ (UIColor *)lt_gradientColorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor withSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef lt_context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef lt_colorspace = CGColorSpaceCreateDeviceRGB();
    
    NSArray* lt_colors = [NSArray arrayWithObjects:(id)fromColor.CGColor, (id)toColor.CGColor, nil];
    CGGradientRef lt_gradient = CGGradientCreateWithColors(lt_colorspace, (__bridge CFArrayRef)lt_colors, NULL);
    CGContextDrawLinearGradient(lt_context, lt_gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
    UIImage *lt_image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(lt_gradient);
    CGColorSpaceRelease(lt_colorspace);
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:lt_image];
}

+ (UIColor *)lt_gradientColorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress {
    progress = MIN(progress, 1.0f);
    CGFloat fromRed = fromColor.lt_redValue;
    CGFloat fromGreen = fromColor.lt_greenValue;
    CGFloat fromBlue = fromColor.lt_blueValue;
    CGFloat fromAlpha = fromColor.lt_alphaValue;
    
    CGFloat toRed = toColor.lt_redValue;
    CGFloat toGreen = toColor.lt_greenValue;
    CGFloat toBlue = toColor.lt_blueValue;
    CGFloat toAlpha = toColor.lt_alphaValue;
    
    CGFloat finalRed = fromRed + (toRed - fromRed) * progress;
    CGFloat finalGreen = fromGreen + (toGreen - fromGreen) * progress;
    CGFloat finalBlue = fromBlue + (toBlue - fromBlue) * progress;
    CGFloat finalAlpha = fromAlpha + (toAlpha - fromAlpha) * progress;
    
    return [UIColor colorWithRed:finalRed green:finalGreen blue:finalBlue alpha:finalAlpha];
}


@end


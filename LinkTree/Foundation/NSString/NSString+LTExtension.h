//
//  NSString+LTExtension.h
//  LinkTree
//
//  Created by lizhan on 2018/4/3.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface NSString (LTExtension)

// 判断是否为空字符串
- (BOOL)lt_isNullString;

// 手机号码的有效性:分电信、联通、移动和小灵通
- (BOOL)lt_isMobileNumberClassificationVerify;

// 手机号有效性验证
- (BOOL)lt_isMobileNumberVerify;

// 邮箱的有效性验证
- (BOOL)lt_isEmailAddressVerify;

// 简单的身份证有效性验证
- (BOOL)lt_isIdentityCardVerify;

/**
 *  精确的身份证号码有效性验证
 *
 *  @param number 身份证号
 */
+ (BOOL)lt_identityCardVerifyWithNumber:(NSString *)number;

// 车牌号的有效性验证
- (BOOL)lt_isCarNumberVerify;

// 银行卡的有效性验证
- (BOOL)lt_bankCardVerify;

// IP地址有效性验证
- (BOOL)lt_isIPAddressVerify;

// Mac地址有效性验证
- (BOOL)lt_isMacAddressVerify;

// 网址有效性验证
- (BOOL)lt_isValidUrlVerify;

// 纯汉字验证
- (BOOL)lt_isValidChineseVerify;

// 邮政编码验证
- (BOOL)lt_isValidPostalcodeVerify;

// 工商税号验证
- (BOOL)lt_isValidTaxNoVerify;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)lt_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)lt_isValidWithMinLenth:(NSInteger)minLenth
                      maxLenth:(NSInteger)maxLenth
                containChinese:(BOOL)containChinese
                 containDigtal:(BOOL)containDigtal
                 containLetter:(BOOL)containLetter
         containOtherCharacter:(NSString *)containOtherCharacter
           firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;


@end

@interface NSString (LTBase64)

+ (NSString *)lt_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)lt_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)lt_base64EncodedString;
- (NSString *)lt_base64DecodedString;
- (NSData *)lt_base64DecodedData;


@end

//
//  NSData+LTExtension.h
//  LinkTree
//
//  Created by lizhan on 2018/4/3.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (LTExtension)

@end

@interface NSData (LTBase64)

/**
 *  @brief  字符串base64后转data
 *
 *  @param string 传入字符串
 *
 *  @return 传入字符串 base64后的data
 */
+ (NSData *)lt_dataWithBase64EncodedString:(NSString *)string;
/**
 *  @brief  NSData转string
 *
 *  @param wrapWidth 换行长度  76  64
 *
 *  @return base64后的字符串
 */
- (NSString *)lt_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
/**
 *  @brief  NSData转string 换行长度默认64
 *
 *  @return base64后的字符串
 */
- (NSString *)lt_base64EncodedString;

@end

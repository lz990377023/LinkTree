//
//  UIDevice+LTExtension.h
//  LinkTree
//
//  Created by 李沾 on 2018/5/26.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (LTExtension)
+ (NSString *)lt_platform;
+ (NSString *)lt_platformString;


+ (NSString *)lt_macAddress;

//Return the current device CPU frequency
+ (NSUInteger)lt_cpuFrequency;
// Return the current device BUS frequency
+ (NSUInteger)lt_busFrequency;
//current device RAM size
+ (NSUInteger)lt_ramSize;
//Return the current device CPU number
+ (NSUInteger)lt_cpuNumber;
//Return the current device total memory

/// 获取iOS系统的版本号
+ (NSString *)lt_systemVersion;
/// 判断当前系统是否有摄像头
+ (BOOL)lt_hasCamera;
/// 获取手机内存总量, 返回的是字节数
+ (NSUInteger)lt_totalMemoryBytes;
/// 获取手机可用内存, 返回的是字节数
+ (NSUInteger)lt_freeMemoryBytes;

/// 获取手机硬盘空闲空间, 返回的是字节数
+ (long long)lt_freeDiskSpaceBytes;
/// 获取手机硬盘总空间, 返回的是字节数
+ (long long)lt_totalDiskSpaceBytes;
@end

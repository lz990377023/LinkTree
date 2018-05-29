//
//  LTMainMacro.h
//  LinkTree
//
//  Created by lizhan on 2018/4/8.
//  Copyright © 2018年 lizhan. All rights reserved.
//

#ifndef LTMainMacro_h
#define LTMainMacro_h

//弱引用
#ifndef lt_weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define lt_weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define lt_weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define lt_weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define lt_weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef lt_strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define lt_strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define lt_strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define lt_strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define lt_strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

// 判断当前是否debug编译模式
#ifdef DEBUG
#define IS_DEBUG YES
#else
#define IS_DEBUG NO
#endif

// 操作系统版本号，只获取第二级的版本号，例如 10.3.1 只会得到 10.3
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] doubleValue])

#pragma mark --------LocalString

// 语言种类
#define LT_APP_LANGUAGE_FOR_CHINESE       @"Chinese"       //中文
#define LT_APP_LANGUAGE_FOR_CHINESE_TRAD      @"Chinese_Traditional"       //繁体中文
#define LT_APP_LANGUAGE_FOR_ENGLISH     @"English"      //英语

// 如果要通过宏直接设置语言 则将APP_LANGUAGE_XXXXX的宏替代PLIST_DICT_GET_OBJECT(LANGUAGE_CORE_KEY)
#define LTLocalForKey(key) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:LT_APP_LANGUAGE_FOR_CHINESE]

#define LT_PUBLIC_PKG @"mocajiaoyou"




#endif /* LTMainMacro_h */

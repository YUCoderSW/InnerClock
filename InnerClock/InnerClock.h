//
//  InnerClock.h
//  vsfa
//
//  Created by admin on 15/10/12.
//  Copyright © 2015年 AZYK. All rights reserved.
//

/**
 * 保存到数据库的时间格式：yyyy-MM-dd HH:mm:ss fff（2013-01-10 16:24:33 367）
 */
#define PATTERN_DB @"yyyy-MM-dd HH:mm:ss SSS"
#define PATTERN_YMDHMS @"yyyy-MM-dd HH:mm:ss"
#define PATTERN_YMDHMSS @"yyyyMMddHHmmss"
#define PATTERN_YMDHM @"yyyy年MM月dd日 HH:mm"
#define PATTERN_SHOW_YMDHMS @"yyyy年MM月dd日 HH:mm:ss"
#define PATTERN_YMD @"yyyy年MM月dd日"
#define PATTERN_HM @"HH:mm"
#define PATTERN_YMD2 @"yyyy-M-d"
#define PATTERN_YMD3 @"yyyy-MM-dd"
#define PATTERN_YMDHMSSSS @"yyyy-MM-dd HH:mm:ss.S"
#define PATTERN_YMDHM_ALL @"yyyy-MM-dd HH:mm:ss.SSS"

#import <Foundation/Foundation.h>

@interface InnerClock : NSObject

/**
 *  存储服务器时间及待机时长
 *
 *  @param serverTime 服务器时间
 */
+ (void)firstTimeWithLogin:(NSString *)serverTime;

/**
 *  获取当前时间，以服务器时间为基准
 */
+ (NSDate *)dateOfNow;

/**
 *  存储开机时间
 */
+ (void)savaBootTime;

/**
 *  是否重启手机
 */
+ (BOOL)isSyetemReBoot;

/**
 *  根据传人的格式返回当前日期
 */
+ (NSString *)formatWithDate:(NSString *)date;


@end

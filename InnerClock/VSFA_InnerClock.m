//
//  VSFA_InnerClock.m
//  vsfa
//
//  Created by admin on 15/10/12.
//  Copyright © 2015年 AZYK. All rights reserved.
//

#import "VSFA_InnerClock.h"


@implementation VSFA_InnerClock

+ (NSString *)getCurrentDate_PATTERN_DB
{
    return [InnerClock formatWithDate:PATTERN_DB];
}

+ (NSString *)getCurrentDate_PATTERN_YMDHMS
{
    return [InnerClock formatWithDate:PATTERN_YMDHMS];
}

+ (NSString *)getCurrentDate_PATTERN_YMDHMSS
{
    return [InnerClock formatWithDate:PATTERN_YMDHMSS];
}

+ (NSString *)getCurrentDate_PATTERN_YMDHM
{
    return [InnerClock formatWithDate:PATTERN_YMDHM];
}

+ (NSString *)getCurrentDate_PATTERN_SHOW_YMDHMS
{
    return [InnerClock formatWithDate:PATTERN_SHOW_YMDHMS];
}

+ (NSString *)getCurrentDate_PATTERN_YMD
{
    return [InnerClock formatWithDate:PATTERN_YMD];
}

+ (NSString *)getCurrentDate_PATTERN_HM
{
    return [InnerClock formatWithDate:PATTERN_HM];
}

+ (NSString *)getCurrentDate_PATTERN_YMD2
{
    return [InnerClock formatWithDate:PATTERN_YMD2];
}

+ (NSString *)getCurrentDate_PATTERN_YMD3
{
    return [InnerClock formatWithDate:PATTERN_YMD3];
}

+ (NSString *)getCurrentDate_PATTERN_YMDHMSSSS
{
    return [InnerClock formatWithDate:PATTERN_YMDHMSSSS];
}

+ (NSString *)getCurrentDate_PATTERN_YMDHM_ALL
{
    return [InnerClock formatWithDate:PATTERN_YMDHM_ALL];
}

@end

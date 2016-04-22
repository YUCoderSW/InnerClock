//
//  VSFA_InnerClock.h
//  vsfa
//
//  Created by admin on 15/10/12.
//  Copyright © 2015年 AZYK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InnerClock.h"
@interface VSFA_InnerClock : NSObject

+ (NSString *)getCurrentDate_PATTERN_DB;

+ (NSString *)getCurrentDate_PATTERN_YMDHMS;

+ (NSString *)getCurrentDate_PATTERN_YMDHMSS;

+ (NSString *)getCurrentDate_PATTERN_YMDHM;

+ (NSString *)getCurrentDate_PATTERN_SHOW_YMDHMS;

+ (NSString *)getCurrentDate_PATTERN_YMD;

+ (NSString *)getCurrentDate_PATTERN_HM;

+ (NSString *)getCurrentDate_PATTERN_YMD2;

+ (NSString *)getCurrentDate_PATTERN_YMD3;

+ (NSString *)getCurrentDate_PATTERN_YMDHMSSSS;

+ (NSString *)getCurrentDate_PATTERN_YMDHM_ALL;

@end

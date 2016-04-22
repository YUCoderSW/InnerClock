//
//  InnerClock.m
//  vsfa
//
//  Created by admin on 15/10/12.
//  Copyright © 2015年 AZYK. All rights reserved.
//

//开机时间
#define SWStartTime  @"startTime"

//服务器时间
#define SWServerTime @"serverTime"

//登录时的待机时长
#define SWSinceNow @"sinceNow"


#import "InnerClock.h"
#include <sys/sysctl.h>

@implementation InnerClock


/**
 *  待机时间（从系统启动的那一刻开始获取的时间间隔）
 */
+ (double)uptime
{
    struct timeval boottime;
    struct timeval nowusec;
    
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    
    size_t size = sizeof(boottime);
    
    time_t now;
    
    time_t uptime = -1;
    
    (void)time(&now);
    
    gettimeofday(&nowusec, NULL);
    int usec = nowusec.tv_usec;
    
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0)
        
    {    
        uptime = now - boottime.tv_sec ;
        
    }
    
    double result = uptime + 0.000001*usec;
    
    
    return result;
    
}

/**
 *  存储服务器时间及待机时长
 *
 *  @param serverTime 服务器时间
 */
+ (void)firstTimeWithLogin:(NSString *)serverTime
{
    NSTimeInterval timer = [self uptime];
    NSString *sinceNow = [NSString stringWithFormat:@"%f",timer];
    
    NSUserDefaults *UserDefaults = [NSUserDefaults standardUserDefaults];
    //存储登录时获取的服务器时间
    [UserDefaults setObject:serverTime forKey:SWServerTime];
    //存储登录时获取的待机时长
    [UserDefaults setObject:sinceNow forKey:SWSinceNow];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/**
 *  获取当前时间，以服务器时间为基准
 */
+ (NSDate *)dateOfNow
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:PATTERN_DB];
    NSUserDefaults *UserDefaults = [NSUserDefaults standardUserDefaults];
    //取出登录时获取的服务器时间
    NSString * serverText = [UserDefaults objectForKey:SWServerTime];
    NSDate *FirstServer = [formatter dateFromString:serverText];
    
    NSString *firstText = [UserDefaults objectForKey:SWSinceNow];
    double first = firstText.doubleValue;
    NSTimeInterval timer = [self uptime];
    
    //差值
    CGFloat finaly;
    if (first) {
        finaly = timer - first;
    }else
    {
        finaly = 0;
    }
    
    NSTimeInterval interval = (NSTimeInterval)finaly;
    //最后的时间
    NSDate *finalyDate = [FirstServer dateByAddingTimeInterval:interval];
    if (finaly>0) {
        return finalyDate;
    }else
    {
        return [NSDate date];
    }
    
}


/**
 *  获得开机时间
 */
+ (NSString *)getUpTime{
    NSString * proc_useTiem;
    //指定名字参数，按照顺序第一个元素指定本请求定向到内核的哪个子系统，第二个及其后元素依次细化指定该系统的某个部分。
    //CTL_KERN，KERN_PROC,KERN_PROC_ALL 正在运行的所有进程
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_PID, 0};
    size_t miblen = 4;
    //值-结果参数：函数被调用时，size指向的值指定该缓冲区的大小；函数返回时，该值给出内核存放在该缓冲区中的数据量
    //如果这个缓冲不够大，函数就返回ENOMEM错误
    size_t size;
    //返回0，成功；返回-1，失败
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    do
    {
        size += size / 10;
        newprocess = realloc(process, size);
        if (!newprocess)
        {
            if (process)
            {
                free(process);
                process = NULL;
            }
            return nil;
        }
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
        
    }
    while (st == -1 && errno == ENOMEM);
    if (st == 0)
    {
        if (size % sizeof(struct kinfo_proc) == 0)
        {
            int nprocess = size / sizeof(struct kinfo_proc);
            if (nprocess)
            {
                for (int i = nprocess - 1; i >= 0; i--)
                {
                    @autoreleasepool{
                        
                        //the process duration
                        double t = process->kp_proc.p_un.__p_starttime.tv_sec;
                        double s = process->kp_proc.p_un.__p_starttime.tv_usec;
                        double finaly = t + s *0.000001;
                        proc_useTiem = [self timeWithBoot:finaly];
                    }
                    
                }
                free(process);
                process = NULL;
                return proc_useTiem;
                
            }
        }
    }
    return nil;
}



/**
 *  转为具体时间
 */
+ (NSString *)timeWithBoot:(double)interval
{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [format setDateStyle:NSDateFormatterMediumStyle];
    [format setTimeStyle:NSDateFormatterShortStyle];
    //注意先后顺序
    [format setDateFormat:PATTERN_YMDHM_ALL];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString *bootTime = [format stringFromDate:date];
    return bootTime;
}

+ (void)savaBootTime
{
    NSString *startTime = [self getUpTime];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //存储开机时间
    [userDefaults setObject:startTime forKey:SWStartTime];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/**
 *  是否重启手机
 */
+ (BOOL)isSyetemReBoot
{
    //当前开机时间
    NSString *NowBootTime = [self getUpTime];
    //上次开机时间
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lastBootTime = [userDefaults objectForKey:SWStartTime];
    
    return [NowBootTime isEqualToString:lastBootTime];
}

/**
 *  根据传人的格式返回当前日期
 */
+ (NSString *)formatWithDate:(NSString *)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:date];
    return [format stringFromDate:[self dateOfNow]];
}


@end

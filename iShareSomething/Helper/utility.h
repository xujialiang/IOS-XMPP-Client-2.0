//
//  utility.h
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface utility : NSObject

+(NSString *)getCurrentTime;

+(NSDate *)getCurrentTimeFromString:(NSString *)datetime;

+(NSString *)getCurrentTimeFromString2:(NSDate *)datetime;

+(NSString *)getWeakDay:(NSDate *)datetime;

+(int)minusNowDate:(NSDate *)date;

+(NSString *)getmessageTime:(NSDate *)date;

+(UIImage *)imageFromText:(int)count image:(UIImage *)image;

@end

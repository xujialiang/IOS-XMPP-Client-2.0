//
//  utility.m
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "utility.h"

@implementation utility

//获取当前时间
+(NSString *)getCurrentTime{
    
    NSDate *nowUTC = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    return [dateFormatter stringFromDate:nowUTC];
}

//将字符串时间转换为Date类型。 格式:MMM dd, yyyy, h:mm:ss a
+(NSDate *)getCurrentTimeFromString:(NSString *)datetime{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[NSLocale currentLocale]];
    [inputFormatter setDateFormat:@"MMM dd, yyyy, h:mm:ss a"];
    NSDate* inputDate = [inputFormatter dateFromString:datetime];
    return inputDate;
}

//传来的参数，若时间为今天，返回HH:MM
//若时间在7天之内，返回星期几
//若时间大于7天，则返回MM-dd 月-日
+(NSString *)getmessageTime:(NSDate *)date{
    if([self minusNowDate:date]==0){
        return [self getCurrentTimeFromString2:date];
    }
    else if([self minusNowDate:date]>0 && [self minusNowDate:date]<6 ){
        return [self getWeakDay:date];
    }else {
        return [self getCurrentTimeFromString3:date];
    }
    
}

//MM-dd
+(NSString *)getCurrentTimeFromString3:(NSDate *)datetime{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:datetime];
    return currentDateStr;
}

//HH:MM
+(NSString *)getCurrentTimeFromString2:(NSDate *)datetime{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:datetime];
    return currentDateStr;
}

//返回传来的时间是星期几
+(NSString *)getWeakDay:(NSDate *)datetime{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:datetime];
    switch ([comps weekday]) {
        case 1:
            return @"星期天";break;
        case 2:
            return @"星期一";break;
        case 3:
            return @"星期二";break;
        case 4:
            return @"星期三";break;
        case 5:
            return @"星期四";break;
        case 6:
            return @"星期五";break;
        case 7:
            return @"星期六";break;
        default:
            return @"未知";break;
    }
}

//传来的日期和当前时间相隔几天
+(int)minusNowDate:(NSDate *)date{
    NSDate *now=[NSDate date];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date  toDate:now  options:0];
    int days = [comps day];
    return days;
}

//气泡中添加数字，提醒有几条消息
+(UIImage *)imageFromText:(int)count image:(UIImage *)image{
    UIImage *myImage = image;
    NSString *myWatermarkText = [NSString stringWithFormat:@"%d",count];
    UIImage *watermarkedImage = nil;
    
    UIGraphicsBeginImageContext(myImage.size);
    [myImage drawAtPoint: CGPointZero];
    UIColor *redColor=[UIColor whiteColor];
    [redColor set];
    UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:25];
    if(count<10){
        [myWatermarkText drawAtPoint: CGPointMake(22, 10) withFont: font];
    }else if(count<100){
        [myWatermarkText drawAtPoint: CGPointMake(18, 10) withFont: font];
    }else if(count<999){
        [myWatermarkText drawAtPoint: CGPointMake(10, 10) withFont: font];
    }else{
        [@"..." drawAtPoint: CGPointMake(18, 10) withFont: font];
    }
    watermarkedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return watermarkedImage;
}

@end

//
//  ChatHistoryEntity.h
//  iShareSomething
//
//  Created by Elliott on 13-5-29.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatHistoryEntity : NSObject

@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * to;
@property (nonatomic, retain) NSString * isread;

@end

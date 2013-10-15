//
//  ChatSessionEntity.h
//  iShareSomething
//
//  Created by Elliott on 13-5-29.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatSessionEntity : NSObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * lastmsg;
@property (nonatomic, retain) NSDate * time;
@end

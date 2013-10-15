//
//  Message.h
//  iShareSomething
//
//  Created by Elliott on 13-5-27.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

//JID
@property (nonatomic,strong) NSString *from;
@property (nonatomic,strong) NSString *to;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) NSString *isread;
@end

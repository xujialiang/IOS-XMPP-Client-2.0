//
//  XmppHelper+Message.h
//  iShareSomething
//
//  Created by Elliott on 13-5-27.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "XmppHelper.h"
@class Message;
@interface XmppHelper (Message)

//保存最后一条消息
@property (nonatomic,strong) NSMutableDictionary *Messages;


- (void)sendMessage:(Message *)message;


@end

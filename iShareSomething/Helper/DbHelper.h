//
//  DbHelper.h
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChatSessionEntity;
@class ChatHistoryEntity;
@class NewFriendEntity;
@interface DbHelper : NSObject

+(void)Insert:(id)entity;

+(void)Update:(NSString *)jid;

+(NSArray *)Query:(NSString *)entityname predicate:(NSString *)predicate;

+(void)DeleteChatSession:(NSString *)entity predicate:(NSString *)predicate;

+(void)InsertChatSession:(ChatSessionEntity *)entity;
+(void)InsertChatHistory:(ChatHistoryEntity *)entity;
+(void)InsertNewFriend:(NewFriendEntity *)entity;
+(NSInteger)UnReadMsgCount;
@end

//
//  XmppHelper+Roster.m
//  iShareSomething
//
//  Created by Elliott on 13-5-27.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "XmppHelper+Roster.h"
#import "XMPPRosterMemoryStorage.h"
@implementation XmppHelper (Roster)


@dynamic Rosters;
static const char* ObjectTagKey1 ="Rosters";

-(NSMutableArray *)Rosters{
    return objc_getAssociatedObject(self,ObjectTagKey1);
}
-(void)setRosters:(NSMutableArray *)Rosters{
    objc_setAssociatedObject(self,ObjectTagKey1,Rosters,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//添加好友
-(void)addFriend:(NSString *)user{
    [self.xmppRoster addUser:[XMPPJID jidWithString:[user stringByAppendingString:Domain]] withNickname:nil];
}
//删除好友
-(void)delFriend:(NSString *)user{
    [self.xmppRoster removeUser:[XMPPJID jidWithString:[user stringByAppendingString:Domain]]];
}

//处理加好友
-(void)SubstripteUser:(Boolean)issubscribe user:(NSString *)user{
    XMPPJID *jid=[XMPPJID jidWithString:[NSString stringWithFormat:@"%@%@",user,Domain]];
    if(issubscribe){
        [self.xmppRoster acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:NO];
    }else{
        [self.xmppRoster rejectPresenceSubscriptionRequestFrom:jid];
    }
}


//获取所有Roster的结果回调方式传来。
- (void)xmppRosterDidPopulate:(XMPPRosterMemoryStorage *)sender{
    self.Rosters= [sender.sortedUsersByName mutableCopy];
}



@end

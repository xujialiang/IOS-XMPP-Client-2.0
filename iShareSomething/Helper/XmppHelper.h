//
//  XmppHelper.h
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDefaultUserInfo.h"
#import "XMPPFramework.h"
#import "MessageCountDelegate.h"
#import "MsgRevDelegate.h"
@class XMPPStream;
@class XMPPvCardTemp;
@class XMPPvCardCoreDataStorage;
@class XMPPvCardTempModule;
@class XMPPvCardAvatarModule;
@class XMPPRosterMemoryStorage;
@class XMPPRoster;
@class XMPPvCardTempModuleStorage;
@interface XmppHelper : NSObject

typedef void (^CallBackVoid) (void);
typedef void (^CallBackString) (NSString *str);
typedef void (^CallBackError) (NSError *err);

@property (nonatomic,strong) XMPPStream *xmppStream;
@property (nonatomic,strong) XMPPvCardCoreDataStorage *xmppvCardStorage;
@property (nonatomic,strong) XMPPvCardTempModule *xmppvCardTempModule;
@property (nonatomic,strong) XMPPvCardTempModuleStorage *xmppvCardTempModuleStorage;
@property (nonatomic,strong) XMPPvCardAvatarModule *xmppvCardAvatarModule;
@property (nonatomic,strong) XMPPvCardTemp *xmppvCardTemp;
@property (strong,nonatomic) XMPPvCardTemp *myVcardTemp;
@property (strong,nonatomic) XMPPRosterMemoryStorage *xmppRosterMemoryStorage;
@property (strong,nonatomic) XMPPRoster *xmppRoster;
@property (strong,nonatomic) NSString *host;
@property (strong,nonatomic) NSString *domain;

@property (strong,nonatomic) CallBackVoid DidDisConnectCallBack;
@property (nonatomic,strong) id<MessageCountDelegate> msgcount;
@property (nonatomic,strong) id<MsgRevDelegate> msgrev;
+(XmppHelper *)Instance;

-(NSString *)connect:(NSString *)account host:(NSString *)host success:(CallBackVoid)DidConnect;

-(void)disconnect;
    
- (void)goOnline;

- (void)goOffline;
@end

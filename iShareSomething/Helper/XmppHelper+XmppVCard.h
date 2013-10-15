//
//  XmppHelper+XmppVCard.h
//  iShareSomething
//
//  Created by Elliott on 13-5-23.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "XmppHelper.h"
#import "XMPPFramework.h"
@interface XmppHelper (XmppVCard)<XMPPvCardTempModuleDelegate>

@property (strong,nonatomic) CallBackVoid Updatesuccess;
@property (strong,nonatomic) CallBackError Updatefail;


-(XMPPvCardTemp *)getmyvcard;

-(XMPPvCardTemp *)getvcard:(NSString *)account;

- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule
        didReceivevCardTemp:(XMPPvCardTemp *)vCardTemp
                     forJID:(XMPPJID *)jid;

- (void)xmppvCardTempModuleDidUpdateMyvCard:(XMPPvCardTempModule *)vCardTempModule;

- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule failedToUpdateMyvCard:(NSXMLElement *)error;

- (void)updateVCard:(XMPPvCardTemp *)vcard success:(CallBackVoid)success fail:(CallBackError)fail;
@end

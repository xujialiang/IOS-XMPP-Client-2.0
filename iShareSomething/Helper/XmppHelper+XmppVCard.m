//
//  XmppHelper+XmppVCard.m
//  iShareSomething
//
//  Created by Elliott on 13-5-23.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "XmppHelper+XmppVCard.h"

@implementation XmppHelper (XmppVCard)

@dynamic Updatesuccess;
@dynamic Updatefail;
static const char* ObjectTagKey1 ="updatesuccess";
static const char* ObjectTagKey2 ="updatefail";

-(CallBackVoid)Updatesuccess{
    return objc_getAssociatedObject(self,ObjectTagKey1);
}
-(void)setUpdatesuccess:(CallBackVoid)Updatesuccess{
    objc_setAssociatedObject(self,ObjectTagKey1,Updatesuccess,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CallBackError)Updatefail{
    return objc_getAssociatedObject(self,ObjectTagKey2);
}
-(void)setUpdatefail:(CallBackError)Updatefail{
    objc_setAssociatedObject(self,ObjectTagKey2,Updatefail,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(XMPPvCardTemp *)getmyvcard{
    
    self.xmppvCardTemp =[self.xmppvCardTempModule myvCardTemp];
    return self.xmppvCardTemp;
}

-(XMPPvCardTemp *)getvcard:(NSString *)account{
    [self.xmppvCardTempModule fetchvCardTempForJID:[XMPPJID jidWithString:[account stringByAppendingString:Domain]]];
    
    return [self.xmppvCardTempModule vCardTempForJID:[XMPPJID jidWithString:[account stringByAppendingString:Domain]] shouldFetch:YES];
}

- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule
        didReceivevCardTemp:(XMPPvCardTemp *)vCardTemp
                     forJID:(XMPPJID *)jid
{
    //NSLog(@"%@",vCardTemp);
}


- (void)xmppvCardTempModuleDidUpdateMyvCard:(XMPPvCardTempModule *)vCardTempModule{
    self.Updatesuccess();
}

- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule failedToUpdateMyvCard:(NSXMLElement *)error{
    NSLog(@"%@",error);
    NSError *err=[[NSError alloc] initWithDomain:@"im.xujialiang.net" code:-1000 userInfo:nil];
    self.Updatefail(err);
}

- (void)updateVCard:(XMPPvCardTemp *)vcard success:(CallBackVoid)success fail:(CallBackError)fail{
    self.Updatesuccess=success;
    self.Updatefail=fail;
    [self.xmppvCardTempModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [self.xmppvCardTempModule updateMyvCardTemp:vcard];
}

@end

 //
//  XmppHelper+Login.m
//  iShareSomething
//
//  Created by Elliott on 13-5-23.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "XmppHelper+Login.h"
#import "NSDefaultUserInfo.h"
#import "XMPP.h"
#import "XMPPvCardTempModule.h"
#import "XMPPvCardCoreDataStorage.h"
#import "XmppHelper+XmppVCard.h"
#import "XMPPvCardTemp.h"
@implementation XmppHelper (Login)

@dynamic Loginsuccess;
@dynamic Loginfail;
static const char* ObjectTagKey1 ="loginsuccess";
static const char* ObjectTagKey2 ="loginfail";

-(CallBackVoid)Loginsuccess{
    return objc_getAssociatedObject(self,ObjectTagKey1);
}
-(void)setLoginsuccess:(CallBackVoid)Loginsuccess{
    objc_setAssociatedObject(self,ObjectTagKey1,Loginsuccess,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CallBackError)Loginfail{
    return objc_getAssociatedObject(self,ObjectTagKey2);
}
-(void)setLoginfail:(CallBackError)Loginfail{
    objc_setAssociatedObject(self,ObjectTagKey2,Loginfail,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)Login:(NSDefaultUserInfo *)userinfo success:(CallBackVoid)success fail:(CallBackError)fail{
    self.Loginsuccess=success;
    self.Loginfail=fail;
    NSString *isconnect=[self connect:[userinfo.account stringByAppendingString:Domain] host:self.host success:^{
        //连接成功，就进行登陆。
        NSError *error=nil;
        [[self xmppStream ]authenticateWithPassword:userinfo.password error:&error];
        if(error!=nil)
        {
            [self disconnect];
            self.Loginfail(error);
        }
    }];
    if([isconnect isEqualToString:@"Y"]){
        return nil;
    }else{
        return isconnect;
    }
}

//验证失败后调用
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error{
    NSLog(@"not authenticated");
    NSError *err=[[NSError alloc] initWithDomain:@"WeShare" code:-100 userInfo:@{@"detail": @"not-authorized"}];
    self.Loginfail(err);
    [self disconnect];
}

//验证成功后调用
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    [self goOnline];
    self.xmppvCardStorage=[XMPPvCardCoreDataStorage sharedInstance];
    self.xmppvCardTempModule=[[XMPPvCardTempModule alloc]initWithvCardStorage:self.xmppvCardStorage];
    [self.xmppvCardTempModule activate:sender];
    [self updatemyvcard];
    self.Loginsuccess();
}

-(void)updatemyvcard{
    XMPPvCardTemp *card=[self getmyvcard];
    if(card.jid==nil){
        card.jid=self.xmppStream.myJID;
        card.nickname=self.xmppStream.myJID.user;
        card.local=@"未填写";
        card.sex=@"未填写";
        card.signature=@"这个家伙很懒，什么也没留下";
        [self updateVCard:card success:^{
            NSLog(@"更新vcard成功");
        } fail:^(NSError *err) {
            NSLog(@"更新vcard失败");
        }];
    }
}


@end

//
//  XmppHelper+Register.m
//  iShareSomething
//
//  Created by Elliott on 13-5-22.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "XmppHelper+Register.h"
#import "XMPP.h"
#import "XmppHelper+XmppVCard.h"

@implementation XmppHelper (Register)

@dynamic Regsuccess;
@dynamic Regfail;
static const char* ObjectTagKey1 ="regsuccess";
static const char* ObjectTagKey2 ="regfail";

-(CallBackVoid)Regsuccess{
    return objc_getAssociatedObject(self,ObjectTagKey1);
}
-(void)setRegsuccess:(CallBackVoid)Regsuccess{
    objc_setAssociatedObject(self,ObjectTagKey1,Regsuccess,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CallBackError)Regfail{
    return objc_getAssociatedObject(self,ObjectTagKey2);
}
-(void)setRegfail:(CallBackError)Regfail{
    objc_setAssociatedObject(self,ObjectTagKey2,Regfail,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//用户注册
-(NSString *)Register:(NSDefaultUserInfo *)userinfo success:(CallBackVoid)Success fail:(CallBackError)Fail{
    self.regsuccess=Success;
    self.regfail=Fail;
    NSString *isconnect=[self connect:[userinfo.account stringByAppendingString:Domain] host:self.host success:^{
        //连接成功，就调用注册。
        XMPPJID *jid=[XMPPJID jidWithString:[userinfo.account stringByAppendingString:Domain]];
        [[self xmppStream] setMyJID:jid];
        NSError *error=nil;
        if (![[self xmppStream] registerWithPassword:userinfo.password error:&error])
        {
            self.Regfail(error);
        }
    }];
    if([isconnect isEqualToString:@"Y"]){
        return nil;
    }else{
        return isconnect;
    }
}



//注册成功后回调
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    [self disconnect];
    self.Regsuccess();
}
//注册失败后回调
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(NSXMLElement *)error{
    NSXMLElement *errornode=[error elementForName:@"error"];
    NSString *code=[errornode attributeStringValueForName:@"code"];
    NSError *err=[[NSError alloc] initWithDomain:Domain code:[code integerValue] userInfo:nil];
    [self disconnect];
    self.Regfail(err);
}
@end

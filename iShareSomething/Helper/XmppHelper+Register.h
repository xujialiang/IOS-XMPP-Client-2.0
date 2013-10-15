//
//  XmppHelper+Register.h
//  iShareSomething
//
//  Created by Elliott on 13-5-22.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "XmppHelper.h"

@interface XmppHelper (Register)

@property (strong,nonatomic) CallBackVoid Regsuccess;
@property (strong,nonatomic) CallBackError Regfail;

-(NSString *)Register:(NSDefaultUserInfo *)userinfo success:(CallBackVoid)Success fail:(CallBackError)Fail;

@end

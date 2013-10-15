//
//  XmppHelper+Login.h
//  iShareSomething
//
//  Created by Elliott on 13-5-23.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "XmppHelper.h"

@interface XmppHelper (Login)

@property (strong,nonatomic) CallBackVoid Loginsuccess;
@property (strong,nonatomic) CallBackError Loginfail;

-(NSString *)Login:(NSDefaultUserInfo *)userinfo success:(CallBackVoid)success fail:(CallBackError)fail;


@end

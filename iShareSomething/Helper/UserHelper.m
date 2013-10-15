//
//  UserHelper.m
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "UserHelper.h"
#import "NSDefaultUserInfo.h"
@implementation UserHelper

+(NSDefaultUserInfo *)UserInfo{
    NSUserDefaults *userinfo=[NSUserDefaults standardUserDefaults];
    NSDefaultUserInfo *user=[[NSDefaultUserInfo alloc] init];
    user.account=[userinfo objectForKey:@"account"];
    user.password=[userinfo objectForKey:@"password"];
    user.sinaid=[userinfo objectForKey:@"sinaID"];
    user.sinatoken=[userinfo objectForKey:@"AccessToken"];
    user.sinatokenexpiredate=[userinfo objectForKey:@"sinatokenexpiredate"];
    return user;
}

+(void)SaveUserInfo:(NSDefaultUserInfo *)user{
    NSUserDefaults *userinfo=[NSUserDefaults standardUserDefaults];
    [userinfo setObject:user.account forKey:@"account"];
    [userinfo setObject:user.password forKey:@"password"];
    [userinfo setObject:user.sinaid forKey:@"sinaID"];
    [userinfo setObject:user.sinatoken forKey:@"AccessToken"];
    [userinfo setObject:user.sinatokenexpiredate forKey:@"sinatokenexpiredate"];
    [userinfo synchronize];
}

@end

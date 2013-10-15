//
//  UserHelper.h
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSDefaultUserInfo;
@interface UserHelper : NSObject

+(NSDefaultUserInfo *)UserInfo;

+(void)SaveUserInfo:(NSDefaultUserInfo *)user;
@end

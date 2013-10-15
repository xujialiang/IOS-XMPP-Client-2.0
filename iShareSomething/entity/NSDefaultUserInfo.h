//
//  NSDefaultUserInfo.h
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDefaultUserInfo : NSObject

@property (nonatomic, strong) NSString * account;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * sinaid;
@property (nonatomic, strong) NSString * sinatoken;
@property (nonatomic, strong) NSString * sinatokenexpiredate;

@end

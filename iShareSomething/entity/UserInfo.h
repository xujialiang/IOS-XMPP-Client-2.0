//
//  UserInfo.h
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfo : NSManagedObject

@property (nonatomic, retain) NSString * account;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * sinaid;
@property (nonatomic, retain) NSString * sinatoken;

@end

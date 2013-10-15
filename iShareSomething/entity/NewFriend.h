//
//  NewFriend.h
//  iShareSomething
//
//  Created by Elliott on 13-5-30.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NewFriend : NSManagedObject

@property (nonatomic, retain) NSString * jid;
@property (nonatomic, retain) NSString * status;

@end

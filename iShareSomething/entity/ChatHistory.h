//
//  ChatHistory.h
//  iShareSomething
//
//  Created by Elliott on 13-5-30.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ChatHistory : NSManagedObject

@property (nonatomic, retain) NSString * from;
@property (nonatomic, retain) NSString * isread;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * to;

@end

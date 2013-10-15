//
//  MsgRevDelegate.h
//  iShareSomething
//
//  Created by Elliott on 13-5-30.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
@protocol MsgRevDelegate <NSObject>

-(void)refreshmsg:(Message *)msg;
@end

//
//  XmppHelper+Roster.h
//  iShareSomething
//
//  Created by Elliott on 13-5-27.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "XmppHelper.h"

@interface XmppHelper (Roster)

@property (nonatomic,strong) NSMutableArray *Rosters;


-(void)SubstripteUser:(Boolean)issubscribe user:(NSString *)user;
-(void)addFriend:(NSString *)user;
@end

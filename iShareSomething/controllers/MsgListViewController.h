//
//  MsgListViewController.h
//  iShareSomething
//
//  Created by Elliott on 13-5-28.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgRevDelegate.h"
@interface MsgListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UILabel *lastmessage;
@end

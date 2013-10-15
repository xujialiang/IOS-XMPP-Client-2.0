//
//  ChatSessionViewController.h
//  iShareSomething
//
//  Created by Elliott on 13-5-28.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBubbleTableViewDataSource.h"
#import "MsgRevDelegate.h"
#import "MsgListViewController.h"
@class XMPPUserMemoryStorageObject;
@class UIBubbleTableView;
@interface ChatSessionViewController : UIViewController<UIBubbleTableViewDataSource,MsgRevDelegate>
- (IBAction)btndone:(id)sender;
- (IBAction)btnsend:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtmsg;

@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIBubbleTableView *bubbletableview;

@property (strong,nonatomic) XMPPUserMemoryStorageObject *userinfo;

@property (nonatomic,strong) NSMutableArray *bubbleData;

@end

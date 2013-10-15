//
//  DetialViewController.h
//  iShareSomething
//
//  Created by Elliott on 13-5-27.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMPPUserMemoryStorageObject;
@interface DetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *jid;
@property (strong, nonatomic) IBOutlet UILabel *remarkname;
@property (strong, nonatomic) IBOutlet UIImageView *photo;
- (IBAction)sendmsg:(id)sender;
-(void)loaddata:(XMPPUserMemoryStorageObject *)userinfo;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

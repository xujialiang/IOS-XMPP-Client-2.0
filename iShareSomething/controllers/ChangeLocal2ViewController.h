//
//  ChangeLocal2ViewController.h
//  iShareSomething
//
//  Created by Elliott on 13-5-27.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProfileViewController;
@interface ChangeLocal2ViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSString *cname;
@property (strong,nonatomic) UILabel *arealabel;
@property (weak,nonatomic) ProfileViewController *viewcontroller;
-(void)loaddata:(NSString *)cid;

@end

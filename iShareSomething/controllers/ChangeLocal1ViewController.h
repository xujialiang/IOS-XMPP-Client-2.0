//
//  ChangeLocal1ViewController.h
//  iShareSomething
//
//  Created by Elliott on 13-5-24.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProfileViewController;
@interface ChangeLocal1ViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) UILabel *locallabel;
@property (weak,nonatomic) ProfileViewController *viewcontroller;
@end

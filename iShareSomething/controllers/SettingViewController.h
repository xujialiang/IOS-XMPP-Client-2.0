//
//  SettingViewController.h
//  iShareSomething
//
//  Created by Elliott on 13-5-24.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *profile;
@property (strong, nonatomic) IBOutlet UITableViewCell *notice;
@property (strong, nonatomic) IBOutlet UITableViewCell *clearrecord;
@property (strong, nonatomic) IBOutlet UITableViewCell *about;
@property (strong, nonatomic) IBOutlet UITableViewCell *logout;

@end

//
//  NewFriendCell.h
//  iShareSomething
//
//  Created by Elliott on 13-5-31.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFriendCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong,nonatomic) NSString *jid;
- (IBAction)btnpass:(id)sender;

@end

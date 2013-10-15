//
//  MsgListCell.h
//  iShareSomething
//
//  Created by Elliott on 13-5-28.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *lastmsg;
@property (strong, nonatomic) IBOutlet UILabel *time;

@end

//
//  NewFriendCell.m
//  iShareSomething
//
//  Created by Elliott on 13-5-31.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "NewFriendCell.h"
#import "XmppHelper+Roster.h"
@implementation NewFriendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnpass:(id)sender {
    [[XmppHelper Instance] SubstripteUser:YES user:self.jid];
    [[XmppHelper Instance] addFriend:self.jid];
}
@end

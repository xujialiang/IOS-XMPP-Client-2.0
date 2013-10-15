//
//  LifeCell.m
//  iShareSomething
//
//  Created by Elliott on 13-5-31.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "LifeCell.h"

@implementation LifeCell

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

- (IBAction)btndelete:(id)sender {
}
@end

//
//  LifeCell.h
//  iShareSomething
//
//  Created by Elliott on 13-5-31.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LifeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UILabel *date;
- (IBAction)btndelete:(id)sender;



@end

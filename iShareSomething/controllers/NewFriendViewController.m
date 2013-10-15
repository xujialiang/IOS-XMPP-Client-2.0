//
//  NewFriendViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-31.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "NewFriendViewController.h"
#import "DbHelper.h"
#import "NewFriend.h"
#import "NewFriendPassCell.h"
#import "NewFriendCell.h"
#import "XmppHelper+XmppVCard.h"
#import "XMPPvCardTemp.h"

@interface NewFriendViewController ()

@property (nonatomic,strong) NSArray *requestlist;

@end

@implementation NewFriendViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1.从数据库中读取请求列表
    self.requestlist=[DbHelper Query:@"NewFriend" predicate:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.requestlist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewFriend *newfriend=[self.requestlist objectAtIndex:indexPath.row];
    NSRange strindex=[newfriend.jid rangeOfString:@"@"];
    NSString *user=[newfriend.jid substringToIndex:strindex.location];
    XMPPvCardTemp *card =[[XmppHelper Instance] getvcard:user];
    if([newfriend.status isEqualToString:@"pass"]){
        static NSString *CellIdentifier = @"newfriendpasscell";
        NewFriendPassCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if(card.photo!=nil){
            cell.imageView.image=[UIImage imageWithData:card.photo];
        }
        cell.name.text=user;
        return cell;
    }else{
        NSString *CellIdentifier = @"newfriendaddcell";
        NewFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        if(card.photo!=nil){
            cell.imageView.image=[UIImage imageWithData:card.photo];
        }
        cell.name.text=user;
        cell.jid=user;
        return cell;
    }
}

@end

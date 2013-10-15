//
//  ContactViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-27.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "ContactViewController.h"
#import "XmppHelper+Roster.h"
#import "XMPPUserMemoryStorageObject.h"
#import "ContactCell.h"
#import "DetailViewController.h"
@interface ContactViewController ()

@property (strong,nonatomic) DetailViewController *destview;

@end

@implementation ContactViewController

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

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 1;
    }else{
        return [[[XmppHelper Instance] Rosters] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        NSString *CellIdentifier = @"newfriendcell";
        ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.name.text=@"新朋友推荐";
        return cell;
    }else{
        NSString *CellIdentifier = @"RosterCell";
        ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        XMPPUserMemoryStorageObject *user= [[[XmppHelper Instance] Rosters] objectAtIndex:indexPath.row];
        
        cell.name.text=user.jid.user;
        if(user.photo!=nil){
            cell.photo.image=user.photo;
        }
        return cell;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        self.destview=segue.destinationViewController;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1){
        XMPPUserMemoryStorageObject *user=[[[XmppHelper Instance] Rosters] objectAtIndex:indexPath.row];
        [self.destview loaddata:user];
    }
}

@end

//
//  MsgListViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-28.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "MsgListViewController.h"
#import "XmppHelper+Message.h"
#import "MsgListCell.h"
#import "Message.h"
#import "utility.h"
#import "ChatSessionViewController.h"
#import "XmppHelper+Roster.h"
#import "XMPPRosterMemoryStorage.h"
@interface MsgListViewController ()
@property (nonatomic,strong) NSDictionary *data;
@property (nonatomic,strong) NSMutableArray *keys;
@property (nonatomic,strong) ChatSessionViewController *destview;

@end

@implementation MsgListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.keys=[[[[XmppHelper Instance] Messages] allKeys] copy];
    if(self.keys==nil){
        return 0;
    }
    else{
        return self.keys.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessageListCell";
    MsgListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *jid=[self.keys objectAtIndex:indexPath.row];
    
    Message *msg= [[[XmppHelper Instance] Messages] objectForKey:jid];
    cell.lastmsg.text=msg.message;
    cell.name.text=msg.from;
    cell.time.text=[utility getCurrentTimeFromString2:msg.date];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString  *user=[self.keys objectAtIndex:indexPath.row];
    XMPPUserMemoryStorageObject *userinfo=[[[XmppHelper Instance] xmppRosterMemoryStorage] userForJID:[XMPPJID jidWithString:user]];
    self.destview.userinfo=userinfo;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    self.destview = segue.destinationViewController;
    XmppHelper *helper=[XmppHelper Instance];
    helper.msgrev=self.destview;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



@end

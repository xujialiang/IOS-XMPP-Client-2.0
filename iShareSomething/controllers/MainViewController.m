//
//  MainViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "MainViewController.h"
#import "LoginNavViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "WeiboHelper.h"
#import "XmppHelper.h"
#import "XMPPStream.h"
#import "XmppHelper+Roster.h"
#import "ContactViewController.h"
#import "MsgListViewController.h"
#import "DbHelper.h"
#import "XmppHelper+Message.h"
#import "ChatSession.h"
#import "Message.h"
@interface MainViewController ()

@end

@implementation MainViewController

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
    NSLog(@"Tab Bar Loaded");
    
    [[self.tabBar.items objectAtIndex:2]setTitle:@"朋友们"];
    UIImage *img=[UIImage imageNamed:@"sina.png"];
    UITabBarItem *item=[self.tabBar.items objectAtIndex:2];
    item.image=img;
    item.tag=2;

}

-(void)viewDidAppear:(BOOL)animated{
    
    XmppHelper *helper=[XmppHelper Instance];
    void (^loginviewshow)(void)=^(void){
        UIStoryboard *storyboard = self.storyboard;
        LoginNavViewController *finished = [storyboard instantiateViewControllerWithIdentifier:@"lnvid"];
        [self presentViewController:finished animated:YES completion:NULL];
    };
    helper.DidDisConnectCallBack=loginviewshow;
    if(helper.xmppStream.isAuthenticated==NO){
        loginviewshow();
    }
    helper.msgcount=self;
    [self fetchChatSession];
}

-(void)fetchChatSession{
    NSArray *data= [DbHelper Query:@"ChatSession" predicate:nil];
    for (ChatSession *object in data) {
        XmppHelper *helper=[XmppHelper Instance];
        if(helper.Messages==nil){
            helper.Messages=[[NSMutableDictionary alloc] init];
        }
        Message *msg=[[Message alloc] init];
        msg.from=object.key;
        msg.to=nil;
        msg.message=object.lastmsg;
        msg.date=object.time;
        [helper.Messages setObject:msg forKey:object.key];
    }
    MsgListViewController *msglistviewctrl=[[[self.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    [msglistviewctrl.tableview reloadData];
    NSInteger cnt= [DbHelper UnReadMsgCount];
    if(cnt<=0){
        [[self.tabBar.items objectAtIndex:0] setBadgeValue:nil];
    }else{
        [[self.tabBar.items objectAtIndex:0] setBadgeValue:[NSString stringWithFormat:@"%d",cnt]];
    }
}

-(void)ResetMsgCount{
    NSInteger cnt= [DbHelper UnReadMsgCount];
    if(cnt<=0){
        [[self.tabBar.items objectAtIndex:0] setBadgeValue:nil];
    }else{
        [[self.tabBar.items objectAtIndex:0] setBadgeValue:[NSString stringWithFormat:@"%d",cnt]];
    }
    MsgListViewController *msglistviewctrl=[[[self.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    [msglistviewctrl.tableview reloadData];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

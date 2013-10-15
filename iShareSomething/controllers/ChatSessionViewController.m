//
//  ChatSessionViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-28.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "ChatSessionViewController.h"
#import "UIBubbleTableView.h"
#import "NSBubbleData.h"
#import "XMPPUserMemoryStorageObject.h"
#import "XmppHelper+Message.h"
#import "Message.h"
#import "DbHelper.h"
#import "ChatHistory.h"
#import "AppDelegate.h"
#import "MainViewController.h"
@interface ChatSessionViewController ()

@end

@implementation ChatSessionViewController

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
	// 1.从数据库聊天历史记录中读取多少油未读消息
    // 2.bar item上的计数器重新计数
    
    self.navigationItem.title=self.userinfo.jid.user;
    
    self.bubbletableview.bubbleDataSource = self;
    self.bubbletableview.backgroundColor=[UIColor whiteColor];
    self.bubbleData=[[NSMutableArray alloc] init];
    [self loadrecord];

    //监听键盘
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    // Register notification when the keyboard will be show
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillShow:)
                          name:UIKeyboardWillShowNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillHide:)
                          name:UIKeyboardWillHideNotification
                        object:nil];
}


//加载未读的消息
-(void)loadrecord{
    //1.加载未读消息
    //2.修改未读记录为已读
    //3.重设计数器
    NSString *myjid=[[[[XmppHelper Instance] xmppStream] myJID] bare];
    NSString *predicate=[NSString stringWithFormat: @"isread='NO' and (from='%@' or to='%@')",self.userinfo.jid.bare,myjid];
    NSArray *dataarray=[DbHelper Query:@"ChatHistory" predicate:predicate];
    for (ChatHistory *object in dataarray) {
        NSBubbleData *data=[NSBubbleData dataWithText:object.message andDate:object.time andType:BubbleTypeSomeoneElse];
        [self.bubbleData addObject:data];
    }
    [DbHelper Update:self.userinfo.jid.bare];
    [self resetunreadcnt];

}

-(void)resetunreadcnt{
    
    NSInteger cnt=[DbHelper UnReadMsgCount];
    if(cnt<=0){
        [[self.tabBarController.tabBar.items objectAtIndex:0] setBadgeValue:nil];
    }else{
        [[self.tabBarController.tabBar.items objectAtIndex:0] setBadgeValue:[NSString stringWithFormat:@"%d",cnt]];
    }
    
}

-(void)sendmsg{
    
    Message *message= [[Message alloc] init];
    message.from=[[[[XmppHelper Instance] xmppStream] myJID] bare];
    message.to=self.userinfo.jid.bare;
    message.message=self.txtmsg.text;
    message.date=[NSDate date];
    [[XmppHelper Instance] sendMessage:message];
    NSBubbleData *msg=[NSBubbleData dataWithText:self.txtmsg.text andDate:[NSDate dateWithTimeIntervalSinceNow:-0] andType:BubbleTypeMine];
    [self.bubbleData addObject:msg];
    [self.bubbletableview reloadData];
    [self scrollTableToFoot:YES];
    [self.txtmsg setText:nil];

    
}

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [self.bubbleData count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [self.bubbleData objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollTableToFoot:(BOOL)animated {
    NSInteger s = [self.bubbletableview numberOfSections];
    if (s<1) return;
    NSInteger r = [self.bubbletableview numberOfRowsInSection:s-1];
    if (r<1) return;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];
    
    [self.bubbletableview scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

-(void)keyboardWillShow:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    //键盘的大小
    CGSize keyboardRect = [aValue CGRectValue].size;
    
    //设置chatlisttableview的高度=当前的高度-键盘的高度
    CGFloat ht=self.bubbletableview.frame.size.height-keyboardRect.height;
    
    self.bubbletableview.frame=CGRectMake(0, self.bubbletableview.frame.origin.y, self.bubbletableview.frame.size.width, ht);
    
    //toolbar的位置=当前的y坐标-键盘的高度
    CGFloat tbpoist=self.toolbar.frame.origin.y-keyboardRect.height;
    self.toolbar.frame=CGRectMake(0,tbpoist, self.toolbar.frame.size.width, self.toolbar.frame.size.height);
    [self scrollTableToFoot:YES];
}

-(void)keyboardWillHide:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    //键盘的大小
    CGSize keyboardRect = [aValue CGRectValue].size;
    
    //设置chatlisttableview的高度=当前的高度+键盘的高度
    CGFloat ht=self.bubbletableview.frame.size.height+keyboardRect.height;
    
    self.bubbletableview.frame=CGRectMake(0, self.bubbletableview.frame.origin.y, self.bubbletableview.frame.size.width, ht);
    
    //toolbar的位置=当前的y坐标-键盘的高度
    CGFloat tbpoist=self.toolbar.frame.origin.y+keyboardRect.height;
    self.toolbar.frame=CGRectMake(0,tbpoist, self.toolbar.frame.size.width, self.toolbar.frame.size.height);
}

-(void)refreshmsg:(Message *)msg{
    if([msg.from isEqualToString: self.userinfo.jid.bare]){
        NSBubbleData *data=[NSBubbleData dataWithText:msg.message andDate:msg.date andType:BubbleTypeSomeoneElse];
        [self.bubbleData addObject:data];
        [self.bubbletableview reloadData];
        [self scrollTableToFoot:YES];
    }
}

- (IBAction)btndone:(id)sender {
    //[self btnsend:sender];
}

- (IBAction)btnsend:(id)sender {
    NSLog(@"send");
    [self sendmsg];
}
@end

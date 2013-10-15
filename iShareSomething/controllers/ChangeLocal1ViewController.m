//
//  ChangeLocal1ViewController.m
//  iShareSomething
//
//  Created by Elliott on 13-5-24.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "ChangeLocal1ViewController.h"
#import "DDXML.h"
#import "ChangeLocal2ViewController.h"
@interface ChangeLocal1ViewController ()

@property (nonatomic,strong) NSMutableDictionary *provinces;
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSString *cid;
@property (nonatomic,strong) ChangeLocal2ViewController *destview;

@end

@implementation ChangeLocal1ViewController

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

    NSString *path = [[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"xml"];
    //获取NSData对象并开始解析
    NSData *xmlData = [NSData dataWithContentsOfFile:path];
    [self parseXML:xmlData];
    [self.tableview reloadData];
}



-(void)parseXML:(NSData *) data
{
    //文档开始（KissXML和GDataXML一样也是基于DOM的解析方式）
    DDXMLDocument *xmlDoc = [[DDXMLDocument alloc] initWithData:data options:0 error:nil];
    
    //利用XPath来定位节点（XPath是XML语言中的定位语法，类似于数据库中的SQL功能）
    NSArray *users = [xmlDoc nodesForXPath:@"//Cities//City" error:nil];
    self.provinces=[[NSMutableDictionary alloc] init];
    self.data=[[NSMutableArray alloc] init];
    for (DDXMLElement *province in users) {
        NSString *id = [[province attributeForName:@"ID"] stringValue];
        NSString *provincename=[[province attributeForName:@"CityName"] stringValue];
        [self.provinces setObject:id forKey:provincename];
        [self.data addObject:provincename];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        self.destview = segue.destinationViewController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //文本
    cell.textLabel.text = [self.data objectAtIndex:[indexPath row]];
    //标记
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int cityid=indexPath.row+1;
    NSString *cid=[NSString stringWithFormat:@"%d",cityid];
    NSString *cname=[self.data objectAtIndex:indexPath.row];
    self.destview.cname=cname;
    self.destview.arealabel=self.locallabel;
    self.destview.viewcontroller=self.viewcontroller;
    [self.destview loaddata:cid];
}

@end

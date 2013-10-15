//
//  XmppHelper+Message.m
//  iShareSomething
//
//  Created by Elliott on 13-5-27.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "XmppHelper+Message.h"
#import "utility.h"
#import "Message.h"
#import "AppDelegate.h"
#import "DbHelper.h"
#import "ChatSessionEntity.h"
#import "ChatHistoryEntity.h"
@implementation XmppHelper (Message)


@dynamic Messages;
static const char* ObjectTagKey1 ="Messages";

-(NSMutableArray *)Messages{
    return objc_getAssociatedObject(self,ObjectTagKey1);
}

-(void)setMessages:(NSMutableArray *)Messages{
    objc_setAssociatedObject(self,ObjectTagKey1,Messages,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//收到消息后调用
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    
    NSString *content = message.body;
    NSString *sendtime = [[message elementForName:@"time"] stringValue];
    NSString *from = message.from.bareJID.bare;
    if(content!=nil){
        //1.封装收到的消息
        //2.将消息保存到历史记录表，标记为未读
        //3.将消息保存到会话表，保存最后一条收到的记录。
        //4.消息计数器加1
        Message *msg=[[Message alloc] init];
        msg.message=content;
        msg.from=from;
        msg.isread=@"NO";
        if(sendtime!=nil){
            msg.date=[utility getCurrentTimeFromString:sendtime];
        }else{
            msg.date=[NSDate date];
        }
        [self SaveLastMessage:msg.from msg:msg];
        [self SaveLastMessageToDB:msg.from content:msg.message time:msg.date];
        [self SaveHistoryMessageToDB:msg];
        [self.msgcount ResetMsgCount];
        if(self.msgrev!=nil){
            [self.msgrev refreshmsg:msg];
        }
    }
}

//发送消息
- (void)sendMessage:(Message *)message{
    
    if (message.message.length > 0) {
        //XMPPFramework主要是通过KissXML来生成XML文件
        //生成<body>文档
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:message.message];
        NSXMLElement *sendtime = [NSXMLElement elementWithName:@"time"];
        [sendtime setStringValue:[utility getCurrentTime]];
        //生成XML消息文档
        NSXMLElement *mes = [NSXMLElement elementWithName:@"message"];
        //消息类型
        [mes addAttributeWithName:@"type" stringValue:@"chat"];
        //发送给谁
        [mes addAttributeWithName:@"to" stringValue:message.to];
        //由谁发送
        [mes addAttributeWithName:@"from" stringValue:message.from];
        [mes addAttributeWithName:@"isread" stringValue:@"YES"];
        //组合
        [mes addChild:body];
        [mes addChild:sendtime];
        //发送消息
        [[self xmppStream] sendElement:mes];
        [self SaveLastMessage:message.to msg:message];
        [self SaveLastMessageToDB:message.to content:message.message time:message.date];
        [self SaveHistoryMessageToDB:message];
    }
}

//保存最后一条聊天记录
-(void)SaveLastMessage:(NSString *) key msg:(Message *)msg{
    if(self.Messages==nil){
        self.Messages=[[NSMutableDictionary alloc] init];
    }
    [self.Messages setObject:msg forKey:key];
}
//保存最后一条聊天记录到数据库
-(void)SaveLastMessageToDB:(NSString *)key content:(NSString *)content time:(NSDate *)time{
    ChatSessionEntity *data=[[ChatSessionEntity alloc] init];
    data.key=key;
    data.lastmsg=content;
    data.time=time;
    NSString *predicate=[NSString stringWithFormat:@"%@='%@'",@"key",key];
    [DbHelper DeleteChatSession:@"ChatSession" predicate:predicate];
    [DbHelper InsertChatSession:data];
}

//保存所有消息到数据库
-(void)SaveHistoryMessageToDB:(Message *)msg{
    ChatHistoryEntity *data=[[ChatHistoryEntity alloc] init];
    data.from=msg.from;
    data.to=msg.to;
    data.message=msg.message;
    data.time=msg.date;
    data.isread=msg.isread;
    [DbHelper InsertChatHistory:data];
}


@end

//
//  DbHelper.m
//  iShareSomething
//
//  Created by Elliott on 13-5-21.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "DbHelper.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "ChatSessionEntity.h"
#import "ChatSession.h"
#import "ChatHistory.h"
#import "ChatHistoryEntity.h"
#import "NewFriend.h"
#import "NewFriendEntity.h"
@implementation DbHelper

+(NSArray *)Query:(NSString *)entityname predicate:(NSString *)predicate{
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext=[appdel managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityname];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:predicate];
    NSArray *fetchResult = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return fetchResult;
}

+(void)Update:(NSString *)jid{
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext=[appdel managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ChatHistory"];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"isread='NO' and from='%@'",jid]];
    NSError *error;
    NSArray *fetchResult = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if(!error && fetchResult.count>0){
        for(ChatHistory *object in fetchResult) {
            object.isread=@"YES";
        }
    }
    if([appdel.managedObjectContext hasChanges]) {
        [appdel.managedObjectContext save:&error];
    }
}

+(void)InsertChatSession:(ChatSessionEntity *)entity {
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext=[appdel managedObjectContext];
    ChatSession *record = [NSEntityDescription
                 insertNewObjectForEntityForName:@"ChatSession"
                                inManagedObjectContext:managedObjectContext];
    if (record != nil){
        record.key=entity.key;
        record.lastmsg=entity.lastmsg;
        record.time=entity.time;
        NSError *savingError = nil;
        if ([managedObjectContext save:&savingError]){
            NSLog(@"Successfully saved the context.");
        } else {
            NSLog(@"Failed to save the context. Error = %@", savingError);
        }
    } else {
        NSLog(@"Failed to create the new record.");
    }
}

+(void)InsertChatHistory:(ChatHistoryEntity *)entity {
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext=[appdel managedObjectContext];
    ChatHistory *record = [NSEntityDescription
                           insertNewObjectForEntityForName:@"ChatHistory"
                           inManagedObjectContext:managedObjectContext];
    if (record != nil){
        record.from=entity.from;
        record.to=entity.to;
        record.time=entity.time;
        record.message=entity.message;
        record.isread=entity.isread;
        NSError *savingError = nil;
        if ([managedObjectContext save:&savingError]){
            NSLog(@"Successfully saved the History context.");
        } else {
            NSLog(@"Failed to save the History context. Error = %@", savingError);
        }
    } else {
        NSLog(@"Failed to create the History new record.");
    }
}

+(void)InsertNewFriend:(NewFriendEntity *)entity{
    //1.先查找是否存在过请求记录
    //2.添加这条请求记录
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"NewFriend"];
    NSString *predicate= [NSString stringWithFormat:@"jid ='%@'",entity.jid];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:predicate];
    NSError *error;
    
    NSArray *fetchResult = [appdel.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(!error){
        if(fetchResult.count>0) return;
        else{
            NSManagedObjectContext *managedObjectContext=[appdel managedObjectContext];
            NewFriend *record = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"NewFriend"
                                 inManagedObjectContext:managedObjectContext];
            if (record != nil){
                record.jid=entity.jid;
                record.status=@"NO";
                NSError *savingError = nil;
                if ([managedObjectContext save:&savingError]){
                    NSLog(@"Successfully saved the newfriend context.");
                } else {
                    NSLog(@"Failed to save the newfriend context. Error = %@", savingError);
                }
            } else {
                NSLog(@"Failed to create the newfriend new record.");
            }
        }
    }else{
        NSLog(@"%@",error);
    }
}


+(void)DeleteChatSession:(NSString *)entity predicate:(NSString *)predicate{
    AppDelegate *appdel=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *userEntity = [NSEntityDescription entityForName:@"ChatSession" inManagedObjectContext:[appdel managedObjectContext]];
    
    [fetchRequest setEntity:userEntity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:predicate]];
    NSError *error;
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSArray *fetchResult = [[appdel managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    if(!error && fetchResult.count>0){
        for(ChatSession *object in fetchResult) {
            [appdel.managedObjectContext deleteObject:object];
        }
    }
    if([appdel.managedObjectContext hasChanges]) {
        [appdel.managedObjectContext save:&error];
    }
}

+(NSInteger)UnReadMsgCount{
    AppDelegate *appdel=[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext=[appdel managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ChatHistory"];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"isread='NO'"]];
    NSError *error;
    NSArray *fetchResult = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchResult.count;
}

@end

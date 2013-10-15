//
//  AppDelegate.h
//  iShareSomething
//
//  Created by Elliott on 13-5-20.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XmppHelper;
@class WeiboHelper;
@class MainViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) XmppHelper *xmppHepler;
@property (strong, nonatomic) WeiboHelper *weiboHepler;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic) MainViewController *mainviewController;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

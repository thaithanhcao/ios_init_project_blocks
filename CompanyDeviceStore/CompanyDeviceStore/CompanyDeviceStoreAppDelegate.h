//
//  CompanyDeviceStoreAppDelegate.h
//  CompanyDeviceStore
//
//  Created by TOANACHAU on 2/2/16.
//  Copyright (c) 2016 TOANACHAU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyDeviceStoreAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

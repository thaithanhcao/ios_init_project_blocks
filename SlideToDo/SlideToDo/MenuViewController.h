//
//  MenuViewController.h
//  SlideToDo
//
//  Created by TOANACHAU on 2/24/16.
//  Copyright (c) 2016 TOANACHAU. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate;

@interface MenuViewController : UIViewController
@property (nonatomic, weak) id <MenuViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *categoryList;
@end

@protocol MenuViewControllerDelegate
-(void)menuViewControllerDidFinishWithCategoryId:(NSInteger)categoryId;
@end
//
//  RecipeHandbookViewController.h
//  RecipeHandbook
//
//  Created by TOANACHAU on 1/17/16.
//  Copyright (c) 2016 TOANACHAU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeHandbookViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

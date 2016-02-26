//
//  ToDoViewController.m
//  SlideToDo
//
//  Created by TOANACHAU on 2/24/16.
//  Copyright (c) 2016 TOANACHAU. All rights reserved.
//

#import "ToDoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface ToDoViewController () <UITableViewDataSource, UITableViewDelegate, MenuViewControllerDelegate>
@property (nonatomic, weak) IBOutlet UINavigationItem *navigationTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *toDoCategories;
@property (nonatomic, assign) NSInteger selectedCategory;
@end

@implementation ToDoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Add a shadow to the top view so it looks like it is on top of the others
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    
    // Tell it which view should be created under left
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]])
    {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuView"];
        [(MenuViewController *)self.slidingViewController.underLeftViewController setCategoryList:self.toDoCategories];
        [(MenuViewController *)self.slidingViewController.underLeftViewController setDelegate:self];
    }
    
    // Add the pan gesture to allow sliding
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

#pragma mark - Tableview Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *currentCategory = self.toDoCategories[self.selectedCategory];
    return [currentCategory[@"items"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *currentCategory = self.toDoCategories[self.selectedCategory];
    cell.textLabel.text = currentCategory[@"items"][indexPath.row];
    
    return cell;
}

- (void)menuViewControllerDidFinishWithCategoryId:(NSInteger)categoryId
{
    self.selectedCategory = categoryId;
    self.navigationTitle.title = self.toDoCategories[self.selectedCategory][@"title"];
    [self.tableView reloadData];
    [self.slidingViewController resetTopView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSDictionary *choresDictionary = @{@"title": @"Chores",
                                       @"items": @[@"Sweep", @"Dishes", @"Mow the lawn"]};
    NSDictionary *workDictionary = @{@"title": @"Work",
                                     @"items": @[@"TPS Report"]};
    NSDictionary *groceryDictionary = @{@"title": @"Grocery List",
                                        @"items":@[@"Chips", @"Salsa", @"Fruit snacks", @"Beer"]};
    
    self.toDoCategories = @[choresDictionary, workDictionary, groceryDictionary];
    self.selectedCategory = 0;
    self.navigationTitle.title = self.toDoCategories[self.selectedCategory][@"title"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

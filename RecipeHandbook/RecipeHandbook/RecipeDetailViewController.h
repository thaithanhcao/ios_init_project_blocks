//
//  RecipeDetailViewController.h
//  RecipeHandbook
//
//  Created by TOANACHAU on 1/26/16.
//  Copyright (c) 2016 TOANACHAU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *recipePhoto;
@property (weak, nonatomic) IBOutlet UILabel *prepTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *ingredientTextView;

@property (nonatomic, strong) Recipe *recipe;

@end

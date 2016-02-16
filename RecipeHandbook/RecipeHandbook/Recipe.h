//
//  Recipe.h
//  RecipeHandbook
//
//  Created by TOANACHAU on 1/30/16.
//  Copyright (c) 2016 TOANACHAU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic, strong) NSString *name; // name of recipe
@property (nonatomic, strong) NSString *prepTime; // preparation time
@property (nonatomic, strong) NSString *imageFile; // image filename of recipe
@property (nonatomic, strong) NSString *imageDetailFile; // image detail filename of recipe
@property (nonatomic, strong) NSArray *ingredients; // ingredients

@end

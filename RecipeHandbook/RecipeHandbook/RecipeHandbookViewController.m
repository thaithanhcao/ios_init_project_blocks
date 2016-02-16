//
//  RecipeHandbookViewController.m
//  RecipeHandbook
//
//  Created by TOANACHAU on 1/17/16.
//  Copyright (c) 2016 TOANACHAU. All rights reserved.
//

#import "RecipeHandbookViewController.h"
#import "RecipeDetailViewController.h"
#import "Recipe.h"

@interface RecipeHandbookViewController ()

@end

@implementation RecipeHandbookViewController
{
    NSMutableArray *recipes;
    //NSArray *recipes;
    NSArray *searchResults;
}

@synthesize tableView;

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    //NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", searchText];
    searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        [self performSegueWithIdentifier:@"showRecipeDetail" sender:self];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [recipes removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [searchResults count];
    }
    else
    {
        return [recipes count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        Recipe *specificRecipe;
        
        specificRecipe = [searchResults objectAtIndex:indexPath.row];
        {
            cell.textLabel.text = specificRecipe.name;
            cell.imageView.image = [UIImage imageNamed:specificRecipe.imageFile];
        }
    }
    else
    {
        Recipe *recipe;
        recipe = [recipes objectAtIndex:indexPath.row];
        cell.textLabel.text = recipe.name;
        cell.imageView.image = [UIImage imageNamed:recipe.imageFile];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showRecipeDetail"])
    {
        RecipeDetailViewController *destViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = nil;
        
        if ([self.searchDisplayController isActive])
        {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            destViewController.recipe = [searchResults objectAtIndex:indexPath.row];
        }
        else
        {
            indexPath = [self.tableView indexPathForSelectedRow];
            destViewController.recipe = [recipes objectAtIndex:indexPath.row];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Initialize recipes
    Recipe *recipe1 = [Recipe new];
    recipe1.name = @"Egg Benedict";
    recipe1.prepTime = @"30 mins";
    recipe1.imageFile = @"egg_benedict.jpg";
    recipe1.imageDetailFile = @"egg_benedict_detail.jpg";
    recipe1.ingredients = [NSArray arrayWithObjects: @"2 fresh English muffins", @"4 eggs", @"4 rashers of back bacon", @"2 egg yolks", @"1 tbsp of lemon juice", @"125g of butter", @"salt and pepper", nil];
    
    Recipe *recipe2 = [Recipe new];
    recipe2.name = @"Mushroom Risotto";
    recipe2.prepTime = @"30 mins";
    recipe2.imageFile = @"mushroom_risotto.jpg";
    recipe2.imageDetailFile = @"mushroom_risotto_detail.jpg";
    recipe2.ingredients = [NSArray arrayWithObjects:@"1 tbsp dried porcini mushrooms", @"2 tbsp olive oil", @"1 onion, chopped", @"2 garlic cloves", @"350g/12oz arborio rice", @"1.2 litres/2 pints hot vegetable stock", @"salt and pepper", @"25g/1oz butter", nil];
    
    Recipe *recipe3 = [Recipe new];
    recipe3.name = @"Full Breakfast";
    recipe3.prepTime = @"20 mins";
    recipe3.imageFile = @"full_breakfast.jpg";
    recipe3.imageDetailFile = @"full_breakfast_detail.jpg";
    recipe3.ingredients = [NSArray arrayWithObjects:@"2 sausages", @"100 grams of mushrooms", @"2 rashers of bacon", @"2 eggs", @"150 grams of baked beans", @"Vegetable oil", nil];
    
    Recipe *recipe4 = [Recipe new];
    recipe4.name = @"Hamburger";
    recipe4.prepTime = @"30 mins";
    recipe4.imageFile = @"hamburger.jpg";
    recipe4.imageDetailFile = @"hamburger_detail.jpg";
    recipe4.ingredients = [NSArray arrayWithObjects:@"400g of ground beef", @"1/4 onion (minced)", @"1 tbsp butter", @"hamburger bun", @"1 teaspoon dry mustard", @"Salt and pepper", nil];
    
    Recipe *recipe5 = [Recipe new];
    recipe5.name = @"Ham and Egg Sandwich";
    recipe5.prepTime = @"10 mins";
    recipe5.imageFile = @"ham_and_egg_sandwich.jpg";
    recipe5.imageDetailFile = @"ham_and_egg_sandwich_detail.jpg";
    recipe5.ingredients = [NSArray arrayWithObjects:@"1 unsliced loaf (1 pound) French bread", @"4 tablespoons butter", @"2 tablespoons mayonnaise", @"8 thin slices deli ham", @"1 large tomato, sliced", @"1 small onion", @"8 eggs", @"8 slices cheddar cheese", nil];
    
    Recipe *recipe6 = [Recipe new];
    recipe6.name = @"Creme Brelee";
    recipe6.prepTime = @"1 hour";
    recipe6.imageFile = @"creme_brelee.jpg";
    recipe6.imageDetailFile = @"creme_brelee_detail.jpg";
    recipe6.ingredients = [NSArray arrayWithObjects:@"1 quart heavy cream", @"1 vanilla bean, split and scraped", @"1 cup vanilla sugar", @"6 large egg yolks", @"2 quarts hot water", nil];
    
    Recipe *recipe7 = [Recipe new];
    recipe7.name = @"White Chocolate Donut";
    recipe7.prepTime = @"45 mins";
    recipe7.imageFile = @"white_chocolate_donut.jpg";
    recipe7.imageDetailFile = @"white_chocolate_donut_detail.jpg";
    recipe7.ingredients = [NSArray arrayWithObjects:@"3 1/4 cups flour", @"2 teaspoons baking powder", @"1/4 teaspoon salt", @"2 beaten eggs", @"2/3 cup sugar", @"2 ounces melted white chocolate", @"1/2 cup milk", nil];
    
    Recipe *recipe8 = [Recipe new];
    recipe8.name = @"Starbucks Coffee";
    recipe8.prepTime = @"5 mins";
    recipe8.imageFile = @"starbucks_coffee.jpg";
    recipe8.imageDetailFile = @"starbucks_coffee_detail.jpg";
    recipe8.ingredients = [NSArray arrayWithObjects:@"2/3 cup whole milk", @"6 tablespoons white chocolate chips", @"coffee", @"whipped cream", nil];
    
    Recipe *recipe9 = [Recipe new];
    recipe9.name = @"Vegetable Curry";
    recipe9.prepTime = @"30 mins";
    recipe9.imageFile = @"vegetable_curry.jpg";
    recipe9.imageDetailFile = @"vegetable_curry_detail.jpg";
    recipe9.ingredients = [NSArray arrayWithObjects:@"1 tablespoon olive oil", @"1 onion, chopped", @"2 cloves garlic", @"2 1/2 tablespoons curry powder", @"2 quarts hot water", nil];
    
    Recipe *recipe10 = [Recipe new];
    recipe10.name = @"Instant Noodle with Egg";
    recipe10.prepTime = @"8 mins";
    recipe10.imageFile = @"instant_noodle_with_egg.jpg";
    recipe10.imageDetailFile = @"instant_noodle_with_egg_detail.jpg";
    recipe10.ingredients = [NSArray arrayWithObjects:@"1 pack of Instant Noodle", @"2 eggs", nil];
    
    Recipe *recipe11 = [Recipe new];
    recipe11.name = @"Noodle with BBQ Pork";
    recipe11.prepTime = @"20 mins";
    recipe11.imageFile = @"noodle_with_bbq_pork.jpg";
    recipe11.imageDetailFile = @"noodle_with_bbq_pork_detail.jpg";
    recipe11.ingredients = [NSArray arrayWithObjects:@"1 pack of Instant Noodle", @"BBQ pork", @"Salt and Pepper", nil];
    
    Recipe *recipe12 = [Recipe new];
    recipe12.name = @"Japanese Noodle with Pork";
    recipe12.prepTime = @"20 mins";
    recipe12.imageFile = @"japanese_noodle_with_pork.jpg";
    recipe12.imageDetailFile = @"japanese_noodle_with_pork_detail.jpg";
    recipe12.ingredients = [NSArray arrayWithObjects:@"1 pack of Japanese Noodle", @"2 green onions", @"2 garlic cloves, minced", @"4 boneless pork loin chops", nil];
    
    Recipe *recipe13 = [Recipe new];
    recipe13.name = @"Green Tea";
    recipe13.prepTime = @"5 mins";
    recipe13.imageFile = @"green_tea.jpg";
    recipe13.imageDetailFile = @"green_tea_detail.jpg";
    recipe13.ingredients = [NSArray arrayWithObjects:@"Green tea", nil];
    
    Recipe *recipe14 = [Recipe new];
    recipe14.name = @"Thai Shrimp Cake";
    recipe14.prepTime = @"1.5 hours";
    recipe14.imageFile = @"thai_shrimp_cake.jpg";
    recipe14.imageDetailFile = @"thai_shrimp_cake_detail.jpg";
    recipe14.ingredients = [NSArray arrayWithObjects:@"8oz (250g) peeled and deveined raw shrimp", @"2 tablespoons red curry paste", @"1 large egg", @"2 teaspoon fish sauce", @"1 tablespoon sugar", @"2 tablespoons coconut milk", @"2 tablespoons roughly chopped Thai basil leaves", nil];
    
    Recipe *recipe15 = [Recipe new];
    recipe15.name = @"Angry Birds Cake";
    recipe15.prepTime = @"4 hours";
    recipe15.imageFile = @"angry_birds_cake.jpg";
    recipe15.imageDetailFile = @"angry_birds_cake_detail.jpg";
    recipe15.ingredients = [NSArray arrayWithObjects:@"12 tablespoons (1 1/2 sticks) unsalted butter", @"2 1/2 cups all-purpose flour", @"1 tablespoon baking powder", @"1 teaspoon salt", @"1 3/4 cups sugar", @"2 large eggs, plus 3 large egg yolks", @"1 cup of milk", nil];
    
    Recipe *recipe16 = [Recipe new];
    recipe16.name = @"Ham and Cheese Panini";
    recipe16.prepTime = @"10 mins";
    recipe16.imageFile = @"ham_and_cheese_panini.jpg";
    recipe16.imageDetailFile = @"ham_and_cheese_panini_detail.jpg";
    recipe16.ingredients = [NSArray arrayWithObjects:@"2 tablespoons unsalted butter", @"4 cups thinly sliced shallots", @"2 teaspoons fresh thyme", @"1/4 cup grainy Dijon mustard", @"8 slices rustic white bread", @"8 slices Gruyere cheese", @"8 ounces sliced cooked ham", nil];
    
    recipes = [NSMutableArray arrayWithObjects:recipe1, recipe2, recipe3, recipe4, recipe5, recipe6, recipe7, recipe8, recipe9, recipe10, recipe11, recipe12, recipe13, recipe14, recipe15, recipe16, nil];
    //recipes = [NSArray arrayWithObjects:recipe1, recipe2, recipe3, recipe4, recipe5, recipe6, recipe7, recipe8, recipe9, recipe10, recipe11, recipe12, recipe13, recipe14, recipe15, recipe16, nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

//
//  ViewController.h
//  CapAShot
//
//  Created by Thai Thanh Cao on 3/20/16.
//  Copyright (c) 2016 TOANACHAU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;

@end


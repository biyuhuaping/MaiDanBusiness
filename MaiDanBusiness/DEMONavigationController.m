//
//  DEMONavigationController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMONavigationController.h"
#import "DEMOMenuViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
@interface DEMONavigationController ()

@property (strong, readwrite, nonatomic) DEMOMenuViewController *menuViewController;

@end

@implementation DEMONavigationController
- (void)viewWillAppear:(BOOL)animated{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //

    [self.view endEditing:YES];
   

    // Present the view controller
    //
    
    
   
}
- (void)showMenu1:(UIViewController *)viewVC
{
    // Dismiss keyboard (optional)
    //
    
    // Present the view controller
    //
//    self.menuViewController.viewVC = viewVC;
    viewVC = _menuViewController.viewVC;
}
#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    
    // Present the view controller
    //
}

@end

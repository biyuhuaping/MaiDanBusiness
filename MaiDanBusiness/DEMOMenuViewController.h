//
//  DEMOMenuViewController.h
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DEMONavigationController;
@class HomeViewController;
@interface DEMOMenuViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)DEMONavigationController *navVC;
@property (nonatomic, strong)HomeViewController *viewVC;


@end

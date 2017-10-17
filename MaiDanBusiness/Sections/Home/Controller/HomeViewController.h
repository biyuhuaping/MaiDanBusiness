//
//  HomeViewController.h
//  DaJiaZhuanSH
//
//  Created by feng on 15/10/8.
//  Copyright © 2015年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMessage.h"
#import "BaseViewController.h"

@class DEMONavigationController;
@interface HomeViewController : BaseViewController< UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)HomeMessage *homeMessage;
@property (nonatomic, assign) BOOL enter;
@property (nonatomic, assign) BOOL isAction;

- (void)share;
-(void)requestDataFromNet;
- (void)showLeft;
@end

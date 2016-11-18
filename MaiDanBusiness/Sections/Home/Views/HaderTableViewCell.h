//
//  HaderTableViewCell.h
//  DDAJIAZHUANGSH
//
//  Created by su on 15/10/18.
//  Copyright © 2015年 su. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewController;
@interface HaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet    UIImageView *imgViewLogo;
@property (weak, nonatomic) IBOutlet    UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet    UILabel *inviteCode;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property(nonatomic,strong)HomeViewController *homeVC;

@end

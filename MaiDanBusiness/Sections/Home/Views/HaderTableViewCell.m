//
//  HaderTableViewCell.m
//  DDAJIAZHUANGSH
//
//  Created by su on 15/10/18.
//  Copyright © 2015年 su. All rights reserved.
//

#import "HaderTableViewCell.h"
#import "FulfillCardVC.h"
#import "HomeViewController.h"
@implementation HaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)btnPressed:(id)sender {
    
    FulfillCardVC *controller = [[FulfillCardVC alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.homeVC.navigationController pushViewController:controller animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

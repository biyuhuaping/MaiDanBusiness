//
//  CLLockInfoView.m
//  CoreLock
//
//  Created by 成林 on 15/4/27.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CLLockInfoView.h"
#import "CoreLockConst.h"





@implementation CLLockInfoView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    //
    self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(-20, -10, 85 *G_SCREEN_HEIGHT/667 , 85 * G_SCREEN_HEIGHT/667)];
//    self.headerView.centerX = self.centerX;
    _headerView.layer.borderWidth = 2;
    _headerView.layer.borderColor = [UIColor whiteColor].CGColor;
    _headerView.layer.masksToBounds    = YES;
    _headerView.layer.cornerRadius     = 42.5 *G_SCREEN_HEIGHT/667;
    
    if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[API shareAPI] getLocalData:G_HeadUrl]
         ]) {
         _headerView.image =[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[[API shareAPI] getLocalData:G_HeadUrl]];
    }else{
        // by mayan  20160426   修改加载失败图
        [_headerView sd_setImageWithURL:[NSURL URLWithString:G_HeadUrl] placeholderImage:[UIImage imageNamed:@"logo_zhuan"]];
    }
    [self addSubview:_headerView];
    //添加用户名
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(-25, _headerView.bottom + 8, 90, 20)];
    self.userName.textAlignment = NSTextAlignmentCenter;
    self.userName.textColor = [UIColor whiteColor];
    self.userName.text = [[API shareAPI] getLocalData:G_SHOP_NAME];
    
    //TODO
    [self addSubview:_userName];
}





















@end

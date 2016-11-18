//
//  HomeTableViewCell1.m
//  DaJiaZhuanSH
//
//  Created by feng on 15/10/10.
//  Copyright © 2015年 feng. All rights reserved.
//

#import "HomeTableViewCell1.h"
#import "FulfillCardVC.h"
#import "HomeViewController.h"

@implementation HomeTableViewCell1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //logo
        self.imgViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
        
        _imgViewLogo.layer.cornerRadius = 3;
        _imgViewLogo.layer.masksToBounds = YES;
        _imgViewLogo.image = [UIImage imageNamed:@"icon_biz"];
        [self.contentView addSubview:_imgViewLogo];
        
        //标题
        UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(95, 5, 100, 20)];
        lbl1.text = @"营业收入：";
        lbl1.font = [UIFont systemFontOfSize:14];
        [self.contentView  addSubview:lbl1];
        
        //积分
        self.scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(180, 5, G_SCREEN_WIDTH - 200, 20)];
       _scoreLable.font= [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        _scoreLable.textColor = RGBCOLOR(234, 85, 20);
        _scoreLable.textAlignment = NSTextAlignmentRight;
        [self.contentView  addSubview:_scoreLable];
        
        //标题
        UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(95, 25, 100, 20)];
        lbl3.text = @"分享收益：";
        lbl3.font = [UIFont systemFontOfSize:14];
        [self.contentView  addSubview:lbl3];
        
        //分享收益
        self.inviteCode = [[UILabel alloc] initWithFrame:CGRectMake(180, 25, G_SCREEN_WIDTH - 200, 20)];
        _inviteCode.font= [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        _inviteCode.textAlignment = NSTextAlignmentRight;
        _inviteCode.textColor = RGBCOLOR(234, 85, 20);
        [self.contentView addSubview:_inviteCode];
        
        //充值
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(G_SCREEN_WIDTH - 80, 50, 60, 30)];
        btn1.userInteractionEnabled = YES;
            [btn1 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        btn1.backgroundColor = RGBCOLOR(219, 34, 41);
        [btn1 setTitle:@"充 值" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:btn1];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;

}

/**
 *  按钮触发事件
 *
 *  @param sender
 */
- (void)btnPressed:(id)sender{
        FulfillCardVC *controller = [[FulfillCardVC alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
//        [self.homeVC.navigationController pushViewController:controller animated:YES];
}
- (void)awakeFromNib {
    // Initialization code
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

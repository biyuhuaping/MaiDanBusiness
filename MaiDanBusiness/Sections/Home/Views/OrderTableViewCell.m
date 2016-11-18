//
//  OrderTableViewCell.m
//  DaJiaZhuanSH
//
//  Created by feng on 15/10/15.
//  Copyright © 2015年 feng. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGBCOLOR(247, 247, 247);
    //设置背景cell
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, G_SCREEN_WIDTH - 30, 145)];
        bgView.image = [UIImage imageNamed:@"dingdan_bg"];
        [self addSubview:bgView];
    
        //订单号
        UILabel *order = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 50, 20)];
        order.text = @"订单号:";
        order.font = [UIFont systemFontOfSize:14];
        order.textColor = RGBCOLOR(153, 153, 153);
        [bgView addSubview:order];
        
        self.orderno = [[UILabel alloc] initWithFrame:CGRectMake(order.right, order.top, bgView.size.width - order.bottom - 60, 20)];
        self.orderno.font = [UIFont systemFontOfSize:17];
        self.orderno.textColor = RGBCOLOR(51, 51, 51);
        [bgView addSubview:_orderno];
        
        
        
        //确认状态
        self.confirmState = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dingdan_yqr"]];
        self.confirmState.frame = CGRectMake(bgView.size.width - 65, order.top + 2, 50, 17) ;
        [bgView addSubview:_confirmState];
        
        //分配金额
        NSArray *nameText = @[@"分配金额",@"分配比例",@"支付方式"];
        for (int i = 0; i < 3; i++) {
          
            UILabel *distribution = [[UILabel alloc] initWithFrame:CGRectMake( i *bgView.size.width/3 , order.bottom + 17, bgView.size.width/3, 20)];
            distribution.textAlignment = NSTextAlignmentCenter;
            distribution.text = nameText[i];
            distribution.font = [UIFont systemFontOfSize:13];
            distribution.textColor = RGBACOLOR(12, 3, 7, 0.3);
            [bgView addSubview:distribution];
            if (i == 0) {
                //钱
                self.totalfee = [[UILabel alloc] initWithFrame:CGRectMake( i *bgView.size.width/3 , distribution.bottom + 7, bgView.size.width/3, 20)];
               self.totalfee.font =  [UIFont fontWithName:@"HelveticaNeue-Bold" size:19];
                self.totalfee.textAlignment = NSTextAlignmentCenter;
                self.totalfee.textColor = RGBCOLOR(237, 87, 49);
                [bgView addSubview:_totalfee];
                
            }
            else if (i == 1){
                self.feerat =[[UILabel alloc] initWithFrame:CGRectMake( i *bgView.size.width/3 , distribution.bottom + 7, bgView.size.width/3, 20)];
                self.feerat.font =  [UIFont fontWithName:@"HelveticaNeue-Bold" size:19];
                self.feerat.textAlignment = NSTextAlignmentCenter;
                self.feerat.textColor = RGBCOLOR(0, 221, 194);
                [bgView addSubview:_feerat];

                
            }else if (i == 2){
                self.payImageV=[[UIImageView alloc] initWithFrame:CGRectMake( i *bgView.size.width/3 , distribution.bottom + 7, 24, 24)];
                _payImageV.centerX = distribution.centerX;
                [bgView addSubview:_payImageV];
   
            }
        }
       
     
        //添加头像占位
        UIImageView *userImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10,_totalfee.bottom +20, 16, 16)];
        userImgV.image = [UIImage imageNamed:@"dingdan-yonghu"];
        [bgView addSubview:userImgV];
        //添加用户手机号码
        self.userName = [[UILabel alloc] initWithFrame:CGRectMake(userImgV.right + 5,_totalfee.bottom +20, 100, 20)];
        self.userName.textColor = RGBCOLOR(170, 170, 170);
        self.userName.font = [UIFont systemFontOfSize:15];
        [bgView addSubview:_userName];
        //添加时间
        self.creatLable  = [[UILabel alloc] initWithFrame:CGRectMake(_userName.right + 1, _totalfee.bottom +20, bgView.size.width - _userName.right -17, 20)];
        self.creatLable.textColor = RGBCOLOR(194, 194, 194);
        self.creatLable.font = [UIFont systemFontOfSize:13];
        self.creatLable.textAlignment = NSTextAlignmentRight;
        [bgView addSubview:_creatLable];
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  MyAccountDetailTableViewCell.m
//  MaiDan
//
//  Created by 潇哥 on 16/7/30.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MyAccountDetailTableViewCell.h"

@interface MyAccountDetailTableViewCell ()

@property (nonatomic, strong) UILabel *changeValue;
/** 税 */
@property (nonatomic, weak) UILabel *tax;
@property (nonatomic, strong) UILabel *date;
@property (nonatomic, strong) UILabel *source;
@property (nonatomic, strong) UILabel *balance;
/** 状态 */
@property (nonatomic, weak) UIImageView *statusImage;

@end

@implementation MyAccountDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    UILabel *changeValue = [UILabel new];
    changeValue.font = FONT_WITH_SIZE(18);
    changeValue.textColor = kTextColor1;
    [self.contentView addSubview:changeValue];
    self.changeValue = changeValue;
    
    [changeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@15);
    }];
    
    UILabel *tax = [UILabel new];
    tax.textColor = kTextColor3;
    tax.font = FONT_WITH_SIZE(13);
    tax.hidden = YES;
    [self.contentView addSubview:tax];
    self.tax = tax;
    
    [tax mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(changeValue.mas_right);
        make.centerY.equalTo(changeValue);
    }];
    
    UILabel *date = [UILabel new];
    date.font = FONT_WITH_SIZE(12);
    date.textColor = kTextColor3;
    [self.contentView addSubview:date];
    self.date = date;
    
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-15);
        make.centerY.equalTo(changeValue);
    }];
    
    UILabel *source = [UILabel new];
    source.font = FONT_WITH_SIZE(14);
    source.textColor = kTextColor2;
    [self.contentView addSubview:source];
    self.source = source;
    
    [source mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(changeValue.mas_left);
        make.bottom.equalTo(@-15);
    }];
    
    UILabel *balance = [UILabel new];
    balance.font = FONT_WITH_SIZE(15);
    balance.textColor = kTextColor3;
    [self.contentView addSubview:balance];
    self.balance = balance;
    
    [balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(date.mas_right);
        make.bottom.equalTo(source.mas_bottom);
    }];
    
    UIImageView *statusImage = [[UIImageView alloc] init];
    statusImage.hidden = YES;
    [self.contentView addSubview:statusImage];
    self.statusImage = statusImage;
    
    [statusImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(balance);
        make.right.equalTo(balance.mas_left).offset(-5);
    }];
    
    UIView *separator = [UIView new];
    separator.backgroundColor = kBackgroundColor;
    [self.contentView addSubview:separator];
    
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
}

- (void)configCellWithDict:(NSDictionary *)dict type:(MyAccountDetailType)type {
    
    if (type == MyAccountDetailTypeRecharge) {
        
        NSString *amount;
        amount = ([dict[@"total_fee"] floatValue] > 0 ? dict[@"total_fee"] : @"0");
        self.changeValue.text = [NSString stringWithFormat:@"+%@",amount];
        self.date.text = dict[@"createTime"];
        NSString *payType;
        if ([dict[@"pay_type"] integerValue] == 3) {
            payType = @"支付宝";
        } else if ([dict[@"pay_type"] integerValue] == 4) {
            payType = @"微信";
        }
        self.balance.text = [NSString stringWithFormat:@"%@",payType];
        [self.changeValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(self.contentView);
        }];
        [self.date mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.right.equalTo(@-15);
        }];
        
    } else if (type == MyAccountDetailTypeWithdraw) {
        
        self.changeValue.text = [NSString stringWithFormat:@"-%@",dict[@"cashWithdrawal"]];
        self.changeValue.textColor = kThemeColor;
        
        if ([dict[@"tax"] floatValue] > 0) {
            self.tax.hidden = NO;
            self.tax.text = [NSString stringWithFormat:@"（扣税%@）",dict[@"tax"]];
        } else {
            self.tax.hidden = YES;
        }
        
        self.date.text = dict[@"createTime"];
        
        NSMutableString *sourceText = [NSMutableString string];
        if ([dict[@"code"] boolValue]) {
            [sourceText appendString:@"分享币"];
            
            if ([dict[@"isInvoiced"] boolValue]) {
                [sourceText appendString:@"（提供发票）"];
            } else {
                [sourceText appendString:@"（不提供发票）"];
            }
        } else {
            [sourceText appendString:@"营业收入"];
        }
        
        self.source.text = sourceText;
    
        self.statusImage.hidden = NO;
        NSString *status;
        if ([dict[@"isPay"] integerValue]) {
            status = @"已完成";
            self.statusImage.image = [UIImage imageNamed:@"withdraw_status_done"];
        } else {
            status = @"处理中";
            self.statusImage.image = [UIImage imageNamed:@"withdraw_status_dealing"];
        }
        self.balance.text = status;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

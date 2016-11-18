//
//  IncomeTypeView.m
//  MaiDanSH
//
//  Created by lin on 16/11/9.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "IncomeTypeView.h"

@interface IncomeTypeView ()

/** 内容 */
@property (nonatomic, weak) UIView *contentView;
/** 收入金额 */
@property (nonatomic, weak) UILabel *incomeValue;
/** 收入类型 */
@property (nonatomic, weak) UILabel *incomeLabel;
/** 选择状态 */
@property (nonatomic, weak) UIImageView *selectedImage;

@end

@implementation IncomeTypeView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.width.equalTo(self);
        }];
        
        [self.incomeValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
        }];
        
        [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.incomeValue.mas_bottom).offset(5);
            make.left.right.equalTo(self.incomeValue);
        }];
        
        [self.selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.incomeLabel.mas_bottom).offset(15);
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}



#pragma mark - setters & getters

- (UIView *)contentView {
    if (!_contentView) {
        UIView *contentView = [UIView new];
        [self addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (UILabel *)incomeValue {
    if (!_incomeValue) {
        UILabel *incomeValue = [UILabel new];
        incomeValue.font = FONT_WITH_SIZE(22);
        incomeValue.textAlignment = NSTextAlignmentCenter;
        [incomeValue sizeToFit];
        [self.contentView addSubview:incomeValue];
        _incomeValue = incomeValue;
    }
    return _incomeValue;
}

- (UILabel *)incomeLabel {
    if (!_incomeLabel) {
        UILabel *incomeLabel = [UILabel new];
        incomeLabel.font = FONT_WITH_SIZE(14);
        incomeLabel.textColor = kTextColor2;
        incomeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:incomeLabel];
        _incomeLabel = incomeLabel;
    }
    return _incomeLabel;
}

- (UIImageView *)selectedImage {
    if (!_selectedImage) {
        UIImageView *selectedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"withdraw_selected"]];
        [self.contentView addSubview:selectedImage];
        _selectedImage = selectedImage;
    }
    return _selectedImage;
}

- (void)setIncome:(NSString *)income {
    _income = income;
    self.incomeValue.text = income;
}

- (void)setIncomeType:(NSString *)incomeType {
    _incomeType = incomeType;
    self.incomeLabel.text = incomeType;
}

- (void)setSelected:(BOOL)selected {
    
    _selected = selected;
    if (selected) {
        self.selectedImage.image = [UIImage imageNamed:@"withdraw_selected"];
    } else {
        self.selectedImage.image = [UIImage imageNamed:@"withdraw_unselected"];
    }
}

@end

//
//  ShareCoinWithdrawView.m
//  MaiDanSH
//
//  Created by lin on 16/11/11.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ShareCoinWithdrawView.h"
#import "InputView.h"

@interface ShareCoinWithdrawView ()

/** 扣税提醒 */
@property (nonatomic, weak) UILabel *tipsLabel;
/** 输入框 */
@property (nonatomic, weak) InputView *inputView;
/** 是否需要发票 */
@property (nonatomic, weak) UIButton *checkBox;

@end

@implementation ShareCoinWithdrawView

- (instancetype)init {
    if (self = [super init]) {
        
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self).offset(10);
        }];
        
        [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(5);
            make.height.equalTo(@50);
        }];
        
        [self.checkBox bk_addEventHandler:^(UIButton *sender) {
            
            sender.selected = !sender.selected;
            // 这里为了防止用户输入完成后，切换是否需要发票时，扣税信息无法展示
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kUserInputDone" object:nil];
            
        } forControlEvents:UIControlEventTouchUpInside];
        [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tipsLabel);
            make.top.equalTo(self.inputView.mas_bottom).offset(10);
            make.bottom.equalTo(self).offset(-10);
        }];
    }
    return self;
}


#pragma mark - setters & getters

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        UILabel *tipsLabel = [UILabel new];
        tipsLabel.textColor = kThemeColor;
        tipsLabel.font = FONT_WITH_SIZE(13);
        [self addSubview:tipsLabel];
        _tipsLabel = tipsLabel;
    }
    return _tipsLabel;
}

- (InputView *)inputView {
    if (!_inputView) {
        InputView *inputView = [InputView new];
        [self addSubview:inputView];
        _inputView = inputView;
    }
    return _inputView;
}

- (UIButton *)checkBox {
    if (!_checkBox) {
        UIButton *checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkBox setTitle:@"提供发票" forState:UIControlStateNormal];
        [checkBox.titleLabel setFont:FONT_WITH_SIZE(14)];
        [checkBox setTitleColor:kTextColor3 forState:UIControlStateNormal];
        [checkBox setImage:[UIImage imageNamed:@"withdraw_bill_unselected"] forState:UIControlStateNormal];
        [checkBox setImage:[UIImage imageNamed:@"withdraw_bill_selected"] forState:UIControlStateSelected];
        [checkBox setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
        [checkBox setContentEdgeInsets:UIEdgeInsetsMake(10, 0, 10, 30)];
        [checkBox sizeToFit];
        [checkBox setSelected:NO];
        [self addSubview:checkBox];
        _checkBox = checkBox;
    }
    return _checkBox;
}

- (void)setTips:(NSString *)tips {
    _tips = tips;
    self.tipsLabel.text = tips;
}

- (NSString *)text {
    return self.inputView.text;
}

- (BOOL)needBill {
    return self.checkBox.selected;
}

@end

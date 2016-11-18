//
//  InputView.m
//  MaiDanSH
//
//  Created by lin on 16/11/11.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "InputView.h"

@interface InputView() <UITextFieldDelegate>

/** 灰色背景 */
@property (nonatomic, weak) UIView *bgView;
/** 输入框 */
@property (nonatomic, weak) UITextField *textField;

@end

@implementation InputView

- (instancetype)init {
    if (self = [super init]) {
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.bottom.equalTo(self);
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(10);
            make.right.equalTo(self.bgView).offset(-10);
            make.top.equalTo(self.bgView).offset(5);
            make.bottom.equalTo(self.bgView).offset(-5);
        }];
    }
    return self;
}

#pragma mark - UITextField delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    // 用户输入完成
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kUserInputDone" object:nil];
}

#pragma mark - setters & getters

- (UIView *)bgView {
    if (!_bgView) {
        UIView *bgView = [UIView new];
        bgView.backgroundColor = kBackgroundColor;
        [bgView setCornerRadius:5];
        [self addSubview:bgView];
        _bgView = bgView;
    }
    return _bgView;
}

- (UITextField *)textField {
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @"请输入提现金额（100的倍数）";
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.delegate = self;
        [self.bgView addSubview:textField];
        _textField = textField;
    }
    return _textField;
}

- (void)setText:(NSString *)text {
    
}

- (NSString *)text {
    return self.textField.text;
}

@end

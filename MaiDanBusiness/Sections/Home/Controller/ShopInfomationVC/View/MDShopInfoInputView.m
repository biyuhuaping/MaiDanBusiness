//
//  MDShopInfoInputView.m
//  MaiDanBusiness
//
//  Created by lin on 16/11/17.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "MDShopInfoInputView.h"

@interface MDShopInfoInputView () <UITextFieldDelegate>
{
    NSString *_text;
}
/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 输入框 */
@property (nonatomic, weak) UITextField *textField;
/** 开关 */
@property (nonatomic, weak) UISwitch *switchControl;
/** 分割线 */
@property (nonatomic, weak) UIView *separateView;

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 是否必填 */
@property (nonatomic, assign) BOOL required;

@end

@implementation MDShopInfoInputView

#pragma mark - life cycle

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder required:(BOOL)required {
    if (self = [super init]) {
        self.title = title;
        self.placeholder = placeholder;
        self.required = required;
        [self setup];
    }
    return self;
}

/**
 *  实例化方法
 *
 *  @param  title           标题
 *  @param  placeholder     提示语
 *  @param  required        是否必填
 */
+ (instancetype)shopInfoInputViewWithTitle:(NSString *)title placeholder:(NSString *)placeholder required:(BOOL)required {
    return [[[self class] alloc] initWithTitle:title placeholder:placeholder required:required];
}

- (BOOL)resignFirstResponder {
    return [self.textField resignFirstResponder];
}

#pragma mark - setup UI

- (void)setup {
    
    self.backgroundColor = kWhiteColor;
    
    if (self.required) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@*",self.title];
        [self.titleLabel attributedTextWithText:@"*" font:14 textColor:kThemeColor];
    } else {
        self.titleLabel.text = self.title;
    }
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.equalTo(@70);
        make.centerY.equalTo(self);
    }];
    
    self.textField.placeholder = self.placeholder;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.right.equalTo(self).offset(-10);
    }];
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    // 用户开始编辑
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kUserBeginEditing" object:self];
}

#pragma mark - setters & getters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = kTextColor3;
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UITextField *)textField {
    if (!_textField) {
        UITextField *textField = [UITextField new];
        textField.textColor = kTextColor1;
        textField.font = FONT_WITH_SIZE(14);
        textField.delegate = self;
        [self addSubview:textField];
        _textField = textField;
    }
    return _textField;
}

- (UISwitch *)switchControl {
    if (!_switchControl) {
        UISwitch *switchControl = [[UISwitch alloc] init];
        switchControl.on = YES;
        [self addSubview:switchControl];
        _switchControl = switchControl;
    }
    return _switchControl;
}

- (UIView *)separateView {
    if (!_separateView) {
        UIView *separateView = [UIView new];
        separateView.backgroundColor = kBackgroundColor;
        [self addSubview:separateView];
        _separateView = separateView;
    }
    return _separateView;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textField.text = text;
}

- (NSString *)text {
    return self.textField.text;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    _keyboardType = keyboardType;
    self.textField.keyboardType = keyboardType;
}

- (void)setHasSwitch:(BOOL)hasSwitch {
    _hasSwitch = hasSwitch;
    
    if (hasSwitch) {
        
        self.switchControl.hidden = NO;
        [self.switchControl bk_addEventHandler:^(UISwitch *sender) {
            
            if (sender.isOn) {
                
                self.titleLabel.text = [NSString stringWithFormat:@"%@*",@"人均消费"];
                [self.titleLabel attributedTextWithText:@"*" font:14 textColor:kThemeColor];
            } else {
                
                self.titleLabel.text = [NSString stringWithFormat:@"%@*",@"单均消费"];
                [self.titleLabel attributedTextWithText:@"*" font:14 textColor:kThemeColor];
            }
        } forControlEvents:UIControlEventValueChanged];
        [self.switchControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(self.titleLabel.mas_centerY);
        }];

        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.switchControl.mas_left).offset(-10);
            make.left.equalTo(self.titleLabel.mas_right).offset(10);
            make.centerY.equalTo(self.titleLabel.mas_centerY);
        }];
//        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.switchControl.mas_left).offset(-10);
//        }];
//        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.switchControl.mas_left).offset(-10);
//        }];
    } else {
        self.switchControl.hidden = YES;
    }
}

- (BOOL)switchOn {
    return self.switchControl.on;
}

@end

//
//  MDShopBusinessHoursView.m
//  MaiDanBusiness
//
//  Created by 潇哥 on 2016/11/18.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "MDShopBusinessHoursView.h"

@interface MDShopBusinessHoursView () <UITextFieldDelegate>
{
    NSString *_startTime;
    NSString *_endTime;
}

/** 标题 */
@property (nonatomic, weak) UILabel *titleLabel;
/** 开始时间 */
@property (nonatomic, weak) UITextField *startTimeField;
/** 分割线 */
@property (nonatomic, weak) UILabel *separateView;
/** 结束时间 */
@property (nonatomic, weak) UITextField *endTimeField;

@end

@implementation MDShopBusinessHoursView

#pragma mark - life cycle

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

+ (instancetype)shopBusinessHoursView {
    return [[[self class] alloc] init];
}


#pragma mark - setup UI

- (void)setup {
    
    self.backgroundColor = kWhiteColor;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.equalTo(@70);
        make.centerY.equalTo(self);
    }];
    
    [self.startTimeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
    }];
    
    [self.separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startTimeField.mas_right).offset(10);
        make.centerY.equalTo(self.startTimeField);
    }];
    
    [self.endTimeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.separateView.mas_right).offset(10);
        make.centerY.equalTo(self.separateView);
    }];
}


#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    // 用户开始编辑
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kUserBeginEditing" object:self userInfo:@{@"tag" : @(textField.tag)}];
}

#pragma mark - setters & getters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"营业时间";
        titleLabel.textColor = kTextColor3;
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UITextField *)startTimeField {
    if (!_startTimeField) {
        UITextField *startTimeField = [UITextField new];
        startTimeField.placeholder = @"开始时间";
        startTimeField.textColor = kTextColor1;
        startTimeField.font = FONT_WITH_SIZE(14);
        startTimeField.tag = 100;
        startTimeField.delegate = self;
        [self addSubview:startTimeField];
        _startTimeField = startTimeField;
    }
    return _startTimeField;
}

- (UILabel *)separateView {
    if (!_separateView) {
        UILabel *separtor = [UILabel new];
        separtor.text = @"-";
        separtor.textColor = kTextColor1;
        [self addSubview:separtor];
        _separateView = separtor;
    }
    return _separateView;
}

- (UITextField *)endTimeField {
    if (!_endTimeField) {
        UITextField *endTimeField = [UITextField new];
        endTimeField.placeholder = @"结束时间";
        endTimeField.textColor = kTextColor1;
        endTimeField.font = FONT_WITH_SIZE(14);
        endTimeField.tag = 200;
        endTimeField.delegate = self;
        [self addSubview:endTimeField];
        _endTimeField = endTimeField;
    }
    return _endTimeField;
}

- (void)setStartTime:(NSString *)startTime {
    _startTime = startTime;
    self.startTimeField.text = startTime;
}

- (NSString *)startTime {
    return self.startTimeField.text;
}

- (void)setEndTime:(NSString *)endTime {
    _endTime = endTime;
    self.endTimeField.text = endTime;
}

- (NSString *)endTime {
    return self.endTimeField.text;
}

@end


//
//  ShopInfomationViewController.m
//  MaiDanSH
//
//  Created by lin on 16/10/18.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ShopInfomationViewController.h"
#import "MDCommercialTypeViewController.h"

#import "MDDatePickerView.h"

@interface ShopInfomationViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

/** 登录名 */
@property (nonatomic, weak) UILabel *loginNameLabel;
/** 邀请码 */
@property (nonatomic, weak) UILabel *invideCodeLabel;
/** 消费利润 */
@property (nonatomic, weak) UILabel *discountRateLabel;
/** 商家名 */
@property (nonatomic, weak) UILabel *shopNameLabel;
/** 商家类别 */
@property (nonatomic, weak) UITextField *shopTypeField;
/** 联系人 */
@property (nonatomic, weak) UITextField *linkManField;
/** 手机号 */
@property (nonatomic, weak) UITextField *phoneField;
/** 电话 */
@property (nonatomic, weak) UITextField *telField;
/** QQ号码 */
@property (nonatomic, weak) UITextField *qqField;
/** 邮箱 */
@property (nonatomic, weak) UITextField *emailField;
/** 地址 */
@property (nonatomic, weak) UITextField *addressField;
/** 人均消费 */
@property (nonatomic, weak) UITextField *perFeeField;
/** 单均消费 */
@property (nonatomic, weak) UISwitch *switchControl;
/** 消费多少 */
@property (nonatomic, weak) UITextField *xiaofeiField;
/** 赠送多少 */
@property (nonatomic, weak) UITextField *zsScoreField;
/** 优惠说明 */
@property (nonatomic, weak) UITextField *memoField;
/** 使用说明 */
@property (nonatomic, weak) UITextField *contentField;
/** 优惠起始 */
@property (nonatomic, weak) UITextField *useStartField;
/** 优惠结束 */
@property (nonatomic, weak) UITextField *useEndField;
/** 营业开始时间 */
@property (nonatomic, weak) UITextField *openStartField;
/** 营业结束时间 */
@property (nonatomic, weak) UITextField *endStartField;

/** 省 */
@property (nonatomic, copy) NSString *province;
/** 市 */
@property (nonatomic, copy) NSString *city;
/** 区 */
@property (nonatomic, copy) NSString *region;
/** 商户类别 */
@property (nonatomic, copy) NSString *typeId;
@end

@implementation ShopInfomationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户信息";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, G_SCREEN_WIDTH, G_SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self getShopInfo];
}


- (void)setupTableFooterView {
    
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, G_SCREEN_WIDTH, 80)];
    tableFooterView.backgroundColor = kBackgroundColor;
    self.tableView.tableFooterView = tableFooterView;
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [submitBtn setTitle:@"保存" forState:UIControlStateNormal];
    [submitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:kThemeColor];
    [submitBtn setFrame:CGRectMake(15, 15, G_SCREEN_WIDTH - 30, 45)];
    [submitBtn setCornerRadius:5];
    [submitBtn bk_addEventHandler:^(id sender) {
        NSLog(@"保存");
        
        if (!self.linkManField.text.length) {
            [SVProgressHUD showErrorWithStatus:@"联系人不能为空！"];
            return;
        }
        
        if (!self.phoneField.text.length) {
            [SVProgressHUD showErrorWithStatus:@"手机号不能为空！"];
            return;
        }
        
        if (!self.addressField.text.length) {
            [SVProgressHUD showErrorWithStatus:@"详细地址不能为空！"];
            return;
        }
        
        if (!self.perFeeField.text.length) {
            if (self.switchControl.isOn) {
                [SVProgressHUD showErrorWithStatus:@"人均消费不能为空！"];
            } else {
                [SVProgressHUD showErrorWithStatus:@"单均消费不能为空！"];
            }
            return;
        }
        
        if (!self.xiaofeiField.text.length) {
            [SVProgressHUD showErrorWithStatus:@"消费多少不能为空！"];
            return;
        }
        
        if (!self.zsScoreField.text.length) {
            [SVProgressHUD showErrorWithStatus:@"赠送多少不能为空！"];
            return;
        }
        
        [self updateShopInfo];
    } forControlEvents:UIControlEventTouchUpInside];
    [tableFooterView addSubview:submitBtn];
    
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

/**
 *  获取商家信息
 */
- (void)getShopInfo {
    
    [[API shareAPI] getShopInfo:^(id responseData) {
        NSLog(@"shopInfo = %@",responseData);
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            
            NSDictionary *dict = responseData[@"json_val"][@"info"];
            NSMutableArray *section1 = [NSMutableArray array];
            [section1 addObject:@{ @"title"     : @"登录名",
                                   @"subTitle"  : dict[@"loginName"]}];
            [section1 addObject:@{ @"title"     : @"邀请码",
                                   @"subTitle"  : dict[@"inviteCode"]}];
            [section1 addObject:@{ @"title"     : @"消费利润",
                                   @"subTitle"  : dict[@"discountRate"]}];
            [self.dataArray addObject:section1];
            
            NSMutableArray *section2 = [NSMutableArray array];
            [section2 addObject:@{ @"title"     : @"商家名",
                                   @"subTitle"  : dict[@"shopName"]}];
            NSString *shopType = [NSString stringWithFormat:@"%@-%@",responseData[@"json_val"][@"shopType"],responseData[@"json_val"][@"shopType2"]];
            [section2 addObject:@{ @"title"     : @"商家类别",
                                   @"subTitle"  : shopType}];
            self.typeId = dict[@"shopType"];
            [self.dataArray addObject:section2];
            
            NSMutableArray *section4 = [NSMutableArray array];
            [section4 addObject:@{ @"title"     : @"联系人",
                                   @"subTitle"  : dict[@"linkMan"]}];
            [section4 addObject:@{ @"title"     : @"手机号",
                                   @"subTitle"  : dict[@"phone"]}];
            [section4 addObject:@{ @"title"     : @"电话",
                                   @"subTitle"  : dict[@"tel"]}];
            [section4 addObject:@{ @"title"     : @"QQ号码",
                                   @"subTitle"  : dict[@"qq"]}];
            [section4 addObject:@{ @"title"     : @"邮箱",
                                   @"subTitle"  : dict[@"email"]}];
            NSString *province = [NSString stringWithFormat:@"%@ %@ %@",dict[@"province"],dict[@"city"],dict[@"region"]];
            [section4 addObject:@{ @"title"     : @"省/市/区",
                                   @"subTitle"  : province}];
            [section4 addObject:@{ @"title"     : @"详细地址",
                                   @"subTitle"  : dict[@"address"]}];
            [self.dataArray addObject:section4];
            
            NSMutableArray *section3 = [NSMutableArray array];
            if ([dict[@"perFeeType"] integerValue] == 1) {
                [section3 addObject:@{ @"title"     : @"人均消费",
                                       @"subTitle"  : dict[@"perFee"]}];
            } else {
                [section3 addObject:@{ @"title"     : @"单均消费",
                                       @"subTitle"  : dict[@"perFee"]}];
            }
            [section3 addObject:@{ @"title"     : @"消费多少",
                                   @"subTitle"  : dict[@"xiaofei"]}];
            [section3 addObject:@{ @"title"     : @"赠送多少",
                                   @"subTitle"  : dict[@"zs_score"]}];
            [section3 addObject:@{ @"title"     : @"活动说明",
                                   @"subTitle"  : dict[@"memo"]}];
            [section3 addObject:@{ @"title"     : @"使用说明",
                                   @"subTitle"  : dict[@"content"]}];
            [section3 addObject:@{ @"title"     : @"优惠起始",
                                   @"subTitle"  : responseData[@"json_val"][@"useStartTime"]}];
            [section3 addObject:@{ @"title"     : @"优惠结束",
                                   @"subTitle"  : responseData[@"json_val"][@"useEndTime"]}];
            [self.dataArray addObject:section3];
            
            NSMutableArray *section7 = [NSMutableArray array];
            NSString *time = @"";
            if ([dict[@"startTime"] length] || [dict[@"endTime"] length]) {
                time = [NSString stringWithFormat:@"%@ - %@",dict[@"startTime"],dict[@"endTime"]];
            }
            [section7 addObject:@{ @"title"     : @"营业时间",
                                   @"subTitle"  : time}];
            [self.dataArray addObject:section7];
            
            [self setupTableFooterView];
            [self.tableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:responseData[@"json_error"]];
        }
    }];
}

- (void)updateShopInfo {
    
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    NSString *strShopID = [config objectForKey:G_SHOP_ID];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:strShopID forKey:@"id"];
    [parameters setValue:self.linkManField.text forKey:@"linkMan"];
    [parameters setValue:self.phoneField.text forKey:@"phone"];
    [parameters setValue:self.addressField.text forKey:@"address"];
    [parameters setValue:self.emailField.text forKey:@"email"];
    [parameters setValue:self.perFeeField.text forKey:@"perFee"];
    if (self.switchControl.on) {
        [parameters setValue:@"1" forKey:@"perFeeType"];
    } else {
        [parameters setValue:@"2" forKey:@"perFeeType"];
    }
    [parameters setValue:self.xiaofeiField.text forKey:@"xiaofei"];
    [parameters setValue:self.zsScoreField.text forKey:@"zs_score"];
    [parameters setValue:self.province forKey:@"provinceId"];
    [parameters setValue:self.city forKey:@"cityId"];
    [parameters setValue:self.region forKey:@"regionId"];
    [parameters setValue:self.useEndField.text forKey:@"useEndTime"];
    [parameters setValue:self.useStartField.text forKey:@"useStartTime"];
    [parameters setValue:self.openStartField.text forKey:@"openStartTime"];
    [parameters setValue:self.endStartField.text forKey:@"endStartTime"];
    [parameters setValue:self.typeId forKey:@"shopType"];
    [parameters setValue:self.memoField.text forKey:@"memo"];
    
    NSLog(@"parameters = %@",parameters);
    [[API shareAPI] updateShopInfoWithParameters:parameters completion:^(id responseData) {
        NSLog(@"updateShopInfo = %@",responseData);
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            [SVProgressHUD showSuccessWithStatus:responseData[@"json_val"]];
        } else {
            [SVProgressHUD showErrorWithStatus:responseData[@"json_error"]];
        }
    }];
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = self.dataArray[indexPath.section][indexPath.row];
    NSString *kCellReuseIdentify = [NSString stringWithFormat:@"%zd-%zd",indexPath.section,indexPath.row];
//    static NSString *kCellReuseIdentify = @"kCellReuseIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellReuseIdentify];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.textColor = kTextColor2;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        if ((indexPath.section == 0) ||
            (indexPath.section == 1 && indexPath.row == 0) ||
            (indexPath.section == 2 && indexPath.row == 5)) {
            // label
            UILabel *descLabel = [UILabel new];
            descLabel.textColor = kTextColor1;
            descLabel.font = [UIFont systemFontOfSize:14];
            descLabel.tag = 100;
            descLabel.numberOfLines = 0;
            [cell.contentView addSubview:descLabel];
            
            [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(100);
                make.right.equalTo(cell.contentView).offset(-10);
                make.centerY.equalTo(cell.contentView);
            }];
            
            if (indexPath.section == 0 && indexPath.row == 0) {
                self.loginNameLabel = descLabel;
            } else if (indexPath.section == 0 && indexPath.row == 1) {
                self.invideCodeLabel = descLabel;
            } else if (indexPath.section == 0 && indexPath.row == 2) {
                self.discountRateLabel = descLabel;
            } else if (indexPath.section == 1 && indexPath.row == 0) {
                self.shopNameLabel = descLabel;
            }
            
        }
        else if (indexPath.section == 4) {
            // double textfield
            UITextField *startTimeField = [UITextField new];
            startTimeField.placeholder = @"开始时间";
            startTimeField.textColor = kTextColor1;
            startTimeField.font = [UIFont systemFontOfSize:14];
            startTimeField.delegate = self;
            [cell.contentView addSubview:startTimeField];
            self.openStartField = startTimeField;
            
            [startTimeField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(100);
                make.centerY.equalTo(cell.contentView);
            }];
            
            UILabel *separtor = [UILabel new];
            separtor.text = @"-";
            separtor.textColor = kTextColor1;
            [cell.contentView addSubview:separtor];
            
            [separtor mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(startTimeField.mas_right).offset(20);
                make.centerY.equalTo(startTimeField);
            }];
            
            UITextField *endTimeField = [UITextField new];
            endTimeField.placeholder = @"结束时间";
            endTimeField.textColor = kTextColor1;
            endTimeField.font = [UIFont systemFontOfSize:14];
            endTimeField.delegate = self;
            [cell.contentView addSubview:endTimeField];
            self.endStartField = endTimeField;
            
            [endTimeField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(separtor.mas_right).offset(20);
                make.centerY.equalTo(cell.contentView);
            }];
            
        }
//        else if (indexPath.section == 3 && indexPath.row == 3) {
//            // textview
//        }
        else {
            
            UITextField *textField = [UITextField new];
            textField.textColor = kTextColor1;
            textField.font = [UIFont systemFontOfSize:14];
            textField.tag = indexPath.section * 10 + indexPath.row;
            textField.delegate = self;
            [cell.contentView addSubview:textField];
            
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView).offset(100);
                make.right.equalTo(cell.contentView).offset(-10);
                make.top.bottom.equalTo(cell.contentView);
            }];
            
            if (indexPath.section == 1 && indexPath.row == 1) {
                textField.placeholder = @"请填写商家类别";
                self.shopTypeField = textField;
            } else if (indexPath.section == 2 && indexPath.row == 0) {
                textField.placeholder = @"请填写联系人";
                self.linkManField = textField;
            } else if (indexPath.section == 2 && indexPath.row == 1) {
                textField.placeholder = @"请填写手机号";
                textField.keyboardType = UIKeyboardTypeNumberPad;
                self.phoneField = textField;
            } else if (indexPath.section == 2 && indexPath.row == 2) {
                textField.placeholder = @"请填写电话";
                textField.keyboardType = UIKeyboardTypeNumberPad;
                self.telField = textField;
            } else if (indexPath.section == 2 && indexPath.row == 3) {
                textField.placeholder = @"请填写QQ号";
                textField.keyboardType = UIKeyboardTypeNumberPad;
                self.qqField = textField;
            } else if (indexPath.section == 2 && indexPath.row == 4) {
                textField.placeholder = @"请填写邮箱地址";
                self.emailField = textField;
            } else if (indexPath.section == 2 && indexPath.row == 6) {
                textField.placeholder = @"请填写详细地址";
                self.addressField = textField;
            } else if (indexPath.section == 3 && indexPath.row == 0) {
                textField.placeholder = @"请填写人均消费";
                textField.keyboardType = UIKeyboardTypeDecimalPad;
                self.perFeeField = textField;
                
                UISwitch *switchControl = [[UISwitch alloc] init];
                switchControl.on = YES;
                [switchControl bk_addEventHandler:^(id sender) {
                    
                    if (switchControl.isOn) {
                        cell.textLabel.attributedText = [self stringToRequiredString:@"人均消费"];
                    } else {
                        cell.textLabel.attributedText = [self stringToRequiredString:@"单均消费"];
                    }
                } forControlEvents:UIControlEventValueChanged];
                cell.accessoryView = switchControl;
                self.switchControl = switchControl;
                
            } else if (indexPath.section == 3 && indexPath.row == 1) {
                textField.placeholder = @"请填写消费金额";
                textField.keyboardType = UIKeyboardTypeDecimalPad;
                self.xiaofeiField = textField;
            } else if (indexPath.section == 3 && indexPath.row == 2) {
                textField.placeholder = @"请填写赠送金额";
                textField.keyboardType = UIKeyboardTypeDecimalPad;
                self.zsScoreField = textField;
            } else if (indexPath.section == 3 && indexPath.row == 3) {
                textField.placeholder = @"请填写优惠说明";
                self.memoField = textField;
            } else if (indexPath.section == 3 && indexPath.row == 4) {
                textField.placeholder = @"请填写使用说明";
                self.contentField = textField;
            } else if (indexPath.section == 3 && indexPath.row == 5) {
                textField.placeholder = @"请选择开始时间";
                self.useStartField = textField;
            } else if (indexPath.section == 3 && indexPath.row == 6) {
                textField.placeholder = @"请选择结束时间";
                self.useEndField = textField;
            }
            
        }
    }
    
    if ((indexPath.section == 2 && indexPath.row == 0) ||
        (indexPath.section == 2 && indexPath.row == 1) ||
        (indexPath.section == 2 && indexPath.row == 6) ||
        (indexPath.section == 3 && indexPath.row == 0) ||
        (indexPath.section == 3 && indexPath.row == 1) ||
        (indexPath.section == 3 && indexPath.row == 2)) {
        cell.textLabel.attributedText = [self stringToRequiredString:dict[@"title"]];
    } else {
        cell.textLabel.text = dict[@"title"];
    }
    
    UILabel *descLabel = (UILabel *)[cell viewWithTag:100];
    descLabel.text = dict[@"subTitle"];
    
    UITextField *textField = (UITextField *)[cell viewWithTag:indexPath.section * 10 + indexPath.row];
    textField.text = dict[@"subTitle"];
    
    return cell;
}


/**
 *  字符串加*
 */
- (NSAttributedString *)stringToRequiredString:(NSString *)str {
    
    NSMutableAttributedString *richText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@*",str]];
    // 设置字体颜色
    [richText addAttribute:NSForegroundColorAttributeName value:kThemeColor range:NSMakeRange(str.length, 1)];
    // 设置字体大小
    [richText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(str.length, 1)];
    return richText;
}

#pragma mark - <UITextFieldDelegate>

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == self.useStartField) {
        
        MDDatePickerView *datePicker = [MDDatePickerView shareInstance];
        [datePicker setPickerMode:UIDatePickerModeDate];
        datePicker.block = ^(NSString *date) {
            self.useStartField.text = date;
        };
        [self.view addSubview:datePicker];
        [textField resignFirstResponder];
    } else if (textField == self.useEndField) {
        
        MDDatePickerView *datePicker = [MDDatePickerView shareInstance];
        [datePicker setPickerMode:UIDatePickerModeDate];
        datePicker.block = ^(NSString *date) {
            self.useEndField.text = date;
        };
        [self.view addSubview:datePicker];
        [textField resignFirstResponder];
    } else if (textField == self.openStartField) {
        
        MDDatePickerView *datePicker = [MDDatePickerView shareInstance];
        [datePicker setPickerMode:UIDatePickerModeTime];
        datePicker.block = ^(NSString *date) {
            self.openStartField.text = date;
        };
        [self.view addSubview:datePicker];
        [textField resignFirstResponder];
    } else if (textField == self.endStartField) {
        
        MDDatePickerView *datePicker = [MDDatePickerView shareInstance];
        [datePicker setPickerMode:UIDatePickerModeTime];
        datePicker.block = ^(NSString *date) {
            self.endStartField.text = date;
        };
        [self.view addSubview:datePicker];
        [textField resignFirstResponder];
    } else if (textField == self.shopTypeField) {
        
        MDCommercialTypeViewController *typeVC = [MDCommercialTypeViewController new];
        typeVC.shopTypeBlock = ^(NSString *typeName,NSString *typeId) {
            self.shopTypeField.text = typeName;
            self.typeId = typeId;
        };
        [self.navigationController pushViewController:typeVC animated:YES];
        [textField resignFirstResponder];
    }
}








@end

//
//  MDShopInfoViewController.m
//  MaiDanBusiness
//
//  Created by 潇哥 on 2016/11/17.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "MDShopInfoViewController.h"
#import "MDCommercialTypeViewController.h"

#import "MDShopInfoInputView.h"
#import "MDShopBusinessHoursView.h"
#import "MDDatePickerView.h"

#import "MDShopInfoModel.h"

@interface MDShopInfoViewController ()

/** 滚动视图 */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 登录名 */
@property (nonatomic, weak) MDShopInfoInputView *loginNameView;
/** 邀请码 */
@property (nonatomic, weak) MDShopInfoInputView *inviteCodeView;
/** 消费利润 */
@property (nonatomic, weak) MDShopInfoInputView *discountRateView;
/* 商家名称 */
@property (nonatomic, weak) MDShopInfoInputView *shopNameView;
/* 商家类别 */
@property (nonatomic, weak) MDShopInfoInputView *shopTypeView;
/* 联系人 */
@property (nonatomic, weak) MDShopInfoInputView *linkManView;
/* 手机 */
@property (nonatomic, weak) MDShopInfoInputView *phoneView;
/* 电话 */
@property (nonatomic, weak) MDShopInfoInputView *telView;
/* QQ号码 */
@property (nonatomic, weak) MDShopInfoInputView *qqView;
/* 邮箱 */
@property (nonatomic, weak) MDShopInfoInputView *emailView;
/* 省/市/区 */
@property (nonatomic, weak) MDShopInfoInputView *provinceView;
/* 详细地址 */
@property (nonatomic, weak) MDShopInfoInputView *addressView;
/* 人均/单均消费 */
@property (nonatomic, weak) MDShopInfoInputView *perFeeView;
/* 活动说明 */
@property (nonatomic, weak) MDShopInfoInputView *memoView;
/* 使用说明 */
@property (nonatomic, weak) MDShopInfoInputView *contentView;
/* 优惠起始 */
@property (nonatomic, weak) MDShopInfoInputView *useStartView;
/* 优惠结束 */
@property (nonatomic, weak) MDShopInfoInputView *useEndView;
/* 营业时间 */
@property (nonatomic, weak) MDShopBusinessHoursView *businessHoursView;
/** 保存按钮 */
@property (nonatomic, weak) UIButton *saveBtn;

/* 商户信息 */
@property (nonatomic, strong) MDShopInfoModel *infoModel;
/** 商户id */
@property (nonatomic, copy) NSString *typeId;

@end

@implementation MDShopInfoViewController


#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"商户信息";
    [self setup];
    [self requestShopInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userBeginEditing:) name:@"kUserBeginEditing" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"dealloc");
}

#pragma mark - request method

/**
 *  获取商家信息
 */
- (void)requestShopInfo {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [[API shareAPI] getShopInfo:^(id responseData) {
        NSLog(@"shopInfo = %@",responseData);
        [SVProgressHUD dismiss];
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            
            MDShopInfoModel *model = [MDShopInfoModel mj_objectWithKeyValues:responseData[@"json_val"][@"info"]];
            model.shopType = responseData[@"json_val"][@"shopType"];
            model.shopType2 = responseData[@"json_val"][@"shopType2"];
            model.useStartTime = responseData[@"json_val"][@"useStartTime"];
            model.useEndTime = responseData[@"json_val"][@"useEndTime"];
            self.typeId = responseData[@"json_val"][@"info"][@"shopType"];
            self.infoModel = model;
            [self update];
        } else {
            [SVProgressHUD showErrorWithStatus:responseData[@"json_error"]];
        }
    }];
}

/**
 *  修改商家信息
 */
- (void)requestUpdateShopInfo {
    
    NSString *strShopID = [[API shareAPI] getLocalData:G_SHOP_ID];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:strShopID forKey:@"id"];
    [parameters setValue:self.linkManView.text forKey:@"linkMan"];
    [parameters setValue:self.phoneView.text forKey:@"phone"];
    [parameters setValue:self.addressView.text forKey:@"address"];
    [parameters setValue:self.emailView.text forKey:@"email"];
    [parameters setValue:self.perFeeView.text forKey:@"perFee"];
    if (self.perFeeView.switchOn) {
        [parameters setValue:@"1" forKey:@"perFeeType"];
    } else {
        [parameters setValue:@"2" forKey:@"perFeeType"];
    }
    [parameters setValue:self.infoModel.province forKey:@"provinceId"];
    [parameters setValue:self.infoModel.city forKey:@"cityId"];
    [parameters setValue:self.infoModel.region forKey:@"regionId"];
    [parameters setValue:self.useEndView.text forKey:@"useEndTime"];
    [parameters setValue:self.useStartView.text forKey:@"useStartTime"];
    [parameters setValue:self.businessHoursView.startTime forKey:@"openStartTime"];
    [parameters setValue:self.businessHoursView.endTime forKey:@"endStartTime"];
    [parameters setValue:self.typeId forKey:@"shopType"];
    [parameters setValue:self.memoView.text forKey:@"memo"];
    
    NSLog(@"parameters = %@",parameters);
    [[API shareAPI] updateShopInfoWithParameters:parameters completion:^(id responseData) {
        NSLog(@"updateShopInfo = %@",responseData);
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            [SVProgressHUD showSuccessWithStatus:responseData[@"json_val"]];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:responseData[@"json_error"]];
        }
    }];
}


#pragma mark - setup UI

- (void)setup {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.loginNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.equalTo(self.scrollView);
        make.height.equalTo(@44);
        make.width.equalTo(@(G_SCREEN_WIDTH));
    }];
    
    [self.inviteCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.loginNameView);
        make.top.equalTo(self.loginNameView.mas_bottom).offset(1);
    }];
    
    [self.discountRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.inviteCodeView);
        make.top.equalTo(self.inviteCodeView.mas_bottom).offset(1);
    }];
    
    [self.shopNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.discountRateView);
        make.top.equalTo(self.discountRateView.mas_bottom).offset(10);
    }];
    
    [self.shopTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.shopNameView);
        make.top.equalTo(self.shopNameView.mas_bottom).offset(1);
    }];
    
    [self.linkManView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.shopTypeView);
        make.top.equalTo(self.shopTypeView.mas_bottom).offset(10);
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.linkManView);
        make.top.equalTo(self.linkManView.mas_bottom).offset(1);
    }];
    
    [self.telView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.phoneView);
        make.top.equalTo(self.phoneView.mas_bottom).offset(1);
    }];
    
    [self.qqView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.telView);
        make.top.equalTo(self.telView.mas_bottom).offset(1);
    }];
    
    [self.emailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.qqView);
        make.top.equalTo(self.qqView.mas_bottom).offset(1);
    }];
    
    [self.provinceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.emailView);
        make.top.equalTo(self.emailView.mas_bottom).offset(1);
    }];
    
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.provinceView);
        make.top.equalTo(self.provinceView.mas_bottom).offset(1);
    }];
    
    [self.perFeeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.addressView);
        make.top.equalTo(self.addressView.mas_bottom).offset(10);
    }];
    
    [self.memoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.perFeeView);
        make.top.equalTo(self.perFeeView.mas_bottom).offset(1);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.memoView);
        make.top.equalTo(self.memoView.mas_bottom).offset(1);
    }];
    
    [self.useStartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_bottom).offset(1);
    }];
    
    [self.useEndView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.useStartView);
        make.top.equalTo(self.useStartView.mas_bottom).offset(1);
    }];
    
    [self.businessHoursView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.useEndView);
        make.top.equalTo(self.useEndView.mas_bottom).offset(10);
    }];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.businessHoursView).offset(15);
        make.right.equalTo(self.businessHoursView).offset(-15);
        make.height.equalTo(self.businessHoursView);
        make.top.equalTo(self.businessHoursView.mas_bottom).offset(20);
    }];
    
    [self.view layoutIfNeeded];
    
    self.scrollView.contentSize = CGSizeMake(G_SCREEN_WIDTH, self.saveBtn.bottom + 20);
}

- (void)update {
    
    self.loginNameView.text = self.infoModel.loginName;
    self.inviteCodeView.text = self.infoModel.inviteCode;
    self.discountRateView.text = self.infoModel.discountRate;
    self.shopNameView.text = self.infoModel.shopName;
    self.shopTypeView.text = [NSString stringWithFormat:@"%@-%@",self.infoModel.shopType,self.infoModel.shopType2];
    self.linkManView.text = self.infoModel.linkMan;
    self.phoneView.text = self.infoModel.phone;
    self.telView.text = self.infoModel.tel;
    self.qqView.text = self.infoModel.qq;
    self.emailView.text = self.infoModel.email;
    self.provinceView.text = [NSString stringWithFormat:@"%@%@%@",self.infoModel.province,self.infoModel.city,self.infoModel.region];
    self.addressView.text = self.infoModel.address;
    self.perFeeView.text = self.infoModel.perFee;
    self.memoView.text = self.infoModel.memo;
    self.contentView.text = self.infoModel.content;
    self.useStartView.text = self.infoModel.useStartTime;
    self.useEndView.text = self.infoModel.useEndTime;
    self.businessHoursView.startTime = self.infoModel.openStartTime;
    self.businessHoursView.endTime = self.infoModel.endStartTime;
}

#pragma mark - method response

/**
 *  用户开始编辑的代理方法
 */
- (void)userBeginEditing:(NSNotification *)nc {
    
    UIView *view = nc.object;
    if ([view isKindOfClass:[MDShopBusinessHoursView class]]) {
        NSInteger tag = [nc.userInfo[@"tag"] integerValue];
        if (tag == 100) {
            // 选择开始时间
            MDDatePickerView *datePicker = [MDDatePickerView shareInstance];
            [datePicker setPickerMode:UIDatePickerModeTime];
            datePicker.block = ^(NSString *date) {
                self.businessHoursView.startTime = date;
            };
            [self.view addSubview:datePicker];
        } else {
            // 选择结束时间
            MDDatePickerView *datePicker = [MDDatePickerView shareInstance];
            [datePicker setPickerMode:UIDatePickerModeTime];
            datePicker.block = ^(NSString *date) {
                self.businessHoursView.endTime = date;
            };
            [self.view addSubview:datePicker];
        }
        [self.view endEditing:YES];
    } else {
        
        
        MDShopInfoInputView *inputView = (MDShopInfoInputView *)view;
        
        if ([inputView isEqual:self.shopTypeView]) {
            
            // 选择商户类别
            MDCommercialTypeViewController *typeVC = [MDCommercialTypeViewController new];
            typeVC.shopTypeBlock = ^(NSString *typeName,NSString *typeId) {
                self.shopTypeView.text = typeName;
                self.typeId = typeId;
            };
            [self.navigationController pushViewController:typeVC animated:YES];
//            [self.view endEditing:YES];
            [inputView resignFirstResponder];
        } else if ([inputView isEqual:self.useStartView]) {
            
            // 选择优惠起始时间
            MDDatePickerView *datePicker = [MDDatePickerView shareInstance];
            [datePicker setPickerMode:UIDatePickerModeDate];
            datePicker.block = ^(NSString *date) {
                self.useStartView.text = date;
            };
            [self.view addSubview:datePicker];
            [self.view endEditing:YES];
        } else if ([inputView isEqual:self.useEndView]) {
            
            // 选择优惠结束时间
            MDDatePickerView *datePicker = [MDDatePickerView shareInstance];
            [datePicker setPickerMode:UIDatePickerModeDate];
            datePicker.block = ^(NSString *date) {
                self.useEndView.text = date;
            };
            [self.view addSubview:datePicker];
            [self.view endEditing:YES];
        }
    }
    
    
}

- (void)saveBtnClicked:(UIButton *)sender {
    
    if (!self.linkManView.text.length) {
        [SVProgressHUD showErrorWithStatus:@"联系人不能为空！"];
        return;
    }
    
    if (!self.phoneView.text.length) {
        [SVProgressHUD showErrorWithStatus:@"手机号不能为空！"];
        return;
    }
    
    if (!self.addressView.text.length) {
        [SVProgressHUD showErrorWithStatus:@"详细地址不能为空！"];
        return;
    }
    
    if (!self.perFeeView.text.length) {
        if (self.perFeeView.switchOn) {
            [SVProgressHUD showErrorWithStatus:@"人均消费不能为空！"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"单均消费不能为空！"];
        }
        return;
    }
    
    [self requestUpdateShopInfo];
}

#pragma mark - setters & getters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.backgroundColor = kBackgroundColor;
        scrollView.contentSize = CGSizeMake(G_SCREEN_WIDTH, G_SCREEN_HEIGHT);
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (MDShopInfoInputView *)loginNameView {
    if (!_loginNameView) {
        MDShopInfoInputView *loginNameView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"登录名" placeholder:@"请填写登录名" required:NO];
        loginNameView.userInteractionEnabled = NO;
        [self.scrollView addSubview:loginNameView];
        _loginNameView = loginNameView;
    }
    return _loginNameView;
}

- (MDShopInfoInputView *)inviteCodeView {
    if (!_inviteCodeView) {
        MDShopInfoInputView *inviteCodeView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"邀请码" placeholder:@"请填写邀请码" required:NO];
        inviteCodeView.userInteractionEnabled = NO;
        [self.scrollView addSubview:inviteCodeView];
        _inviteCodeView = inviteCodeView;
    }
    return _inviteCodeView;
}

- (MDShopInfoInputView *)discountRateView {
    if (!_discountRateView) {
        MDShopInfoInputView *discountRateView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"消费利润" placeholder:@"请填写消费利润" required:NO];
        discountRateView.userInteractionEnabled = NO;
        [self.scrollView addSubview:discountRateView];
        _discountRateView = discountRateView;
    }
    return _discountRateView;
}

- (MDShopInfoInputView *)shopNameView {
    if (!_shopNameView) {
        MDShopInfoInputView *shopNameView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"商户名称" placeholder:@"请填写商户名称" required:NO];
        shopNameView.userInteractionEnabled = NO;
        [self.scrollView addSubview:shopNameView];
        _shopNameView = shopNameView;
    }
    return _shopNameView;
}

- (MDShopInfoInputView *)shopTypeView {
    if (!_shopTypeView) {
        MDShopInfoInputView *shopTypeView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"商户类别" placeholder:@"请填写商户类别" required:NO];
        [self.scrollView addSubview:shopTypeView];
        _shopTypeView = shopTypeView;
    }
    return _shopTypeView;
}

- (MDShopInfoInputView *)linkManView {
    if (!_linkManView) {
        MDShopInfoInputView *linkManView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"联系人" placeholder:@"请填写联系人" required:YES];
        [self.scrollView addSubview:linkManView];
        _linkManView = linkManView;
    }
    return _linkManView;
}

- (MDShopInfoInputView *)phoneView {
    if (!_phoneView) {
        MDShopInfoInputView *phoneView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"手机" placeholder:@"请填写手机号" required:YES];
        phoneView.keyboardType = UIKeyboardTypeNumberPad;
        [self.scrollView addSubview:phoneView];
        _phoneView = phoneView;
    }
    return _phoneView;
}

- (MDShopInfoInputView *)telView {
    if (!_telView) {
        MDShopInfoInputView *telView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"电话" placeholder:@"请填写电话号" required:NO];
        telView.keyboardType = UIKeyboardTypeNumberPad;
        [self.scrollView addSubview:telView];
        _telView = telView;
    }
    return _telView;
}

- (MDShopInfoInputView *)qqView {
    if (!_qqView) {
        MDShopInfoInputView *qqView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"QQ号码" placeholder:@"请填写QQ号码" required:NO];
        qqView.keyboardType = UIKeyboardTypeNumberPad;
        [self.scrollView addSubview:qqView];
        _qqView = qqView;
    }
    return _qqView;
}

- (MDShopInfoInputView *)emailView {
    if (!_emailView) {
        MDShopInfoInputView *emailView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"邮箱" placeholder:@"请填写邮箱" required:NO];
        emailView.keyboardType = UIKeyboardTypeEmailAddress;
        [self.scrollView addSubview:emailView];
        _emailView = emailView;
    }
    return _emailView;
}

- (MDShopInfoInputView *)provinceView {
    if (!_provinceView) {
        MDShopInfoInputView *provinceView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"省/市/区" placeholder:@"请填写省/市/区" required:NO];
        provinceView.userInteractionEnabled = NO;
        [self.scrollView addSubview:provinceView];
        _provinceView = provinceView;
    }
    return _provinceView;
}

- (MDShopInfoInputView *)addressView {
    if (!_addressView) {
        MDShopInfoInputView *addressView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"详细地址" placeholder:@"请填写详细地址" required:YES];
        [self.scrollView addSubview:addressView];
        _addressView = addressView;
    }
    return _addressView;
}

- (MDShopInfoInputView *)perFeeView {
    if (!_perFeeView) {
        MDShopInfoInputView *perFeeView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"人均消费" placeholder:@"请填写人均消费" required:YES];
        perFeeView.keyboardType = UIKeyboardTypeDecimalPad;
        perFeeView.hasSwitch = YES;
        [self.scrollView addSubview:perFeeView];
        _perFeeView = perFeeView;
    }
    return _perFeeView;
}

- (MDShopInfoInputView *)memoView {
    if (!_memoView) {
        MDShopInfoInputView *memoView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"活动说明" placeholder:@"请填写活动说明" required:NO];
        [self.scrollView addSubview:memoView];
        _memoView = memoView;
    }
    return _memoView;
}

- (MDShopInfoInputView *)contentView {
    if (!_contentView) {
        MDShopInfoInputView *contentView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"使用说明" placeholder:@"请填写使用说明" required:NO];
        [self.scrollView addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (MDShopInfoInputView *)useStartView {
    if (!_useStartView) {
        MDShopInfoInputView *useStartView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"优惠起始" placeholder:@"请选择开始时间" required:NO];
        [self.scrollView addSubview:useStartView];
        _useStartView = useStartView;
    }
    return _useStartView;
}

- (MDShopInfoInputView *)useEndView {
    if (!_useEndView) {
        MDShopInfoInputView *useEndView = [MDShopInfoInputView shopInfoInputViewWithTitle:@"优惠结束" placeholder:@"请选择结束时间" required:NO];
        [self.scrollView addSubview:useEndView];
        _useEndView = useEndView;
    }
    return _useEndView;
}

- (MDShopBusinessHoursView *)businessHoursView {
    if (!_businessHoursView) {
        MDShopBusinessHoursView *businessHoursView = [MDShopBusinessHoursView shopBusinessHoursView];
        [self.view addSubview:businessHoursView];
        _businessHoursView = businessHoursView;
    }
    return _businessHoursView;
}

- (UIButton *)saveBtn {
    if (!_saveBtn) {
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [saveBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [saveBtn setBackgroundColor:kThemeColor];
        [saveBtn setFrame:CGRectMake(15, 15, G_SCREEN_WIDTH - 30, 45)];
        [saveBtn setCornerRadius:5];
        [saveBtn addTarget:self action:@selector(saveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:saveBtn];
        _saveBtn = saveBtn;
    }
    return _saveBtn;
}

@end

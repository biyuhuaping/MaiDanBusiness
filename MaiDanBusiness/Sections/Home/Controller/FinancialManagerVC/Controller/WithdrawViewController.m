//
//  WithdrawViewController.m
//  MaiDanSH
//
//  Created by lin on 16/10/20.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "WithdrawViewController.h"
#import "IncomeTypeView.h" 
#import "InputView.h"
#import "ShareCoinWithdrawView.h"

@interface WithdrawViewController ()

/** 顶部视图 */
@property (weak, nonatomic) UIView *headerView;
/** 背景 */
@property (nonatomic, weak) UIImageView *headBgImage;
/** 当前余额 */
@property (nonatomic, weak) UILabel *banlanceValue;
/** 当前余额 */
@property (nonatomic, weak) UILabel *banlanceLabel;
/** 底部视图 */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 营业收入 */
@property (nonatomic, weak) IncomeTypeView *incomeView;
/** 分享币收入 */
@property (nonatomic, weak) IncomeTypeView *shareCoinView;
/** 输入框 */
@property (nonatomic, weak) InputView *inputView;
/** 分享币提现扣税信息 */
@property (nonatomic, weak) ShareCoinWithdrawView *withDrawInfoView;
/** 提现按钮 */
@property (nonatomic, weak) UIButton *withdrawBtn;

@end

@implementation WithdrawViewController

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming64"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现";
    
    [self setUp];

    [self requestWithdrawInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInputDone) name:@"kUserInputDone" object:nil];
}

- (void)dealloc {
    NSLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - load data

/**
 *  查看提现账户信息
 */
- (void)requestWithdrawInfo {
    
    __weak WithdrawViewController *weakSelf = self;
    [[API shareAPI] getWithdrawInfo:^(id responseData) {
        NSLog(@"responseData = %@",responseData);
        [SVProgressHUD dismiss];
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            NSDictionary *info = responseData[@"json_val"][@"sellerfinance"];
            weakSelf.banlanceValue.text = [NSString stringWithFormat:@"%.2f",[info[@"score"] floatValue]];
            weakSelf.incomeView.income = [NSString stringWithFormat:@"%.2f",[info[@"businessScore"] floatValue]];
            weakSelf.shareCoinView.income = [NSString stringWithFormat:@"%.2f",[info[@"shareScore"] floatValue]];
        }
    }];
}

/**
 *  查看提现分享币需要扣的税
 */
- (void)requestWithdrawShareCoinTax {
    
    __weak WithdrawViewController *weakSelf = self;
    [[API shareAPI] getWithdrawShareCoinTaxWithAmount:self.withDrawInfoView.text type:@"1" completion:^(id responseData) {
        NSString *tax = responseData[@"json_val"];
        weakSelf.withDrawInfoView.tips = [NSString stringWithFormat:@"提现%@元分享币，需要扣税%@元",weakSelf.withDrawInfoView.text,tax];
    }];
}

/**
 *  发起提现请求
 */
- (void)requestSubmitWithdraw {
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSString *amount;
    NSString *type;
    if (self.incomeView.selected) {
        type = @"0";
        amount = self.inputView.text;
    } else {
        type = @"1";
        amount = self.withDrawInfoView.text;
    }
    
    __weak WithdrawViewController *weakSelf = self;
    [[API shareAPI] submitWithdrawWithAmount:amount type:type isInvoiced:self.withDrawInfoView.needBill completion:^(id responseData) {
        NSLog(@"responseData = %@",responseData);
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            BOOL success = [responseData[@"json_val"] boolValue];
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
//                [weakSelf requestWithdrawInfo];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            } else {
                [SVProgressHUD showErrorWithStatus:@"提交失败"];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:responseData[@"json_error"]];
        }
    }];
}

#pragma mark - init UI

- (void)setUp {

    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(265 * G_SCREEN_PROP));
    }];
    
    [self.headBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.headerView);
    }];
    
    [self.banlanceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_centerY);
        make.centerX.equalTo(self.headerView.mas_centerX);
    }];
    
    [self.banlanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.banlanceValue.mas_bottom).offset(5);
        make.centerX.equalTo(self.banlanceValue.mas_centerX);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    
    self.incomeView.incomeType = @"营业收入提现";
    self.incomeView.selected = YES;
    UITapGestureRecognizer *incomeViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(incomeViewTaped:)];
    [self.incomeView addGestureRecognizer:incomeViewTap];
    [self.incomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scrollView);
        make.height.equalTo(@150);
        make.width.equalTo(@(G_SCREEN_WIDTH/2));
    }];
    
    self.shareCoinView.incomeType = @"分享币提现";
    self.shareCoinView.selected = NO;
    UITapGestureRecognizer *shareCoinViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareCoinViewTaped:)];
    [self.shareCoinView addGestureRecognizer:shareCoinViewTap];
    [self.shareCoinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.incomeView.mas_right);
        make.top.equalTo(self.incomeView);
        make.width.height.equalTo(self.incomeView);
    }];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.scrollView);
        make.top.equalTo(self.incomeView.mas_bottom);
        make.height.equalTo(@50);
    }];
    
    [self.withDrawInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.scrollView);
        make.top.equalTo(self.incomeView.mas_bottom);
    }];
    
    [self.withdrawBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(10);
        make.width.equalTo(self.scrollView.mas_width).offset(-20);
        make.top.equalTo(self.inputView.mas_bottom).offset(20);
        make.height.equalTo(@45);
    }];
    
    [self.view layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, self.withdrawBtn.bottom + 40);
}

#pragma mark - method response

- (void)incomeViewTaped:(UITapGestureRecognizer *)tap {
    self.incomeView.selected = YES;
    self.shareCoinView.selected = NO;
    
    self.inputView.hidden = NO;
    self.withDrawInfoView.hidden = YES;
    
    [self.withdrawBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(10);
        make.width.equalTo(self.scrollView.mas_width).offset(-20);
        make.top.equalTo(self.inputView.mas_bottom).offset(20);
        make.height.equalTo(@45);
    }];
    [self.withdrawBtn layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, self.withdrawBtn.bottom + 40);
}

- (void)shareCoinViewTaped:(UITapGestureRecognizer *)tap {
    self.shareCoinView.selected = YES;
    self.incomeView.selected = NO;
    
    self.withDrawInfoView.hidden = NO;
    self.inputView.hidden = YES;
    
    [self.withdrawBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView).offset(10);
        make.width.equalTo(self.scrollView.mas_width).offset(-20);
        make.top.equalTo(self.withDrawInfoView.mas_bottom).offset(20);
        make.height.equalTo(@45);
    }];
    [self.withdrawBtn layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, self.withdrawBtn.bottom + 40);
}

- (void)submitBtnClick:(UIButton *)sender {
    
    NSString *amount;
    if (self.incomeView.selected) {
        amount = self.inputView.text;
    } else {
        amount = self.withDrawInfoView.text;
    }
    if (!amount.length) {
        [SVProgressHUD showErrorWithStatus:@"提现金额不能为空！"];
        return;
    }
    
    if ([amount integerValue] % 100 != 0) {
        [SVProgressHUD showErrorWithStatus:@"提现金额必须为100的整数倍！"];
        return;
    }
    
    [self requestSubmitWithdraw];
}

/**
 *  用户输入完成的通知
 */
- (void)userInputDone {
    
    // 判断是否是分享币提现
    if (!self.shareCoinView.selected) {
        NSLog(@"不是分享币提现");
        return;
    }
    
    // 判断是否勾选发票
    if (self.withDrawInfoView.needBill) {
        NSLog(@"需要发票时，不用扣税！");
        // 这里清空扣税提示，防止用户在输入完成时点击需要发票，扣税信息无法消失
        self.withDrawInfoView.tips = @"";
        return;
    }
    
    // 判断用户输入金额是否合法
    if ([self.withDrawInfoView.text floatValue] < 100 ||
        [self.withDrawInfoView.text floatValue] > [self.shareCoinView.income floatValue]) {
        NSLog(@"输入金额不在可提现范围内");
        // 这里清空扣税提示，防止用户在输入完成时重新输入不合法金额，扣税信息无法消失
        self.withDrawInfoView.tips = @"";
        return;
    }
    
    // 请求提现需要扣的税
    [self requestWithdrawShareCoinTax];
}

#pragma mark - setters & getters

- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerView = [UIView new];
        [self.view addSubview:headerView];
        _headerView = headerView;
    }
    return _headerView;
}

- (UIImageView *)headBgImage {
    if (!_headBgImage) {
        UIImageView *headBgImage = [[UIImageView alloc] init];
        headBgImage.image = [UIImage imageNamed:@"wodeyaoqing_bg"];
        [self.headerView addSubview:headBgImage];
        _headBgImage = headBgImage;
    }
    return _headBgImage;
}

- (UILabel *)banlanceValue {
    if (!_banlanceValue) {
        UILabel *banlanceValue = [UILabel new];
        banlanceValue.textColor = kWhiteColor;
        banlanceValue.font = FONT_WITH_SIZE(30);
        banlanceValue.textAlignment = NSTextAlignmentCenter;
        [self.headerView addSubview:banlanceValue];
        _banlanceValue = banlanceValue;
    }
    return _banlanceValue;
}

- (UILabel *)banlanceLabel {
    if (!_banlanceLabel) {
        UILabel *banlanceLabel = [UILabel new];
        banlanceLabel.textColor = kWhiteColor;
        banlanceLabel.font = FONT_WITH_SIZE(14);
        banlanceLabel.textAlignment = NSTextAlignmentCenter;
        banlanceLabel.text = @"当前余额";
        [banlanceLabel sizeToFit];
        [self.headerView addSubview:banlanceLabel];
        _banlanceLabel = banlanceLabel;
    }
    return _banlanceLabel;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.contentSize = CGSizeMake(G_SCREEN_WIDTH, G_SCREEN_HEIGHT);
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (IncomeTypeView *)incomeView {
    if (!_incomeView) {
        IncomeTypeView *incomeView = [[IncomeTypeView alloc] init];
        [self.scrollView addSubview:incomeView];
        _incomeView = incomeView;
    }
    return _incomeView;
}

- (IncomeTypeView *)shareCoinView {
    if (!_shareCoinView) {
        IncomeTypeView *shareCoinView = [[IncomeTypeView alloc] init];
        [self.scrollView addSubview:shareCoinView];
        _shareCoinView = shareCoinView;
    }
    return _shareCoinView;
}

- (InputView *)inputView {
    if (!_inputView) {
        InputView *inputView = [InputView new];
        [self.scrollView addSubview:inputView];
        _inputView = inputView;
    }
    return _inputView;
}

- (ShareCoinWithdrawView *)withDrawInfoView {
    if (!_withDrawInfoView) {
        ShareCoinWithdrawView *withDrawInfoView = [ShareCoinWithdrawView new];
        withDrawInfoView.hidden = YES;
        [self.scrollView addSubview:withDrawInfoView];
        _withDrawInfoView = withDrawInfoView;
    }
    return _withDrawInfoView;
}

- (UIButton *)withdrawBtn {
    if (!_withdrawBtn) {
        UIButton *withdrawBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [withdrawBtn setBackgroundColor:kThemeColor];
        [withdrawBtn setCornerRadius:5];
        [withdrawBtn setTitle:@"确认提现" forState:UIControlStateNormal];
        [withdrawBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [self.scrollView addSubview:withdrawBtn];
        _withdrawBtn = withdrawBtn;
    }
    return _withdrawBtn;
}

@end

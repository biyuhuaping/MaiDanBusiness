//
//  BindingCardViewController.m
//  MaiDanSH
//
//  Created by lin on 16/10/21.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "BindingCardViewController.h"
#import "MDProvinceViewController.h"

@interface BindingCardViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UITextField *bankNameField;
@property (weak, nonatomic) IBOutlet UITextField *bankNumField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *provinceField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UITextField *regionField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation BindingCardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"绑定银行卡";
    self.view.backgroundColor = kBackgroundColor;
    
    [self requestWithdrawInfo];
}

/**
 *  查看提现账户信息
 */
- (void)requestWithdrawInfo {
    
    __weak BindingCardViewController *weakSelf = self;
    [[API shareAPI] getWithdrawInfo:^(id responseData) {
        NSLog(@"responseData = %@",responseData);
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            
            NSDictionary *info = responseData[@"json_val"][@"sellerfinance"];
            if ([info[@"isCheck"] integerValue] == 0) {
                self.msgLabel.text = @"审核不通过,请修改信息重新绑定!";
                self.saveBtn.hidden = NO;
                self.saveBtn.enabled = YES;
                self.saveBtn.backgroundColor = kThemeColor;
            } else if ([info[@"isCheck"] integerValue] == 1) {
                self.msgLabel.text = @"";
                self.saveBtn.hidden = YES;
            } else {
                self.msgLabel.text = @"等待审核";
                self.saveBtn.hidden = NO;
                self.saveBtn.enabled = NO;
                self.saveBtn.backgroundColor = RGBCOLOR(204, 204, 204);
            }
            
            weakSelf.bankNameField.text = info[@"bankName"];
            weakSelf.bankNumField.text = info[@"bankAccount"];
            weakSelf.usernameField.text = info[@"bankPerson"];
            weakSelf.provinceField.text = info[@"bankProvince"];
            weakSelf.cityField.text = info[@"bankCity"];
            weakSelf.regionField.text = info[@"bankArea"];
        }
    }];
}

- (void)requestBindingCard {
    
    [[API shareAPI] bindingCardWithBankName:self.bankNameField.text bankAccount:self.bankNumField.text bankPerson:self.usernameField.text bankProvince:self.provinceField.text bankCity:self.cityField.text bankArea:self.regionField.text completion:^(id responseData) {
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            BOOL success = [responseData[@"json_val"] boolValue];
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"绑定已提交，请等待审核！"];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [SVProgressHUD showErrorWithStatus:@"绑定失败"];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:responseData[@"json_error"]];
        }
    }];
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    MDProvinceViewController *provinceVC = [MDProvinceViewController new];
    [self.navigationController pushViewController:provinceVC animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseAddress:) name:@"kSelectAddress" object:nil];
    
    return NO;
}

- (void)chooseAddress:(NSNotification *)notification {
    NSLog(@"%@",notification);
    self.provinceField.text = notification.userInfo[@"province"];
    self.cityField.text = notification.userInfo[@"city"];
    self.regionField.text = notification.userInfo[@"region"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)bindingBtnClick {
    
    if (!self.bankNameField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"开户银行不能为空！"];
        return;
    }
    
    if (!self.bankNumField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"开户账号不能为空！"];
        return;
    }
    
    if (!self.usernameField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"开户名不能为空！"];
        return;
    }
    
    if (!self.provinceField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"开户地不能为空！"];
        return;
    }
    
    [self requestBindingCard];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

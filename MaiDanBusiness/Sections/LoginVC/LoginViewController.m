//
//  LoginViewController.m
//  DaJiaZhuan
//
//  Created by Bibo on 14/12/31.
//  Copyright (c) 2014年 su. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "HomeMessage.h"
#import "CLLockVC.h"
#import "HomeViewController.h"
#import "DEMOMenuViewController.h"

#define TAG_BUTTON_REGISTER         0x001
#define TAG_BUTTON_DEVICEID         0x002
#define TAG_BUTTON_SURE             0x003
#define TAG_BUTTON_PASSWORD       0x004


@interface LoginViewController ()

@property (nonatomic, strong) UITextField *txtYH; //用户名
@property (nonatomic, strong) UITextField *txtMM; //密码

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
    self.title = @"登录";
    self.view.backgroundColor = RGBCOLOR(251, 250, 248);
    [self initUI];
}

- (void)initUI
{
    //顶部logo
    UIImageView *imgViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, 70, 100, 100)];
    imgViewLogo.image = [UIImage imageNamed:@"logo_zhuan"];
    [self.view addSubview:imgViewLogo];
    
    
    UILabel *nameApp = [[UILabel alloc] initWithFrame:CGRectMake(0, imgViewLogo.bottom + 11, G_SCREEN_WIDTH, 30)];
    nameApp.textAlignment = NSTextAlignmentCenter;
    nameApp.textColor = RGBCOLOR(82, 61, 44);
    nameApp.font = [UIFont boldSystemFontOfSize:18];
    
    nameApp.text = @"脉单商户端";
    [self.view addSubview:nameApp];
    
   
    
    //输入框
    UIView *viewR1 = [[UIView alloc] initWithFrame:CGRectMake(-1, nameApp.bottom + 29, P_SCREEN_WIDTH  , 88)];
    viewR1.backgroundColor = [UIColor whiteColor];
    viewR1.layer.borderWidth = 0.5;
    viewR1.layer.borderColor = RGBCOLOR(216, 216, 216).CGColor;
    [self.view addSubview:viewR1];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(-1, 44, P_SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = RGBCOLOR(216, 216, 216);
    [viewR1 addSubview:lineView];
    
    UIImageView *imgYH = [[UIImageView alloc] initWithFrame:CGRectMake(23, 12, 24, 24)];
    imgYH.image = [UIImage imageNamed:@"username"];
    [viewR1 addSubview:imgYH];
    
    _txtYH = [[UITextField alloc] initWithFrame:CGRectMake(60, 2, 260, 44)];
    _txtYH.clearButtonMode = UITextFieldViewModeWhileEditing;
    _txtYH.delegate = self;
    _txtYH.tintColor = [UIColor grayColor];

    _txtYH.font = [UIFont systemFontOfSize:15];
    _txtYH.placeholder = @"请输入用户名";
    [viewR1 addSubview:_txtYH];
    
    UIImageView *imgMM = [[UIImageView alloc] initWithFrame:CGRectMake(23, 56, 22, 25)];
    imgMM.image = [UIImage imageNamed:@"password"];
    [viewR1 addSubview:imgMM];
    
    _txtMM = [[UITextField alloc] initWithFrame:CGRectMake(60, 46, 260, 44)];
    _txtMM.clearButtonMode = UITextFieldViewModeWhileEditing;
    _txtMM.tintColor = [UIColor grayColor];
    _txtMM.font = [UIFont systemFontOfSize:15];
    _txtMM.placeholder = @"请输入您的密码";
    _txtMM.delegate = self;
    _txtMM.secureTextEntry = YES;
    [viewR1 addSubview:_txtMM];
    
    //注册账号
    float fY = viewR1.frame.origin.y + viewR1.frame.size.height + 5;

    //确认按钮
    UIButton *btnSure = [[UIButton alloc] initWithFrame:CGRectMake(15, fY+10, P_SCREEN_WIDTH-30,44)];
    btnSure.tag = TAG_BUTTON_SURE;
    
    [btnSure addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btnSure.backgroundColor = RGBCOLOR(234, 85, 20);
    [btnSure .layer setMasksToBounds:YES];
    [btnSure .layer setCornerRadius:10.0];
    //设置矩形四个圆角半径
//    [btnSure .layer setBorderWidth:1.0];
    [btnSure setTitle:@"登     录" forState:UIControlStateNormal];
    [btnSure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSure.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    
   
    //查看设备ID
    UIButton *btnF = [[UIButton alloc] initWithFrame:CGRectMake(G_SCREEN_WIDTH - 90, fY+ 70, 80, 20)];
    btnF.tag = TAG_BUTTON_DEVICEID;
    [btnF addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [btnF setTitle:@"查看设备ID" forState:UIControlStateNormal];
    [btnF setTitleColor:RGBCOLOR(234, 85, 20) forState:UIControlStateNormal];
    btnF.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:btnF];    
    [self.view addSubview:btnSure];
    
    //忘记密码
//    UIButton *btnW = [[UIButton alloc] initWithFrame:CGRectMake(8, fY+ 70, 80, 20)];
//   btnW.tag = TAG_BUTTON_DEVICEID;
//    [btnW addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [btnW setTitle:@"忘记密码" forState:UIControlStateNormal];
//    [btnW setTitleColor:RGBCOLOR(234, 85, 20) forState:UIControlStateNormal];
//    btnW.titleLabel.font = [UIFont systemFontOfSize:13];
//    [self.view addSubview:btnW];
    
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)btnPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (btn.tag == TAG_BUTTON_DEVICEID) //产看设备ID
    {
        NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
        NSString *strDeviceID = [config objectForKey:G_DEVICE_ID];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设备ID" message:strDeviceID delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else if (btn.tag == TAG_BUTTON_SURE) //确定
    {
        [self requestDataFromNet];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *  开始编辑输入框的时候，软键盘出现，执行此事件
 *
 *  @param textField
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + frame.size.height + 260 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationCurve:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if (offset > 0)
    {
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

/**
 *  当用户按下return键或者按回车键，keyboard消失
 *
 *  @return
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/**
 *  输入框编辑完成以后，将视图恢复到原始状态
 *
 *  @param textField
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


/**
 *  关闭键盘，在ViewDidLoad中调用
 */
- (void)tapBackground
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnce)];//定义一个手势
    [tap setNumberOfTouchesRequired:1];//触击次数这里设为1
    [self.view addGestureRecognizer:tap];//添加手势到View中
}


/**
 *  手势方法
 */
- (void)tapOnce
{
    [self.txtYH resignFirstResponder];
    [self.txtMM resignFirstResponder];
}

/**
 *  请求网络数据
 */
- (void)requestDataFromNet
{
    __weak LoginViewController *weakSelf = self;
    AppDelegate *appdelgate = (AppDelegate *)[[UIApplication sharedApplication] delegate];


    NSString *strDevid =    [[API shareAPI] getLocalData: G_DEVICE_ID];
//    strDevid=@"42310001";
    [[API shareAPI] getAPI:API_Login loginPhone:_txtYH.text passWord:_txtMM.text deviceType:strDevid completion:^(id responseData) {
        if ([responseData[@"json_res"] isEqualToString:@"json_ok"]) {
            weakSelf.homeMessage = [[HomeMessage alloc] init];
            [weakSelf.homeMessage setValuesForKeysWithDictionary:responseData[@"json_val"]];
            
            //保存状态
            [[API shareAPI] saveLocalData:G_IS_LOGIN value:G_YES];
            [[API shareAPI] saveLocalData:G_SHOP_ID value:[NSString stringWithFormat:@"%@",_homeMessage.sellerId]];
            [[API shareAPI] saveLocalData:G_WORKER_ID value:_homeMessage.workerid];
            
            [[API shareAPI] saveLocalData:G_WORKER_PWD value:_txtMM.text];
            [[API shareAPI] saveLocalData:G_SHOP_NAME value:_homeMessage.shopName];
            
            appdelgate.lockBool = YES;
            
            [self dismissViewControllerAnimated:YES completion:nil];
            //                BOOL hasPwd = [CLLockVC hasPwd];
            //                if(hasPwd){
            //                    [self.homeVC requestDataFromNet];
            //                    appdelgate.lockBool= NO;
            //                }else{
            self.homeVC.enter = NO;
            appdelgate.menuController.viewVC = appdelgate.homeVC;
            [self.navigationController popToRootViewControllerAnimated:YES];
            [CLLockVC showSettingLockVCInVC:self.homeVC successBlock:^(CLLockVC *lockVC, NSString *pwd) {
                appdelgate.lockBool= NO;
                [self.homeVC dismissViewControllerAnimated:YES completion:nil];
                [self.homeVC requestDataFromNet];
                [lockVC dismiss:1.0f];
                
            }];
            //                }
        }
        else{            
            NSString *strResult = [responseData objectForKey:@"json_error"];
            [SVProgressHUD showErrorWithStatus:strResult];
        }
    }];
}

@end

//
//  MnualViewController.m
//  DaJiaZhuanSH
//
//  Created by feng on 16/6/3.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MnualViewController.h"

@interface MnualViewController ()<UITextFieldDelegate>
{
    UITextField *_txt;
    UIButton *btn1;
    
}
@property (nonatomic,strong)UIImageView *imagV;

@end

@implementation MnualViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBCOLOR(247, 247, 247);
    
    self.title =@"手动扫描";
    [self initUI];
}
- (void)initUI
{
    float fY = 64;
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(20, fY + 20, P_SCREEN_WIDTH - 20, 20)];
    lbl1.text = @"请输入订单确认码";
    lbl1.textColor = RGBCOLOR(51, 51, 51);
    
    [self.view addSubview:lbl1];
    
    
    _txt = [[UITextField alloc] initWithFrame:CGRectMake(15, fY + 50, P_SCREEN_WIDTH - 30, 40)];
    _txt.backgroundColor = [UIColor whiteColor];

    _txt.layer.cornerRadius = 5;
    _txt .layer.masksToBounds    = YES;

    _txt.delegate = self;
    _txt.font = [UIFont systemFontOfSize:15];
    [XMUnit setTextFieldLeftPadding:_txt forWidth:5];
    _txt.placeholder = @"请输入确认码";
    [self.view addSubview:_txt];
    
    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(15, fY + 120, P_SCREEN_WIDTH - 30, 45)];
    btn1 .layer.masksToBounds    = YES;
    btn1.layer.cornerRadius     = 5;
    [btn1 addTarget:self action:@selector(confirmOrder) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = RGBCOLOR(235, 87, 49);
    [btn1 setTitle:@"确   认" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:btn1];
    
    //添加UIImageV
    self.imagV = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.width*16.0/16.0) + 80, 104, 104)];
    self.imagV.centerX =self.view.centerX;
    _imagV.image = [UIImage imageNamed:@"scanning"];
    _imagV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_imagV addGestureRecognizer:tap];
    
    [self.view addSubview:_imagV];

    
}
- (void)tap:(UITapGestureRecognizer *)tap{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)confirmOrder
{
    
    
    if (_txt.text.length == 0 || _txt.text == nil)
    {
        [SVProgressHUD showErrorWithStatus:@"订单号不能为空！"];

        
    }
    else{
        btn1.userInteractionEnabled = NO;
        //订单确认
        [[API shareAPI] getOrderconf:_txt.text completion:^(id responseData) {
            if ([responseData[@"json_res"] isEqualToString: @"json_ok"]) //通讯成功
            {
                [SVProgressHUD showSuccessWithStatus:@"订单确认成功！"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                btn1.userInteractionEnabled = YES;
                NSString *strResult = [responseData objectForKey:@"json_error"];
                [SVProgressHUD showErrorWithStatus:strResult];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

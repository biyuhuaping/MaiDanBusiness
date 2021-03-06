//
//  ConViewController.m
//  DaJiaZhuanSH
//
//  Created by feng on 16/6/14.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ConViewController.h"
#import "ASValueTrackingSlider.h"

@interface ConViewController ()<ASValueTrackingSliderDataSource,UITextFieldDelegate>
{
    UILabel *lbl3;
    UILabel *lbl2;
    UIButton *contn;
}
@property (nonatomic,strong)UIImageView *topView;
@property (nonatomic,strong)UITextField *conversion;

@property (nonatomic,strong)ASValueTrackingSlider *slider1;
@end

@implementation ConViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"touming64"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    //生效
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"分享收益转换";
    [self initUI];
}


- (void) initUI{
    
    _share1 = _share;
    _business1 = _business;

    //账户信息视图
    _topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, G_SCREEN_WIDTH, 265 *G_SCREEN_PROP)];
    _topView.image = [UIImage imageNamed:@"wodeyaoqing_bg"];
    _topView.userInteractionEnabled = YES;
    [self.view addSubview:_topView];
    
    float width = (G_SCREEN_WIDTH -2)/2;
    float heigth = 44;
    //转让人箭头
   
    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 114 *G_SCREEN_PROP,200 *G_SCREEN_PROP, 34*G_SCREEN_PROP )];
    arrowImg.centerX = self.view.centerX;
    arrowImg.image = [UIImage imageNamed:@"convert_arrow"];
    arrowImg.userInteractionEnabled = YES;
    [_topView addSubview:arrowImg];
    
    //添加营业收入
    self.businessLable= [[UILabel alloc] initWithFrame:CGRectMake(0, 160 *G_SCREEN_PROP, width, heigth *3/5)];
    self.businessLable.textAlignment = NSTextAlignmentCenter;
    self.businessLable.textColor = [UIColor whiteColor];
    self.businessLable.font= [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    
    [_topView addSubview:_businessLable];
    lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(0, _businessLable.bottom + 5, width, heigth *2/5)];
    lbl2.textColor = [UIColor whiteColor];
    lbl2.textAlignment = NSTextAlignmentCenter;
    lbl2.text = @"营业收入";
    lbl2.font = [UIFont systemFontOfSize:13];
    [_topView addSubview:lbl2];
    
    
    //添加分享收入
    self.shareLable= [[UILabel alloc] initWithFrame:CGRectMake(_businessLable.right + 1, _businessLable.top, width, heigth *3/5)];
    self.shareLable.textAlignment = NSTextAlignmentCenter;
    self.shareLable.textColor = [UIColor whiteColor];
    self.shareLable.font= [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    [_topView addSubview:_shareLable];
    lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(_businessLable.right + 1, _shareLable.bottom + 5, width, heigth *2/5)];
    lbl3.textColor = [UIColor whiteColor];
    lbl3.textAlignment = NSTextAlignmentCenter;
    lbl3.font = [UIFont systemFontOfSize:13];
    lbl3.text = @"分享收益";
    [_topView addSubview:lbl3];
    
    [self upadata];
    //
//    UILabel *adjustLal =[[UILabel alloc] initWithFrame:CGRectMake(15, _topView.bottom + 20,  2 *width, 20)];
//    adjustLal.text = @"请调整将要转换为营业收入的金额";
//    adjustLal.font = [UIFont systemFontOfSize:15];
//    [self.view addSubview:adjustLal];
    
    _conversion= [[UITextField alloc] initWithFrame:CGRectMake(0, _topView.bottom + 22, G_SCREEN_WIDTH - 30, 55)];
    UIImage *image = [UIImage imageNamed:@"conversion_text"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [_conversion setBackground:image];
    _conversion.centerX = self.view.centerX;
    _conversion.delegate = self;
    [_conversion addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    _conversion.keyboardType = UIKeyboardTypeNumberPad;
    _conversion.textAlignment = NSTextAlignmentCenter;
    _conversion.font = [UIFont systemFontOfSize:13];
    _conversion.placeholder = @"请输入转换的分享收益,单位元（整数)";

    [self.view addSubview:_conversion];
//    self.slider1 = [[ASValueTrackingSlider alloc] initWithFrame:CGRectMake(10, _conversion.bottom +30, 2 *width - 40, 66)];
//
//    //添加最小 最大
//    NSString *max =[[API shareAPI] notRounding:_shareLable.text afterPoint:0];
//    
//    if ([max intValue] > 0) {
//        self.slider1.maximumValue = [max intValue];
//        
//    }else{
//        max = @"0";
//        self.slider1.maximumValue = 0;
//    }
//
//    UILabel *minLable = [[UILabel alloc] initWithFrame:CGRectMake(_slider1.left + 15, _slider1.top - 20, 60, 15)];
//    minLable.text = @"0";
//    minLable.textColor = RGBCOLOR(153, 153, 153);
//    minLable.font = [UIFont systemFontOfSize:14];
//    minLable.textAlignment = NSTextAlignmentLeft;
//    
//    UILabel *maxLable = [[UILabel alloc] initWithFrame:CGRectMake(_slider1.right - 70, _slider1.top - 20, 60, 15)];
//    maxLable.text = max;
//    maxLable.textColor = RGBCOLOR(153, 153, 153);
//    maxLable.font = [UIFont systemFontOfSize:14];
//    maxLable.textAlignment = NSTextAlignmentRight;
//    [self.view addSubview:minLable];
//    [self.view addSubview:maxLable];
//
//    //预留slider
//    // customize slider 1
//    _slider1.centerX = self.view.centerX;
//    self.slider1.dataSource = self;
//    [self.slider1 setMaxFractionDigitsDisplayed:0];
//    
//    
//    //左右轨的图片
//    UIImage *stetchLeftTrack= [UIImage imageNamed:@"progress_bar_yellow"];
//    UIImage *stetchRightTrack = [UIImage imageNamed:@"progress_bar_gray"];
//    self.slider1.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
//    self.slider1.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
//    self.slider1.backgroundColor = [UIColor clearColor];
//    self.slider1.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
//    [_slider1 setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
//    [_slider1 setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
//    [_slider1 setThumbImage:[UIImage imageNamed:@"drab_btn"] forState:UIControlStateNormal];
//    [self.view addSubview:_slider1];
    
    //预留转换
    UIButton *button= [[UIButton alloc] initWithFrame:CGRectMake(15, _conversion.bottom + 50, G_SCREEN_WIDTH - 30,40)];
    [button addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = RGBCOLOR(234, 85, 20);
    [button setTitle:@"确认转换" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    button .layer.masksToBounds    = YES;
    button.layer.cornerRadius     = 5;
    [self.view addSubview:button];
    [self tapBackground];
}
-(void)upadata{
    
    NSString *price;
    NSMutableAttributedString *mAtrrString;
    price =[NSString stringWithFormat:@"%.2f",[_share1 floatValue]];
    
    NSDictionary *consumDic1 =  @{NSFontAttributeName :[UIFont fontWithName:@"HelveticaNeue-Bold" size:24],NSForegroundColorAttributeName:RGBCOLOR(255, 255, 255)};
    NSDictionary *consumDic2 = @{NSFontAttributeName :[UIFont fontWithName:@"HelveticaNeue-Bold" size:12],NSForegroundColorAttributeName:RGBCOLOR(255, 255, 255)};
    NSRange range = [price rangeOfString:@"."];//匹配得到的下标
    mAtrrString= [[NSMutableAttributedString alloc] initWithString:price attributes:consumDic1];
    
    [mAtrrString  addAttributes:consumDic2 range:NSMakeRange(range.location + 1,2)];
     self.shareLable.attributedText = mAtrrString;
    
    
    price =[NSString stringWithFormat:@"%.2f",[_business1 floatValue]];
    NSRange range1 = [price rangeOfString:@"."];//匹配得到的下标
    mAtrrString = [[NSMutableAttributedString alloc] initWithString:price attributes:consumDic1];
    [mAtrrString  addAttributes:consumDic2 range:NSMakeRange(range1.location + 1,2)];
    self.businessLable.attributedText = mAtrrString;
    

}
- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value{
    value = roundf(value);
    NSString *s;
    s = [NSString stringWithFormat:@"%.0f", value];
    
    if (value == 0) {
        _conversion.font = [UIFont systemFontOfSize:13];
        s = @"";

    }
   else if (value <= 20000) {
       _conversion.font = [UIFont systemFontOfSize:20];
        //小20000
        _business1 = [NSString stringWithFormat:@"%.2f",[_business floatValue] + value *0.8];
        _share1 = [NSString stringWithFormat:@"%.2f",[_share floatValue] - value];
        
    }else if (value <= 50000){
        _business1 = [NSString stringWithFormat:@"%.2f",[_business floatValue] +value *0.7 + 2000];
        _share1 = [NSString stringWithFormat:@"%.2f",[_share floatValue] - value ];

    }else{
        _business1 = [NSString stringWithFormat:@"%.2f",[_business floatValue] + value *0.6 + 7000];
        _share1 = [NSString stringWithFormat:@"%.2f",[_share floatValue] - value];
    }
    _conversion.text = s;
    _into = s;
    [self upadata];
    return s;
}


- (void)valueChanged:(UITextField *)textField{
    
    
    if ( [textField.text floatValue] == 0 || textField.text == nil || textField.text.length == 0 ) {
        textField.placeholder = @"请输入转换金额,单位元（整数)";
        textField.font = [UIFont systemFontOfSize:13];
    } else {
//        textField.font = [UIFont systemFontOfSize:20];
//        textField.text =  [NSString stringWithFormat:@"%.0f",[textField.text floatValue]];
//        if ([textField.text floatValue] > [_shareLable.text floatValue]) {
//            textField.text = [NSString stringWithFormat:@"%.0f",_slider1.maximumValue];
//            [SVProgressHUD setBackgroundColor:RGBCOLOR(247, 247, 247)];
//            
//            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"输入金额不能大于账户%.0f",_slider1.maximumValue] ];
//        }
//        _slider1.value =[textField.text floatValue];
    }
    
}
/**
 *  开始编辑输入框的时候，软键盘出现，执行此事件
 *
 *  @param textField
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frame = textField.frame;
    
    int offset = frame.origin.y + frame.size.height + 170 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if (offset > 0)
    {
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
        lbl2.hidden = YES;
        lbl3.hidden = YES;
        _businessLable.hidden = YES;
        _shareLable.hidden = YES;
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
    lbl2.hidden = NO;
    lbl3.hidden = NO;
    _businessLable.hidden = NO;
    _shareLable.hidden = NO;
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
    [self.conversion resignFirstResponder];
}

- (void)btnPressed:(UIButton *)button{
    
    if ([_conversion.text intValue] > 0) {
        button.userInteractionEnabled = NO;
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        [[API shareAPI] getAPI:API_CHANGE shareScore:_conversion.text businessScore:@"0" completion:^(id responseData) {
            [SVProgressHUD dismiss];
            if ([responseData[@"json_res"] isEqualToString:@"json_ok"]) {
                //转入成功 返回首页
                [SVProgressHUD showSuccessWithStatus:responseData[@"json_val"][@"msg"]];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } else{
                button.userInteractionEnabled = YES;
                [SVProgressHUD showErrorWithStatus:responseData[@"json_error"]];
            }
        }];
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"转换金额不能为空"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

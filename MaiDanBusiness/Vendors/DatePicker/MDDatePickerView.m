//
//  MDDatePickerView.m
//  MaiDan
//
//  Created by 潇哥 on 16/8/3.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MDDatePickerView.h"

#define navigationViewHeight 44.0f
#define pickViewViewHeight 200.0f
#define buttonWidth 60.0f
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]

@interface MDDatePickerView ()

@property (nonatomic, strong) NSDictionary *pickerDic;
@property (nonatomic, strong) NSArray *selectedArray;
@property (nonatomic, strong) UIView *bottomView;//包括导航视图和地址选择视图
@property (nonatomic, strong) UIDatePicker *pickView;//地址选择视图
@property (nonatomic, strong) UIView *navigationView;//上面的导航视图

@end

@implementation MDDatePickerView

+ (instancetype)shareInstance
{
    static MDDatePickerView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[MDDatePickerView alloc] init];
    });
    
    [shareInstance showBottomView];
    return shareInstance;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self _addTapGestureRecognizerToSelf];
        [self _createView];
    }
    return self;
    
}

-(void)_addTapGestureRecognizerToSelf
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottomView)];
    [self addGestureRecognizer:tap];
}
-(void)_createView
{
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, navigationViewHeight+pickViewViewHeight)];
    [self addSubview:_bottomView];
    //导航视图
    _navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, navigationViewHeight)];
    _navigationView.backgroundColor = [UIColor lightGrayColor];
    [_bottomView addSubview:_navigationView];
    //这里添加空手势不然点击navigationView也会隐藏,
    UITapGestureRecognizer *tapNavigationView = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
    [_navigationView addGestureRecognizer:tapNavigationView];
    NSArray *buttonTitleArray = @[@"取消",@"确定"];
    for (int i = 0; i <buttonTitleArray.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(i*(kScreenWidth-buttonWidth), 0, buttonWidth, navigationViewHeight);
        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        [_navigationView addSubview:button];
        
        button.tag = i;
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    _pickView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, navigationViewHeight, kScreenWidth, pickViewViewHeight)];
    _pickView.backgroundColor = [UIColor whiteColor];
    [_pickView setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *tempDate = [NSDate date];
    
    NSLocale *chineseLocale = [NSLocale localeWithLocaleIdentifier:@"zh_cn"]; //创建一个中文的地区对象
    [_pickView setLocale:chineseLocale];
    [_pickView setDate:tempDate animated:YES];
    [_pickView setDatePickerMode:UIDatePickerModeDate];
    [_bottomView addSubview:_pickView];
    
    
}

- (void)setPickerMode:(UIDatePickerMode)mode {
    [_pickView setDatePickerMode:mode];
}

- (void)setMaxDate {
    [_pickView setMaximumDate:[NSDate date]];
}

- (void)tapButton:(UIButton*)button
{
    //点击确定回调block
    if (button.tag == 1) {
        
        if (_pickView.datePickerMode == UIDatePickerModeDate) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSString *strDate = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[_pickView date]]];
            if (self.block) {
                self.block(strDate);
            }
        } else if (_pickView.datePickerMode == UIDatePickerModeTime) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"hh:mm"];
            
            NSString *strDate = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[_pickView date]]];
            if (self.block) {
                self.block(strDate);
            }
        }
    }
    
    [self hiddenBottomView];
    
    
}
- (void)showBottomView
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.top = kScreenHeight-navigationViewHeight-pickViewViewHeight;
        self.backgroundColor = windowColor;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)hiddenBottomView
{
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.top = kScreenHeight;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}



@end

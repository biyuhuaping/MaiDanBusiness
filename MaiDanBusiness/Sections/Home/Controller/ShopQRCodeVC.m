//
//  ShopQRCodeVC.m
//  DaJiaZhuanBiz
//
//  Created by Bibo on 15/3/19.
//  Copyright (c) 2015年 Bibo. All rights reserved.
//

#import "ShopQRCodeVC.h"
#import "UIImage+MDQRCode.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@interface ShopQRCodeVC ()
@property (nonatomic, strong) UIImageView* qrImgView;
@property (nonatomic, strong) UIImageView* qrImgView1;
@end

@implementation ShopQRCodeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, 220)];
    
    _qrImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 200, 200)];
    //二维码链接生成
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    NSString *strUserID = [config objectForKey:G_SHOP_ID];
    
    _strQRCodeUrl =  [NSString stringWithFormat:@"%@Shop/api/share/jump?shopId=%@",G_SERVER_URL,strUserID];
//    _qrImgView.image = [UIImage mdQRCodeForString:_strQRCodeUrl size:_qrImgView.bounds.size.width fillColor:RGBCOLOR(0, 0, 0)];
    [self createQR1];
    [self createQR2];

    [view addSubview:_qrImgView];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, _qrImgView.frame.origin.y + 210, 220, 20)];
    lbl.text = @"扫 一 扫，注 册 脉 单";
    lbl.font = [UIFont systemFontOfSize:15];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = RGBCOLOR(234, 85, 20);
    [view addSubview:lbl];
    [self.view addSubview:view];
    view.center = self.view.center;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgTapCliclk:)];
    view.userInteractionEnabled = YES;
    _qrImgView.userInteractionEnabled = YES;
    [self.qrImgView addGestureRecognizer:tap];

}


- (void)createQR1
{
    //二维码链接生成
    //二维码链接生成
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    NSString *strUserID = [config objectForKey:G_SHOP_ID];
    
    _strQRCodeUrl =  [NSString stringWithFormat:@"%@Shop/api/share/jump?shopId=%@",G_SERVER_URL,strUserID];
    
    
    UIImage *qrImg = [UIImage mdQRCodeForString:_strQRCodeUrl size:self.qrImgView.frame.size.width fillColor:RGBCOLOR(0, 0, 0)];;
    
    UIImageView *logoImg          = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    logoImg .backgroundColor = [UIColor whiteColor];
    logoImg .layer.masksToBounds    = YES;
    logoImg .userInteractionEnabled = YES;
    if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_strLogoUrl]) {
        
        [logoImg  setImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_strLogoUrl]];
        
    } else {
        [logoImg  sd_setImageWithURL:[NSURL URLWithString:_strLogoUrl] placeholderImage:[UIImage imageNamed:@"icon80"]];
    }
    UIImage *logoImg1;
    logoImg1 = [UIImage roundedCornerImageWithCornerRadius:10 srcImg:logoImg.image];
    _qrImgView.image = [UIImage addImageLogo:qrImg centerLogoImage:logoImg1 logoSize:CGSizeMake(60, 60)];
}
- (void)createQR2
{
    _qrImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 , G_SCREEN_WIDTH, G_SCREEN_WIDTH )];
    UIImage *qrImg = [UIImage mdQRCodeForString:_strQRCodeUrl size:self.qrImgView.frame.size.width fillColor:RGBCOLOR(0, 0, 0)];;
    
    UIImageView *logoImg          = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    logoImg.backgroundColor = [UIColor whiteColor];
    logoImg.layer.masksToBounds    = YES;
    logoImg.userInteractionEnabled = YES;
    if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_strLogoUrl]) {
        [logoImg  setImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_strLogoUrl]];
        
    } else {
        [logoImg  sd_setImageWithURL:[NSURL URLWithString:_strLogoUrl] placeholderImage:[UIImage imageNamed:@"icon80"]];
    }
    UIImage *logoImg1;
    logoImg1 = [UIImage roundedCornerImageWithCornerRadius:10 srcImg:logoImg.image];
    
    _qrImgView1.image = [UIImage addImageLogo:qrImg centerLogoImage:logoImg1 logoSize:CGSizeMake(60, 60)];
    
}

- (void)imgTapCliclk:(UITapGestureRecognizer *)tap{
    //1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i<1; i++) {
        //        // 替换为中等尺寸图片
        NSString *url = [_strQRCodeUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.image =_qrImgView1.image;
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.isPhone = YES;
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    
    [browser show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end

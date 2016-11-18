//
//  ImageManagerViewController.m
//  MaiDanSH
//
//  Created by lin on 16/9/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ImageManagerViewController.h"
#import "MultipleImageTableViewCell.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface ImageManagerViewController () <UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *shopImages;

/** 保存店铺图片 */
@property (nonatomic, strong) NSMutableDictionary *shopImageDict;

/** 记录当前选中的是哪张店铺图片 */
@property (nonatomic, assign) NSInteger currentIndex;

/** 当选择相机拍照或者从图库取一张图片时的回调 */
@property (nonatomic, copy) void(^imageBlock)(UIImage *image);
/** 是否是店铺图片 */
@property (nonatomic, assign, getter=isShopImage) BOOL shopImage;

@end

@implementation ImageManagerViewController

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"chengse64"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"图片管理";
    
    self.titleArray = @[ @"商家门头照",@"营业执照",@"身份证" ];
    
    [self initUI];
    
    [self requestShopImage];
}

/**
 *  获取商家图片
 */
- (void)requestShopImage {
    
    [[API shareAPI] getShopImg:^(id responseData) {
        NSLog(@"%@--%@",[self class],responseData);
        
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            
            NSDictionary *jsonVal = responseData[@"json_val"];
            NSString *imageHeadUrl = jsonVal[@"imageUrl"];
            NSString *cardLogo = [NSString stringWithFormat:@"%@",jsonVal[@"cardLogo"]];
            NSString *permitLogo = [NSString stringWithFormat:@"%@",jsonVal[@"permitLogo"]];
            NSString *logo = [NSString stringWithFormat:@"%@",jsonVal[@"logo"]];
            if (![logo hasPrefix:@"http://"] && logo.length) {
                logo = [NSString stringWithFormat:@"%@%@",imageHeadUrl,logo];
            }
            if (![permitLogo hasPrefix:@"http://"] && permitLogo.length) {
                permitLogo = [NSString stringWithFormat:@"%@%@",imageHeadUrl,permitLogo];
            }
            if (![cardLogo hasPrefix:@"http://"] && cardLogo.length) {
                cardLogo = [NSString stringWithFormat:@"%@%@",imageHeadUrl,cardLogo];
            }
            
            [self.imageArray addObject:logo];
            [self.imageArray addObject:permitLogo];
            [self.imageArray addObject:cardLogo];
            
            self.shopImageDict = [NSMutableDictionary dictionaryWithDictionary:jsonVal[@"thumbnails"]];
            
            for (NSString *key in self.shopImageDict.allKeys) {
                NSString *value = self.shopImageDict[key];
                if (![value hasPrefix:@"http://"]) {
                    value = [NSString stringWithFormat:@"%@%@",imageHeadUrl,value];
                }
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                [dict setValue:value forKey:key];
                [self.shopImages addObject:dict];
            }
            
//            // 获取商铺图片
//            NSDictionary *thumbnails = jsonVal[@"thumbnails"];
//            NSArray *shopImages = [thumbnails allValues];
//            for (NSInteger i = 0; i < shopImages.count; i++) {
//                NSString *imageName = shopImages[i];
//                if (![imageName hasPrefix:@"http://"]) {
//                    imageName = [NSString stringWithFormat:@"%@%@",imageHeadUrl,imageName];
//                }
//                [self.shopImages addObject:imageName];
//            }
            
            // 刷新表格
            [self.tableView reloadData];
        }
    }];
}

/**
 *  上传图片
 *
 *  @param imageData 图片文件
 */
- (void)requestUploadShopImageWithImageData:(NSData *)imageData {
    
    NSString *oldImage;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (!self.isShopImage) {
        
        oldImage = self.imageArray[indexPath.row];
        
    } else {
        
        if (self.shopImages.count > self.currentIndex) {
            oldImage = [self.shopImages[self.currentIndex] allValues].firstObject;
        } else {
            oldImage = @"null";
        }
    }
    
    [[API shareAPI] postShopImageWithImageData:imageData oldImage:oldImage completion:^(id responseData) {
        NSLog(@"responseData = %@",responseData);
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            
            NSDictionary *jsonVal = responseData[@"json_val"];
            NSString *key = jsonVal[@"code"];
            NSString *value = jsonVal[@"img"];
            
            // 如果上传的是门头照，营业执照，身份证
            if (!self.isShopImage) {
                
                [self.imageArray replaceObjectAtIndex:indexPath.row withObject:value];
                
            } else {
                
                // 如果选择的是店铺图片
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:value,key, nil];
                [self.shopImages addObject:dict];
                
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            }
            
        } else {
            
        }
    }];
}

- (void)requestSaveShopImage {
    
    NSUserDefaults *config = [NSUserDefaults standardUserDefaults];
    NSString *strShopID = [config objectForKey:G_SHOP_ID];
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:strShopID forKey:@"sellerId"];
    [parameter setValue:self.imageArray[0] forKey:@"logo"];
    [parameter setValue:self.imageArray[1] forKey:@"permitLogo"];
    [parameter setValue:self.imageArray[2] forKey:@"cardLogo"];
    
    NSMutableDictionary *thumbnails = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in self.shopImages) {
        [thumbnails addEntriesFromDictionary:dict];
    }
    
    // dic转json
    NSString *jsonStr = [[API shareAPI] objectToJson:thumbnails];
    [parameter setValue:jsonStr forKey:@"thumbnails"];
    
    [[API shareAPI] saveShopImageWithParameter:parameter completion:^(id responseData) {
        NSLog(@"requestSave = %@",responseData);
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            [API hudWithText:@"图片保存成功！"];
        }
    }];
}

- (void)requestDeleteImage {
    
    NSString *imageId = [self.shopImages[self.currentIndex] allKeys].firstObject;
    [[API shareAPI] deleteShopImageWithImageId:imageId completion:^(id responseData) {
        NSLog(@"requestDeleteImageWithImageId = %@",responseData);
        if ([responseData[@"json_code"] isEqualToString:@"1000"]) {
            [self.shopImages removeObjectAtIndex:self.currentIndex];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)initUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, G_SCREEN_WIDTH, G_SCREEN_HEIGHT - 85 - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.saveBtn setFrame:CGRectMake(15, G_SCREEN_HEIGHT - 45 - 20, G_SCREEN_WIDTH - 30, 45)];
}

#pragma mark - lazy load
- (UIButton *)saveBtn {
    if (!_saveBtn) {
        UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [saveBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [saveBtn setCornerRadius:5];
        [saveBtn setBackgroundColor:kThemeColor];
        [saveBtn addTarget:self action:@selector(onSaveBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:saveBtn];
        _saveBtn = saveBtn;
    }
    return _saveBtn;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (NSMutableArray *)shopImages {
    if (!_shopImages) {
        _shopImages = [NSMutableArray array];
    }
    return _shopImages;
}


#pragma mark - btn method
- (void)onSaveBtnClicked:(UIButton *)sender {
    NSLog(@"save");
    NSLog(@"indexPathForSelectedRow = %@",[self.tableView indexPathForSelectedRow]);
    [self requestSaveShopImage];
}


#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80.0f;
    } else {
        return 158.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        self.shopImage = NO;
        
        // 点击选择图片
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:@"拍照"
                                                        otherButtonTitles:@"相册", nil];
        [actionSheet showInView:self.view];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
        
        self.imageBlock = ^(UIImage *image) {
            imageView.image = image;
        };
    }
}

#pragma mark - TableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.titleArray.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString *kSingleImageCell = @"kSingleImageCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSingleImageCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSingleImageCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.textLabel.textColor = kTextColor2;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(114, 10, 60, 60)];
            imageView.image = [UIImage imageNamed:@"add_image"];
            imageView.tag = 101;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.userInteractionEnabled = YES;
            [imageView setCornerRadius:5];
            [cell.contentView addSubview:imageView];
            
        }
        
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
        cell.textLabel.text = self.titleArray[indexPath.row];
        if (self.imageArray.count) {
            
            if (indexPath.row <= self.imageArray.count) {
                
                NSString *imageName = self.imageArray[indexPath.row];
                if (imageName.length) {
                    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    [imageView bk_whenTapped:^{
                        
                        //1.封装图片数据
                        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
                        for (int i = 0; i < self.imageArray.count; i++) {
                            NSString *url = self.imageArray[i];
                            MJPhoto *photo = [[MJPhoto alloc] init];
                            photo.url = [NSURL URLWithString:url]; // 图片路径
                            [photos addObject:photo];
                        }
                        
                        // 2.显示相册
                        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
                        browser.currentPhotoIndex = indexPath.row; // 弹出相册时显示的第一张图片是？
                        browser.photos = photos; // 设置所有的图片
                        [browser show];
                    }];
                    
                } else {
                    imageView.image = [UIImage imageNamed:@"add_image"];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
        }
        return cell;
    } else {
        
        static NSString *kMultipleImageCell = @"kMultipleImageCell";
        MultipleImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMultipleImageCell];
        if (cell == nil) {
            cell = [[MultipleImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMultipleImageCell];
        }
        
        [cell updateCellLayoutWithImages:self.shopImages];
        
        // 图片轻击手势的回调
        cell.tapBlock = ^(UIImageView *imageView) {
            self.currentIndex = imageView.tag - 100;
            if (self.currentIndex < self.shopImages.count) {
                // 点击放大图片
                //1.封装图片数据
                NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
                for (int i = 0; i < self.shopImages.count; i++) {
                    NSString *url = [self.shopImages[i] allValues].firstObject;
                    MJPhoto *photo = [[MJPhoto alloc] init];
                    photo.url = [NSURL URLWithString:url]; // 图片路径
                    [photos addObject:photo];
                }
                
                // 2.显示相册
                MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
                browser.currentPhotoIndex = self.currentIndex; // 弹出相册时显示的第一张图片是？
                browser.photos = photos; // 设置所有的图片
                [browser show];
                
            } else if (self.currentIndex == self.shopImages.count) {
                
                self.shopImage = YES;
                
                // 点击选择图片
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                         delegate:self
                                                                cancelButtonTitle:@"取消"
                                                           destructiveButtonTitle:@"拍照"
                                                                otherButtonTitles:@"相册", nil];
                [actionSheet showInView:self.view];
                
                self.imageBlock = ^(UIImage *image) {
                    imageView.image = image;
                };
                
            } else {
                
            }
        };
        
        // 图片长按手势的回调
        cell.longPressBlock = ^(UIImageView *imageView) {
            self.currentIndex = imageView.tag - 100;
            if (self.currentIndex < self.shopImages.count) {
                
                // 长按删除
                [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"是否删除这张图片？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    if (buttonIndex) {
                        NSLog(@"删除");
                        [self requestDeleteImage];
                    }
                }];
                
            } else if (self.currentIndex == self.shopImages.count) {
                
                self.shopImage = YES;
                // 点击选择图片
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                         delegate:self
                                                                cancelButtonTitle:@"取消"
                                                           destructiveButtonTitle:@"拍照"
                                                                otherButtonTitles:@"相册", nil];
                [actionSheet showInView:self.view];
                
                self.imageBlock = ^(UIImage *image) {
                    imageView.image = image;
                };
                
            } else {
                
            }
        };
        
        return cell;
    }
}

#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (!buttonIndex) {                 //相机
        [self fromCamera];
    } else if (buttonIndex == 1) {      //相册
        [self fromPhotoLibrary];
    } else {
        return;
    }
    
}

- (void)fromCamera {
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
//        [API hudWithText:@"您的设备不支持拍照" atView:self.view];
        return;
    }
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"抱歉，你的设备未开启相机权限！" cancelButtonTitle:@"返回" otherButtonTitles:@[@"前往开启"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        }];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    picker.bk_didCancelBlock = ^(UIImagePickerController *picker){
        [picker dismissViewControllerAnimated:YES completion:NULL];
    };
    picker.bk_didFinishPickingMediaBlock = ^(UIImagePickerController *picker, NSDictionary *info) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        !self.imageBlock ? : self.imageBlock(image);
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        [self requestUploadShopImageWithImageData:imageData];
        [picker dismissViewControllerAnimated:YES completion:NULL];
    };
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)fromPhotoLibrary {
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied){
        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"抱歉，你的设备未开启相册权限！" cancelButtonTitle:@"返回" otherButtonTitles:@[@"前往开启"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        }];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.bk_didCancelBlock = ^(UIImagePickerController *picker){
        [picker dismissViewControllerAnimated:YES completion:NULL];
    };
    picker.bk_didFinishPickingMediaBlock = ^(UIImagePickerController *picker, NSDictionary *info) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        !self.imageBlock ? : self.imageBlock(image);
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        [self requestUploadShopImageWithImageData:imageData];
        [picker dismissViewControllerAnimated:YES completion:NULL];
    };
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end

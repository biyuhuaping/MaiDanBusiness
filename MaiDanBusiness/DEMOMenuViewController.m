//
//  DEMOMenuViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "DEMONavigationController.h"

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "AboutUsVC.h"
#import "UseDealVC.h"
#import "HelpVC.h"
#import "AppDelegate.h"
#import "BaseViewController.h"

@implementation DEMOMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cebianlan-bg"]];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.viewVC.isAction = !self.viewVC.isAction;
    [self.viewVC left];

    if (indexPath.row == 0)//关于我们
    {
        AboutUsVC *controller = [[AboutUsVC alloc] init];
        [self.viewVC.navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 1)//使用说明
    {
        HelpVC *controller = [[HelpVC alloc] init];
        [self.viewVC.navigationController pushViewController:controller animated:YES];
    }
    else if (indexPath.row == 2) //退出登录
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) //确定退出
    {
        LoginViewController *controller = [[LoginViewController alloc] init];
        controller.homeVC = self.viewVC;
        [[API shareAPI] saveLocalData:G_IS_LOGIN value:G_NO];

        //清空密码
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        
        [self.viewVC presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 3 ) {
        return 100;
    }
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    return 140;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,224, 75)];
    
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView*imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 85,110 ,35)];
    imgView.image = [UIImage imageNamed:@"cebianlan-logo"];
    imgView.backgroundColor = [UIColor clearColor];
    [view addSubview:imgView];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right + 8, imgView.bottom - 15, 66, 15)];
//    lable.centerX = imgView.centerX;
    lable.font = [UIFont systemFontOfSize:13];
    lable.text = [NSString stringWithFormat:@"V%@",appVersion];
    lable.textColor = [UIColor whiteColor];
    [view addSubview:lable];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 139, self.tableView.width, 1)];
    lineView.backgroundColor = RGBCOLOR(66, 49, 35);
    [view addSubview:lineView];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    static NSString *cellIdentifier1 = @"Cell4";
    UITableViewCell *cell;
    
    if (indexPath.row > 2 ) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];

            UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"maidan"]];
            imageV.frame = CGRectMake(30, 40, 155, 40);
            [cell.contentView addSubview:imageV];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
  
    }else{
     cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chengse64"]];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 53, self.tableView.width, 1)];
            lineView.backgroundColor = RGBCOLOR(66, 49, 35);
            [cell.contentView addSubview:lineView];
        }
        
        NSArray *titles = @[@"关于我们", @"使用说明",@"退出"];
        NSArray *images = @[@"icon_guanyu",@"icon_xieyi",@"icon_bangzhu",@"icon_tuichu"];
        
        cell.textLabel.text = titles[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
        
 
    }
    return cell;
}

@end

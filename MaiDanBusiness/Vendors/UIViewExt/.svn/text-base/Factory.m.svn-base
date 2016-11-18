//
//  Factory.m
//  Demo1
//
//  Created by lin on 16/1/7.
//  Copyright © 2016年 lin. All rights reserved.
//

#import "Factory.h"
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.f)
#define  MAXFLOAT    0x1.fffffep+127f
@implementation Factory


//龙哥factory
+ (UIButton *)createButtonWithfontSize:(CGFloat)size textCol:(UIColor*)col tag:(NSInteger)tag  frame:(CGRect)frame target:(id)target selector:(SEL)selector Title:(NSString *)title{
    UIButton *btn=[self createButtonWithframe:frame backgroundColor:RGB(75, 200, 255) target:target selector:selector Title:title ];
    btn.tag=tag;
    if (size) {
        btn.titleLabel.font=[UIFont systemFontOfSize:size];
    }else{
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
    }
    if (col) {
//        btn.titleLabel.textColor=col;
        [btn setTitleColor:col forState:UIControlStateNormal];
    }else{
//        btn.titleLabel.textColor=RGBCOLOR(51, 51, 51);
        [btn setTitleColor:RGBCOLOR(51, 51, 51) forState:UIControlStateNormal];
    }

    return btn;
}
+ (UIButton *)createButtonWithframe:(CGRect)frame target:(id)target selector:(SEL)selector Title:(NSString *)title {
    return [self createButtonWithframe:frame backgroundColor:RGB(75, 200, 255) target:target selector:selector Title:title ];
}

+ (UIButton *)createButtonWithframe:(CGRect)frame backgroundColor:(UIColor *)color target:(id)target selector:(SEL)selector Title:(NSString *)title {
    return [self createButtonWithframe:frame backgroundColor:color fontSize:14.f target:target selector:selector Title:title ];
}

+ (UIButton *)createButtonWithframe:(CGRect)frame backgroundColor:(UIColor *)color fontSize:(CGFloat)size target:(id)target selector:(SEL)selector Title:(NSString *)title {
    return [self createButtonWithframe:frame backgroundColor:color fontSize:size image:nil target:target selector:selector Title:title ];
}

+ (UIButton *)createButtonWithframe:(CGRect)frame backgroundColor:(UIColor *)color fontSize:(CGFloat)size image:(NSString *)image target:(id)target selector:(SEL)selector Title:(NSString *)title {
    return [self createButtonWithframe:frame backgroundColor:color fontSize:size image:image backgroundImage:nil target:target selector:selector Title:title ];
}

+ (UIButton *)createButtonWithframe:(CGRect)frame backgroundColor:(UIColor *)color fontSize:(CGFloat)size backgroundImage:(NSString *)bgImage target:(id)target selector:(SEL)selector Title:(NSString *)title {
    return [self createButtonWithframe:frame backgroundColor:color fontSize:size backgroundImage:bgImage target:target selector:selector Title:title ];
}

+ (UIButton *)createButtonWithframe:(CGRect)frame
                    backgroundColor:(UIColor *)color
                           fontSize:(CGFloat)size
                              image:(NSString *)image
                    backgroundImage:(NSString *)backgroundImage
                             target:(id)target
                           selector:(SEL)selector
                              Title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    button.layer.cornerRadius = 3.f;
    button.layer.masksToBounds = YES;
    button.titleLabel.textAlignment=NSTextAlignmentLeft;
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    button.backgroundColor = color;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//UILabel
+ (UILabel *)createLabelWithframe:(CGRect)frame Title:(NSString *)title {
    return [self createLabelWithframe:frame fontSize:14.f Title:title];
}

+ (UILabel *)createLabelWithframe:(CGRect)frame textColor:(UIColor *)color Title:(NSString *)title {
    return [self createLabelWithframe:frame tag:100 textColor:color backgroud:[UIColor whiteColor] fontSize:14.f Title:title ];
}
+ (UILabel *)createLabelWithframe:(CGRect)frame textColor:(UIColor *)color fontSize:(CGFloat)size  tag:(NSInteger)tag Title:(NSString *)title {
    return [self createLabelWithframe:frame tag:tag textColor:color backgroud:[UIColor whiteColor] fontSize:size Title:title ];
}
+ (UILabel *)createLabelWithframe:(CGRect)frame fontSize:(CGFloat)size Title:(NSString *)title {
    return [self createLabelWithframe:frame tag:100 textColor:[UIColor blackColor] backgroud:[UIColor whiteColor] fontSize:size Title:title ];
}

+ (UILabel *)createLabelWithframe:(CGRect)frame tag:(NSInteger)tag textColor:(UIColor *)color backgroud:(UIColor *)bcolor fontSize:(CGFloat)size Title:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    if (tag) {
        label.tag=tag;
    }
    if (color) {
        label.textColor = color;
    }
    if (bcolor) {
        label.backgroundColor=bcolor;
    }
    label.textAlignment=NSTextAlignmentLeft;
    label.numberOfLines=0;
    /*
     断字的模式
     NSLineBreakByWordWrapping          根据单词来断字
     NSLineBreakByCharWrapping          根据字符来断字
     NSLineBreakByClipping              简单裁减
     NSLineBreakByTruncatingHead        省略号在前
     NSLineBreakByTruncatingTail        省略号在尾
     NSLineBreakByTruncatingMiddle      省略号在中间
     */
    label.lineBreakMode = NSLineBreakByWordWrapping;
    if (size) {
        label.font = [UIFont systemFontOfSize:size];
    }else  label.font = [UIFont systemFontOfSize:14.f];
    //圆角
    label.layer.cornerRadius=0;
    label.layer.masksToBounds=YES;
    
    //设置标签的投影颜色
//    label.shadowColor = [UIColor blackColor];
    //设置标签投影的偏移
//    label.shadowOffset = CGSizeMake(1, 1);
  return label;
}

+ (UIView *)createViewWithBackgroundColor:(UIColor *)color frame:(CGRect)frame tag:(int)tag target:(id)target selector:(SEL)selector{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    if (color) {
       view.backgroundColor = color;
    }

    [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:target action:selector]];//图片手势
    if (view.tag) {
        view.tag=tag;
    }
    view.userInteractionEnabled = YES;
    return view;
}
+ (UIView *)createViewWithBackgroundColor:(UIColor *)color frame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}
+ (UITextField *)creatTextFieldWithframe:(CGRect)frame textColor:(UIColor *)color borderStyle:(UITextBorderStyle)borderStyle Text:(NSString *)text  placeholder:(NSString *)placeholder{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.borderStyle = borderStyle;
    textField.text = text;
    textField.textColor = color;
    return textField;
}
+(UIImageView *)creatImageViewWithFrame:(CGRect)frame tag:(int)tag target:(id)target selector:(SEL)selector image:(NSString*)image{
    UIImageView * img1=[[UIImageView alloc]initWithFrame:frame];
    [img1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:target action:selector]];//图片手势
    if (tag) {
        img1.tag=tag;
    }
    img1.userInteractionEnabled = YES;
    img1.image=[UIImage imageNamed:image];
    return img1;
}



//轩哥Factory
+ (UILabel *)creatLabelWithFrame:(CGRect)frame text:(NSString *)text{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor=RGBCOLOR(153, 153, 153);
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    return label;
}

+ (UIButton *)creatButtonWithFrame:(CGRect)frame target:(id)target sel:(SEL)sel tag:(NSInteger)tag image:(NSString *)name title:(NSString *)title{
    UIButton *button = nil;
    if (name) {
        //创建图片按钮
        //创建背景图片 按钮
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
        if (title) {//图片标题按钮
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }
        
    }else if (title) {
        //创建标题按钮
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    button.frame = frame;
    button.tag = tag;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+ (UIImageView *)creatImageViewWithFrame:(CGRect)frame imageName:(NSString *)name{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image  = [UIImage imageNamed:name];
    return imageView ;
}
+(UIView *)createViewWithFrame:(CGRect)frame tag:(NSInteger)tag target:(id)target selector:(SEL)selector isCenter:(BOOL)is Image:(NSString *)image Title:(NSString *)title titleDetail:(NSString *)detail {
    UIView *view=[Factory createViewWithBackgroundColor:[UIColor whiteColor] frame:frame];
    view.tag=tag;
    
    UIImageView *imageView=[Factory creatImageViewWithFrame:CGRectMake(8, 8, view.width-16, (view.height/10)*7-5) imageName:image];
    [view addSubview:imageView];
    UILabel *label1=[Factory createLabelWithframe:CGRectMake(8, imageView.bottom, view.width-8,(view.height/10)*1.5) textColor:[UIColor blackColor] Title:title ];
    label1.text=title;
    label1.textAlignment=is?NSTextAlignmentCenter:NSTextAlignmentLeft;
    
    [view addSubview:label1];
    if (detail) {
        UILabel *label2=[Factory createLabelWithframe:CGRectMake(5, label1.bottom, view.width-8,(view.height/10)*1.5) textColor:[UIColor redColor] Title:title ];
        label2.text=detail;
        label2.textAlignment=is?NSTextAlignmentCenter:NSTextAlignmentLeft;
        [view addSubview:label2];
    }
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:target action:selector]];//图片手势
    view.layer.borderColor=[[UIColor grayColor]CGColor];
    view.layer.borderWidth=1;
    return view;
}
+ (UITextField *)creatTextFieldWithFrame:(CGRect)frame delegate:(id<UITextFieldDelegate>)delegate tag:(NSInteger)tag placeHolder:(NSString *)string{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    //设置风格类型
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = string;
    //设置代理
    textField.delegate = delegate;
    
    textField.font = [UIFont systemFontOfSize:17];
    textField.secureTextEntry = NO;
    textField.layer.cornerRadius = 5.0;//
    [textField.layer setBorderWidth:0.25]; //边框宽度
    //设置tag值
    textField.tag = tag;
    return textField;
    
}
+(UITextView *)creatTextViewWithFrame:(CGRect)frame bgCol:(UIColor *)bg borC:(UIColor *)bc borW:(int)bw delegate:(id<UITextViewDelegate>)delegate tag:(NSInteger)tag fontSize:(CGFloat)size textCol:(UIColor *)tc placeHolder:(NSString *)string{
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    if (bg) {
        [textView setBackgroundColor:bg];
    }else if (string){
        textView.text=string; 
    }else if (size){
        textView.font=[UIFont systemFontOfSize:size];
    }else if (tc){
        textView.textColor=tc;
    }

    textView.delegate = delegate;
    if (tag) {
        textView.tag=tag;
    }

    // Command + k 调用模拟器键盘
    // 退出键盘
    // 1. 如果不允许换行，在textView代理方法中处理 (不实用)
    // 2. 设置键盘，提供退出键盘的按钮 // textView.inputAccessoryView
    // 3. 点击空白处，键盘消失 touchesBegin...
    // 作业：实现2和3退出键盘
    
    // 设置圆角和边框线
    if (bw) {
        textView.layer.borderColor = [bc CGColor];
        textView.layer.borderWidth = bw;
    }

//    textView.layer.cornerRadius = 8;
    //点击响应关闭
    // textView.userInteractionEnabled = NO;
    return textView;
}
+(UIView *)creatViewLabelWithframe:(CGRect)frame textCol:(NSArray *)cols Font:(NSArray*)fonts bgCol:(UIColor*)bcol tag:(NSArray*)tag titels:(NSArray*)titles{
    UIView *view=[Factory createViewWithBackgroundColor:bcol frame:frame];
    static CGFloat originX = 0;
    for (int i=0; i<titles.count; i++) {
        if ([titles[i] isKindOfClass:[NSNull class]]) {
            continue;
        }
        UILabel *label=[[UILabel alloc]init];
        if ([cols[i] isKindOfClass:[NSNull class]]) {
             continue;
        }else{
           label.textColor=cols[i];
        }
        if ([fonts[i] isKindOfClass:[NSNull class]]) {
            continue;
        }else{
            label.font=fonts[i];
        }
        if ([tag[i] isKindOfClass:[NSNull class]]) {
            continue;
        }else{
            label.tag=[tag[i] intValue];
        }
        label.text=titles[i];
        CGRect frame1 = CGRectMake(originX, 0, label.intrinsicContentSize.width, frame.size.height);
        label.frame=frame1;
        originX      = CGRectGetMaxX(frame1);
        
        [view addSubview:label];
    }
    originX=0;
    return view;
}
//获取iOS版本号
+ (double)getCurrentIOS {
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}

//动态 计算行高
//根据字符串的实际内容的多少 在固定的宽度和字体的大小，动态的计算出实际的高度
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    if ([Factory getCurrentIOS] >= 7.0) {
        //iOS7之后
        /*
         第一个参数: 预设空间 宽度固定  高度预设 一个最大值
         第二个参数: 行间距 如果超出范围是否截断
         第三个参数: 属性字典 可以设置字体大小
         */
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        //返回计算出的行高
        return rect.size.height;
        
    }else {
        //iOS7之前
        /*
         1.第一个参数  设置的字体固定大小
         2.预设 宽度和高度 宽度是固定的 高度一般写成最大值
         3.换行模式 字符换行
         */
        CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(textWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        return textSize.height;//返回 计算出得行高
    }
}
@end





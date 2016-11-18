//
//  NSObject+propertyCode.m
//  runtime
//
//  Created by apple on 1/6/16.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "NSObject+propertyCode.h"
#import <objc/runtime.h>

@implementation NSObject (propertyCode)

// 自动生成属性声明的代码

+ (void)sortedPropertyCodeWithDictionary:(NSDictionary *)dict {
    
    NSMutableString *strM = [NSMutableString string];
    NSArray *keys = [dict allKeys];
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;",obj];
        [strM appendFormat:@"\n%@",str];
    }];
    
    NSLog(@"%@",strM);
}

@end

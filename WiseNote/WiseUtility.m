//
//  WiseUtility.m
//  WiseNote
//
//  Created by 胡俊峰 on 9/10/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import "WiseUtility.h"

@implementation WiseUtility

+ (NSNumber *)timestamp{
    NSDate *now = [NSDate date];
    NSTimeInterval timestampValue = [now timeIntervalSince1970];
    
    NSNumber *timestamp = [NSNumber numberWithLongLong:timestampValue];
    return timestamp;
}

+ (CGFloat)screenWidth{
    
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight{
    
    return [UIScreen mainScreen].bounds.size.height;
}

@end

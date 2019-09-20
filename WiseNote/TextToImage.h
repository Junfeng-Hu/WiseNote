//
//  TextToImage.h
//  WiseNote
//
//  Created by 胡俊峰 on 9/19/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextToImage : UIImage

+ (UIImage *)imageWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width textAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END

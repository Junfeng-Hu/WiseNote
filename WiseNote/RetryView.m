//
//  RetryView.m
//  WiseNote
//
//  Created by 胡俊峰 on 9/17/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import "RetryView.h"
#import "WiseUtility.h"

@implementation RetryView

+ (RetryView *)retryViewWithText:(NSString *)text WithButtonText:(NSString *)buttonText WithTarget:(id)target WithSelector:(SEL)selector{
    RetryView* retryView = [[RetryView alloc] initWithFrame:CGRectMake(0, 64, [WiseUtility screenWidth], [WiseUtility screenHeight]-64)];
    
    NSString *tipsText = text;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(([WiseUtility screenWidth]-100)/2, (retryView.frame.size.height-100)/2-20, 100, 100)];
    titleLabel.text = tipsText;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
    [retryView addSubview:titleLabel];
    
    NSString *retryText = buttonText;
    CGSize size = CGSizeMake([WiseUtility screenWidth], 29);
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17.0f], NSFontAttributeName, nil];
    CGRect rect = [retryText boundingRectWithSize:size options:kNilOptions attributes:attributes context:nil];
    UIButton *retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat plannedWidth = rect.size.width + 20;
    if (plannedWidth < 55) {
        plannedWidth = 55;
    }
    [retryButton setFrame:CGRectMake(([WiseUtility screenWidth]-plannedWidth)/2, (retryView.frame.size.height-29)/2+20, plannedWidth, 29)];
    
    [retryButton setTitle:retryText forState:UIControlStateNormal];
    [retryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [retryButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    retryButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0f];
    retryButton.layer.cornerRadius = 5.0f;
    retryButton.layer.masksToBounds = YES;
    retryButton.layer.borderWidth = 1.0f;
    retryButton.layer.borderColor = [UIColor whiteColor].CGColor;
    retryButton.backgroundColor = [UIColor colorWithRed:0.72 green:0.22 blue:0.26 alpha:1.0];
    [retryButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    
    [retryView addSubview:retryButton];
    
    return retryView;
    
    
}

@end

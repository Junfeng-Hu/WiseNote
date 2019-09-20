//
//  BlankView.m
//  WiseNote
//
//  Created by 胡俊峰 on 9/17/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import "BlankView.h"
#import "WiseUtility.h"

@implementation BlankView

+ (BlankView *)blankViewWithText:(NSString *)text WithButtonText:(NSString *)buttonText WithTarget:(id)target WithSelector:(SEL)selector{
    BlankView* blankView = [[BlankView alloc] initWithFrame:CGRectMake(0, 64, [WiseUtility screenWidth], [WiseUtility screenHeight]-64)];
    
    NSString *tipsText = text;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(([WiseUtility screenWidth]-100)/2, (blankView.frame.size.height-100)/2-20, 100, 100)];
    titleLabel.text = tipsText;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20.0f];
    [blankView addSubview:titleLabel];
    
    NSString *writeText = buttonText;
    CGSize size = CGSizeMake([WiseUtility screenWidth], 29);
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17.0f], NSFontAttributeName, nil];
    CGRect rect = [writeText boundingRectWithSize:size options:kNilOptions attributes:attributes context:nil];
    UIButton *writeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat plannedWidth = rect.size.width + 20;
    if (plannedWidth < 55) {
        plannedWidth = 55;
    }
    [writeButton setFrame:CGRectMake(([WiseUtility screenWidth]-plannedWidth)/2, (blankView.frame.size.height-29)/2+20, plannedWidth, 29)];
    
    [writeButton setTitle:writeText forState:UIControlStateNormal];
    [writeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [writeButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    writeButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0f];
    writeButton.layer.cornerRadius = 5.0f;
    writeButton.layer.masksToBounds = YES;
    writeButton.layer.borderWidth = 1.0f;
    writeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    writeButton.backgroundColor = [UIColor colorWithRed:0.2 green:0.72 blue:0.46 alpha:1.0];
    [writeButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    
    [blankView addSubview:writeButton];
    
    return blankView;
    
}

@end

//
//  BlankView.h
//  WiseNote
//
//  Created by 胡俊峰 on 9/17/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlankView : UIView

+ (BlankView *)blankViewWithText:(NSString *)text
                  WithButtonText:(NSString *)buttonText
                      WithTarget:(id)target
                    WithSelector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END

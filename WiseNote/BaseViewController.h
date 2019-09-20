//
//  BaseViewController.h
//  WiseNote
//
//  Created by 胡俊峰 on 9/9/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

- (void)setTitleLabelWithTitle:(NSString *)title;

- (void)showLoading;

- (void)hideLoading;

@end

NS_ASSUME_NONNULL_END

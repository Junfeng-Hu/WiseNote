//
//  BaseViewController.m
//  WiseNote
//
//  Created by 胡俊峰 on 9/9/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import "BaseViewController.h"
#import "WiseUtility.h"

@interface BaseViewController ()

@property(nonatomic, strong) UIActivityIndicatorView *loading;

@end

@implementation BaseViewController

- (void)showLoading{
    
    if (self.loading == nil) {
        
        self.loading = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(([WiseUtility screenWidth]-20)/2, ([WiseUtility screenHeight]-20)/2, 20, 20)];
    }
    
    self.loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.loading startAnimating];
    
    [self.view addSubview:self.loading];
}

- (void)hideLoading{
    [self.loading stopAnimating];
    [self.loading removeFromSuperview];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.2 green:0.72 blue:0.46 alpha:1.0];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}


- (void)setTitleLabelWithTitle:(NSString *)title{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; 
    self.navigationItem.titleView = titleLabel;
    
}

@end

//
//  WiseDetailViewController.m
//  WiseNote
//
//  Created by 胡俊峰 on 9/9/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import "WiseDetailViewController.h"
#import "WiseTableViewCell.h"
#import "WiseUtility.h"
#import "WisePersistentManager.h"
#import "TextToImage.h"

@interface WiseDetailViewController ()

@property(nonatomic, strong) NSDictionary *dictionary;
@property(nonatomic, strong) UITextView *editView;
@property(nonatomic, strong) NSNumber *timestamp;

@end

@implementation WiseDetailViewController

- (void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)finishWithTimestamp{
    @try {
        // 如果没有输入任何内容，则下面的代码不执行即不存储
        if (self.editView.text.length == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"不能输入空内容"
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:action];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            return;
        }
        
       
//        NSNumber *timestamp = [WiseUtility timestamp];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.editView.text, @"content", self.timestamp, @"timestamp", nil];
        [WisePersistentManager saveNoteWithDictionary:dict];
        NSLog(@"%@", dict);
        
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        NSNotification *notification = [NSNotification notificationWithName:@"savedSuccess" object:nil];
        [center postNotification:notification];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } @catch (NSException *exception) {
        NSLog(@"存储失败");
    } @finally {
        // do nothing
    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [self setTitleLabelWithTitle:@"笔记"];
    
    
    
    self.editView = [[UITextView alloc] initWithFrame:CGRectMake(20, 84, self.view.frame.size.width-40, self.view.frame.size.height-80)];
    self.editView.text = [self.dictionary objectForKey:@"content"];
    self.timestamp = [self.dictionary objectForKey:@"timestamp"];
    
    self.editView.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20.0f];
    
    [self.editView becomeFirstResponder];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finishWithTimestamp)];
    
    
    [self.view addSubview:self.editView];
    
    
////    UILabel *content = [[UILabel alloc] init];
//
//    self.editView.text = [self.dictionary objectForKey:@"content"];
//    CGFloat height = [WiseTableViewCell contentHeightFromText:self.editView.text];
//    CGRect rect = CGRectMake(20, 0, [WiseUtility screenWidth]-40, height+40);
//    self.editView.frame = rect;
////    self.editView.numberOfLines = 0;
//    self.editView.textColor = [UIColor blackColor];
//    self.editView.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18.0f];
//    [self.editView becomeFirstResponder];
//
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
//    scrollView.contentSize = CGSizeMake([WiseUtility screenWidth]-40, height+200);
//
//
//    [scrollView addSubview:self.editView];
//
//    [self.view addSubview:scrollView];
}

- (void)setContentWithDictionary:(NSDictionary *)dictionary{
    self.dictionary = dictionary;
    
}

@end

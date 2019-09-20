//
//  WisePostViewController.m
//  WiseNote
//
//  Created by 胡俊峰 on 9/9/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import "WisePostViewController.h"
#import "WisePersistentManager.h"
#import "WiseUtility.h"

@interface WisePostViewController ()

@property(nonatomic, strong) UITextView *textView;

@end

@implementation WisePostViewController


- (void)cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)finish{
    @try {
       // 如果没有输入任何内容，则下面的代码不执行即不存储
        if (self.textView.text.length == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"不能输入空内容"
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:action];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            return;
        }
        
        
      // 如果输入文字超过两千字也不存储，且提醒用户
        
        NSNumber *timestamp = [WiseUtility timestamp];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.textView.text, @"content", timestamp, @"timestamp", nil];
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
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    [self setTitleLabelWithTitle:@"写笔记"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(finish)];
    
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 84, self.view.frame.size.width-40, self.view.frame.size.height-80)];
    
    self.textView.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20.0f];
    
    [self.textView becomeFirstResponder];
    
    [self.view addSubview:self.textView];
    
}



@end

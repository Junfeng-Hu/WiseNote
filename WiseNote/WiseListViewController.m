//
//  WiseListViewController.m
//  WiseNote
//
//  Created by 胡俊峰 on 9/9/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import "WiseListViewController.h"
#import "WiseDetailViewController.h"
#import "WisePostViewController.h"
#import "WiseTableViewCell.h"
#import "WiseUtility.h"
#import "BlankView.h"
#import "RetryView.h"

#import "WisePersistentManager.h"

@interface WiseListViewController ()

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIView *blankView;

@property(nonatomic, strong) UIView *retryView;

@property(nonatomic, strong) NSArray *notes;

@property(nonatomic) BOOL tableViewShowed;

@end

@implementation WiseListViewController


- (void)viewWillAppear:(BOOL)animated{
    if (self.tableView != nil) {
        NSIndexPath *selectingRow = self.tableView.indexPathForSelectedRow;
        if (selectingRow != nil) {
            [self.tableView deselectRowAtIndexPath:selectingRow animated:YES];
        }
    }
    
}

- (void)handleView{
    
//    [self hideLoading];
    if (self.notes == nil) {
        [self.tableView removeFromSuperview];
        [self.blankView removeFromSuperview];
        [self.retryView removeFromSuperview];
        self.tableViewShowed = NO;
        [self.view addSubview:self.retryView];
        return;
    }
    if ([self.notes count] == 0) {
        [self.tableView removeFromSuperview];
        [self.blankView removeFromSuperview];
        [self.retryView removeFromSuperview];
        self.tableViewShowed = NO;
        [self.view addSubview:self.blankView];
        return;
    }
    if (self.tableViewShowed) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        NSArray *rows = [NSArray arrayWithObjects:indexPath, nil];
        
        [self.tableView beginUpdates];
        
        [self.tableView insertRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationTop];
        
        [self.tableView endUpdates];
        
        return;
    }
    
    
     self.tableViewShowed = YES;
     [self.view addSubview:self.tableView];
     [self.tableView reloadData];
}

- (void)loadMoment{
    
//    [self showLoading];
    NSMutableArray *notesBeforeSorting = [WisePersistentManager getNote];
    if (self.notes.count == notesBeforeSorting.count) {
        self.notes = [notesBeforeSorting sortedArrayUsingComparator:^NSComparisonResult(NSDictionary* obj1, NSDictionary* obj2) {
            NSNumber *obj1Timestamp = [obj1 objectForKey:@"timestamp"];
            NSNumber *obj2Timestamp = [obj2 objectForKey:@"timestamp"];
            
            if (obj1Timestamp.integerValue > obj2Timestamp.integerValue) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            
            if (obj2Timestamp.integerValue > obj1Timestamp.integerValue ){
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            return (NSComparisonResult)NSOrderedSame;
            
        }];
        [self.tableView reloadData];
//        [self performSelector:@selector(hideLoading) withObject:nil afterDelay:0.3];
        if (self.tableViewShowed == YES) {
            return;
        }
        
    }
    
    self.notes = [notesBeforeSorting sortedArrayUsingComparator:^NSComparisonResult(NSDictionary* obj1, NSDictionary* obj2) {
        NSNumber *obj1Timestamp = [obj1 objectForKey:@"timestamp"];
        NSNumber *obj2Timestamp = [obj2 objectForKey:@"timestamp"];
        
        if (obj1Timestamp.integerValue > obj2Timestamp.integerValue) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        if (obj2Timestamp.integerValue > obj1Timestamp.integerValue ){
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
        
    }];

//    调用handleView来根据不同情况展示页面
//    [self handleView];
    [self performSelector:@selector(handleView) withObject:nil afterDelay:0.3];
   
}


-(void)post{
    WisePostViewController *postViewController = [[WisePostViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:postViewController];
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableViewShowed = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitleLabelWithTitle:@"慧记"];
    
//    列表页创建与初始化
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [WiseUtility screenWidth], [WiseUtility screenHeight] - 64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
//    空白页创建与初始化
    self.blankView = [BlankView blankViewWithText:@"空空如也"
                                   WithButtonText:@"去写篇随笔吧"
                                       WithTarget:self
                                     WithSelector:@selector(post)];
   
    
    
//    出错重试页创建与初始化
    self.retryView = [RetryView retryViewWithText:@"出错了!!!"
                                   WithButtonText:@"重试"
                                       WithTarget:self
                                     WithSelector:@selector(loadMoment)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(post)];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(loadMoment) name:@"savedSuccess" object:nil];
    
    [self loadMoment];
    

    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.notes count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dictionary = self.notes[indexPath.row];
    
    WiseTableViewCell *cell = [WiseTableViewCell prepareCellForTableView:tableView];
    
    [cell setContentWithDictionary:dictionary];
    
    return cell;
    
    
}

#pragma mark - 删除行及其数据
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *entity = [self.notes objectAtIndex:indexPath.row];
        
        [tableView beginUpdates];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [WisePersistentManager deleteNoteWithDictionary:entity];
//        self.notes = [WisePersistentManager getNote];
        self.tableViewShowed = NO;
        [self loadMoment];
        
        [tableView endUpdates];
    
        
    }
    
}

// 左滑显示删除按钮，文字为“删除”
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    NSDictionary *dictionary = self.notes[row];
    
    NSString *content = [dictionary objectForKey:@"content"];
    
    CGFloat height = [WiseTableViewCell cellHeightFromText:content];
    
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WiseDetailViewController *detailViewController = [[WiseDetailViewController alloc] init];
    [detailViewController setContentWithDictionary:self.notes[indexPath.row]];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}


@end

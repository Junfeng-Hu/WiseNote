//
//  WiseTableViewCell.h
//  WiseNote
//
//  Created by 胡俊峰 on 9/10/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WiseTableViewCell : UITableViewCell

+ (WiseTableViewCell *)prepareCellForTableView:(UITableView *)tableView;

- (void)setContentWithDictionary:(NSDictionary *)dictionary;

+ (CGFloat)contentHeightFromText:(NSString *)text;

+ (CGFloat)cellHeightFromText:(NSString *)text;


@end

NS_ASSUME_NONNULL_END

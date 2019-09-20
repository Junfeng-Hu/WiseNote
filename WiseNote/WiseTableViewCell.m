//
//  WiseTableViewCell.m
//  WiseNote
//
//  Created by 胡俊峰 on 9/10/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import "WiseTableViewCell.h"



@interface WiseTableViewCell()

@property(nonatomic, strong) UILabel *contentLabel;

@end


@implementation WiseTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    self.contentLabel.textColor = [UIColor blackColor];
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20.0f];
    
    [self.contentView addSubview:self.contentLabel];
    
    
    return self;
}

+ (CGFloat)contentHeightFromText:(NSString *)text{
    
    CGSize size = CGSizeMake(240, 99999);
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.0f], NSFontAttributeName, nil];
    
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dictionary context:nil];
    
    CGFloat height = rect.size.height;
    
    return height;
    
}

+ (CGFloat)cellHeightFromText:(NSString *)text{
    CGFloat contentHeight = [WiseTableViewCell contentHeightFromText:text];
    if (contentHeight > 200) {
        return contentHeight + 100;
    }
    
    return 200;
    
}


+ (WiseTableViewCell *)prepareCellForTableView:(UITableView *)tableView{
    WiseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"note"];
    
    if (cell == nil) {
        cell = [[WiseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"note"];
    }
    return cell;
    
}


- (void)setContentWithDictionary:(NSDictionary *)dictionary{
    
    self.contentLabel.text = [dictionary objectForKey:@"content"];
    self.contentLabel.numberOfLines = 0;
    
    CGFloat contentHeight = [WiseTableViewCell contentHeightFromText:self.contentLabel.text];
    
    CGFloat cellHeight = [WiseTableViewCell cellHeightFromText:self.contentLabel.text];
    
    CGRect rect = CGRectMake(([UIScreen mainScreen].bounds.size.width - 260)/2, (cellHeight - contentHeight)/2, 260, contentHeight);
    
    [self.contentLabel setFrame:rect];
    
}

@end

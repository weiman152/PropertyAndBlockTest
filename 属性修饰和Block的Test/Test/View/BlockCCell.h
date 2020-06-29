//
//  BlockCCell.h
//  Test
//
//  Created by wenhuanhuan on 2020/6/29.
//  Copyright © 2020 weiman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^BlockAction)(NSDictionary *);

@interface BlockCCell : UITableViewCell

@property(nonatomic, copy)BlockAction clickBlock;

+(instancetype)cellWithTableView:(UITableView *)tableView;
-(void)set: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

//
//  LastCell.h
//  Test
//
//  Created by wenhuanhuan on 2020/6/28.
//  Copyright © 2020 weiman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LastCell : UITableViewCell

@property(nonatomic,copy)void(^loadCell)(NSString *name);

+ (instancetype)loadLastWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

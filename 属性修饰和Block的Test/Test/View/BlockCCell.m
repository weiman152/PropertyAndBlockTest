//
//  BlockCCell.m
//  Test
//
//  Created by wenhuanhuan on 2020/6/29.
//  Copyright © 2020 weiman. All rights reserved.
//

#import "BlockCCell.h"

@interface BlockCCell()

@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;

@property (nonatomic, strong)NSDictionary * dict;

@end

@implementation BlockCCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    NSString * identifier = @"BlockCCell";
    BlockCCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.clickBtn.layer.masksToBounds = YES;
    self.clickBtn.layer.cornerRadius = 5;
}

-(void)set: (NSDictionary *)dict {
    self.numLabel.text = dict[@"num"];
    self.contentLabel.text = dict[@"content"];
    self.dict = dict;
}

- (IBAction)clickAction:(id)sender {
    NSLog(@"cell, 点击了 %@ 行", self.numLabel.text);
    if (self.clickBlock) {
        self.clickBlock(self.dict);
    }
}


@end

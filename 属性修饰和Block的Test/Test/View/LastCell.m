//
//  LastCell.m
//  Test
//
//  Created by wenhuanhuan on 2020/6/28.
//  Copyright © 2020 weiman. All rights reserved.
//

#import "LastCell.h"

@interface LastCell()

@property(nonatomic,strong)UIButton *btnClick;

@end

@implementation LastCell

+(instancetype)loadLastWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"LastCell";
    LastCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[LastCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.btnClick];
        self.btnClick.frame = CGRectMake(20, 10, 100, 40);
    }
    return self;
}

-(void)set:(NSString *)name {
    [self.btnClick setTitle:name forState:UIControlStateNormal];
}

- (void)btnClickAction{

    if (self.loadCell) {
        self.loadCell(self.btnClick.titleLabel.text);
    }

}
-(UIButton *)btnClick{

    if (!_btnClick) {

        _btnClick = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnClick.backgroundColor = [UIColor redColor];
         
        [_btnClick addTarget:self action:@selector(btnClickAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btnClick;
}
@end

//
//  BlockCController.m
//  Test
//
//  Created by wenhuanhuan on 2020/6/28.
//  Copyright © 2020 weiman. All rights reserved.
//

#import "BlockCController.h"
#import "BlockCCell.h"

@interface BlockCController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray * datas;

@end

@implementation BlockCController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setupData];
}

-(void)setup {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)setupData {
    NSArray * contents = @[@"床前明月光", @"疑是地上霜", @"举头望明月", @"低头思故乡"];
    NSMutableArray * temp = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[@"num"] = [NSString stringWithFormat:@"%d", i];
        NSString * str = contents[i%4];
        dict[@"content"] = str;
        [temp addObject:dict];
    }
    self.datas = temp;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlockCCell * cell = [BlockCCell cellWithTableView:tableView];
    NSDictionary * dict = self.datas[indexPath.row];
    [cell set:dict];
    cell.clickBlock = ^ (NSDictionary * dict) {
        NSLog(@"VC中，block实现,第%@行, 内容：%@", dict[@"num"], dict[@"content"]);
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - UITableViewDelegate


#pragma mark - lazy
-(NSArray *)datas {
    if (!_datas) {
        _datas = [NSArray array];
    }
    return _datas;
}


@end

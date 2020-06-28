//
//  LastPageViewController.m
//  Test
//
//  Created by wenhuanhuan on 2020/6/28.
//  Copyright © 2020 weiman. All rights reserved.
//

#import "LastPageViewController.h"
#import "LastCell.h"
@interface LastPageViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong)UITableView *TAB;
@property(nonatomic,copy)NSString *textName;
@end

@implementation LastPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TAB];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak LastPageViewController * weakSelf = self;
    LastCell *cell = [LastCell loadLastWithTableView:tableView];
    cell.loadCell = ^(NSString * _Nonnull name) {

        weakSelf.textName = name;
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    return cell;
}

-(UITableView *)TAB{

    if (!_TAB) {
        _TAB = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 300, 400) style:(UITableViewStylePlain)];
        _TAB.delegate = self;
        _TAB.dataSource = self;
    }
    return _TAB;
}

-(void)dealloc {
    NSLog(@"%@销毁了",NSStringFromClass([self class]));
}
@end

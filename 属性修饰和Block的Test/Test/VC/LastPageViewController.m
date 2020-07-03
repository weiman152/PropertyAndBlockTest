//
//  LastPageViewController.m
//  Test
//
//  Created by wenhuanhuan on 2020/6/28.
//  Copyright © 2020 weiman. All rights reserved.
//

#import "LastPageViewController.h"
#import "LastCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface LastPageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)UITableView *TAB;

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
    [cell set:[NSString stringWithFormat:@"%ld", indexPath.row]];
    cell.loadCell = ^(NSString * _Nonnull name) {
        NSLog(@"点击row = %@, 退出了", name);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(UITableView *)TAB{

    if (!_TAB) {
        _TAB = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-10) style:(UITableViewStylePlain)];
        _TAB.delegate = self;
        _TAB.dataSource = self;
    }
    return _TAB;
}

-(void)dealloc {
    NSLog(@"%@销毁了",NSStringFromClass([self class]));
}
@end

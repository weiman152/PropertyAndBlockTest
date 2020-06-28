//
//  BlockAController.m
//  Test
//
//  Created by wenhuanhuan on 2020/6/28.
//  Copyright © 2020 weiman. All rights reserved.
//

#import "BlockAController.h"
#import "BlockBController.h"

@interface BlockAController ()<BlockBControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *delegateValue;
@property (weak, nonatomic) IBOutlet UITextField *blockValue;

@end

@implementation BlockAController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

+(instancetype)instance {
    UIStoryboard * storyB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BlockAController * vc = [storyB instantiateViewControllerWithIdentifier:@"BlockAController"];
    return vc;
}


- (IBAction)gotoB:(id)sender {
    
    BlockBController * bVC = [BlockBController instance];
    bVC.delegate = self;
    __weak BlockAController * weakSelf = self;
    bVC.block1 = ^(NSString * name) {
        self.blockValue.text = name;
    };
    [self.navigationController pushViewController:bVC animated:YES];
    
}

#pragma mark - BlockBControllerDelegate
- (void)delegateB:(NSString *)name {
    self.delegateValue.text = name;
}

#pragma mark -
- (void)dealloc {
    
    NSLog(@"%@销毁了",NSStringFromClass([self class]));
}

@end

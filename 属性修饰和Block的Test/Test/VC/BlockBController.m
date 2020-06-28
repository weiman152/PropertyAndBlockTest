//
//  BlockBController.m
//  Test
//
//  Created by wenhuanhuan on 2020/6/28.
//  Copyright © 2020 weiman. All rights reserved.
//

#import "BlockBController.h"

@interface BlockBController ()
@property (weak, nonatomic) IBOutlet UITextField *input;

@end

@implementation BlockBController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)OKBtnClick:(id)sender {
    
    if (_input.text.length > 0) {
        
        if ([self.delegate respondsToSelector:@selector(delegateB:)]) {
            [self.delegate delegateB:_input.text];
            
        }
        
        if (self.block1) {
            self.block1(_input.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        NSLog(@"没有值");
    }
    
}

#pragma mark -
- (void)dealloc {
    NSLog(@"%@销毁了",NSStringFromClass([self class]));
}


@end

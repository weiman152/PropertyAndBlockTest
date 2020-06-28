//
//  BaseViewController.m
//  Test
//
//  Created by wenhuanhuan on 2020/6/28.
//  Copyright © 2020 weiman. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

+(instancetype)instance {
    UIStoryboard * storyB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BaseViewController * vc = [storyB instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    return vc;
}

@end

//
//  BlockDController.m
//  Test
//
//  Created by wenhuanhuan on 2020/7/4.
//  Copyright © 2020 weiman. All rights reserved.
//

#import "BlockDController.h"


int test1(int a);
int test2(int *a);

@interface BlockDController ()

@end

@implementation BlockDController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testC1];
    /**
     说明，此验证在另一个项目中BlockDTest
     */
}

- (void)testC1 {
    int num = 10;
    int r1 = test1(num);
    printf("r1 = %d num = %d\n\n", r1, num);
    
    int r2 = test2(&num);
    printf("r2 = %d num = %d\n\n", r2, num);
    
    
}

//值传递
int test1(int a) {
    return a+10;
}

//地址传递
int test2(int *a){
    return *a + 10;
}

//引用传递
//int test3(int &a) {
//    return a + 10;
//}

@end

//
//  MemoryController.m
//  Test
//
//  Created by wenhuanhuan on 2020/7/1.
//  Copyright © 2020 weiman. All rights reserved.
//

#import "MemoryController.h"

static NSString * name = @"xcode";

@interface MemoryController ()

@property(nonatomic, assign)int num;
@property(nonatomic, copy)void (^myBlock)(void);
@property(nonatomic, copy)void (^blockTest)(void);

@end

@implementation MemoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int age = 18;
    [self test8:^{
        NSLog(@"调用时，block作为参数，访问局部变量，age = %d", age);
    }];
    
}

//什么都不访问的Block：全局区
- (IBAction)test1:(id)sender {
    NSLog(@"---------%@--------", NSStringFromSelector(_cmd));
    
    void (^block) (void) = ^{
        NSLog(@"这是一个block，什么都没调用");
    };
    NSLog(@"%@", block);
    //调用
    block();
    
    printf("\n\n");
}

//访问静态全局变量的Block：全局区
- (IBAction)test4:(id)sender {
    NSLog(@"---------%@--------", NSStringFromSelector(_cmd));
    
    void (^block) (void) = ^{
        NSLog(@"block 静态全局变量 name = %@", name);
    };
    NSLog(@"%@", block);
    block();
    
    printf("\n\n");
}

//访问外部局部变量的Block：MRC栈区，ARC堆区
- (IBAction)test2:(id)sender {
    NSLog(@"---------%@--------", NSStringFromSelector(_cmd));
    
    int a = 10;
    void (^block)(void) = ^{
        NSLog(@"block 外部局部变量，a = %d", a);
    };
    NSLog(@"%@", block);
    block();
    
    __block int b = a;
       void (^block2)(void) = ^{
           b = 20;
           NSLog(@"block2 改变外部局部变量，b = %d", b);
       };
       NSLog(@"%@", block2);
       block2();
    
    printf("\n\n");
}

//访问外部全局变量的Block：MRC栈区，ARC堆区
- (IBAction)test3:(id)sender {
    NSLog(@"---------%@--------", NSStringFromSelector(_cmd));
   
    void (^block) (void) = ^{
        self.num = 300;
        NSLog(@"block 全局变量 num = %d", self.num);
    };
    NSLog(@"%@", block);
    block();
    
    printf("\n\n");
}

//本身是全局变量的Block：全局区
- (IBAction)test5:(id)sender {
    NSLog(@"---------%@--------", NSStringFromSelector(_cmd));
    
    void (^block)(void) = ^{
        NSLog(@"哈哈h哈哈");
    };
    
    NSLog(@"myBlock赋值之前：myBlock = %@, block = %@", self.myBlock, block);
    self.myBlock = block;
    NSLog(@"myBlock赋值之后：myBlock = %@, block = %@", self.myBlock, block);
    
    block();
    self.myBlock();
    NSLog(@"调用之后：myBlock = %@, block = %@", self.myBlock, block);
    printf("\n\n");
}

//全局block使用copy修饰，对于在栈区的block，赋值给全局copy修饰的block之后，全局block在堆区拷贝了一份。
- (IBAction)test6:(id)sender {
    NSLog(@"---------%@--------", NSStringFromSelector(_cmd));
    
    int a = 100000;
    void (^block)(void) = ^{
        NSLog(@"block 外部局部变量，a = %d", a);
    };
    NSLog(@"赋值之前：blockTest = %@, block = %@", self.blockTest, block);
    self.blockTest = block;
    NSLog(@"赋值之后：blockTest = %@, block = %@", self.blockTest, block);
    
    block();
}

//试试带参数的block
-(void)test7 {
    void (^block)(int) = ^ (int a){
        NSLog(@"hahhaha a = %d", a);
    };
    
    NSLog(@"%@", block);
    block(6);
    NSLog(@"%@", block);
}

//block作为参数
-(void)test8:(void (^)(void))block {
    NSLog(@"---------%@--------", NSStringFromSelector(_cmd));
    NSLog(@"函数中，block作为参数");
    NSLog(@"%@",block);
    block();
    printf("\n\n");
}

-(int)num {
    if (!_num) {
        _num = 100;
    }
    return _num;
}

-(void)dealloc {
    NSLog(@"%@销毁了",NSStringFromClass([self class]));
}

@end

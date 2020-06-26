//
//  BlockTestViewController.m
//  Test
//
//  Created by wenhuanhuan on 2020/6/22.
//  Copyright © 2020 weiman. All rights reserved.
//

#import "BlockTestViewController.h"

//给block起别名
typedef NSInteger (^SumBlock) (NSInteger, NSInteger);

//请求成功
typedef void (^SuccessBlock)(NSDictionary* json, int code);
//请求失败
typedef void (^FailBlock)(NSString* msg);

@interface BlockTestViewController ()

@property(nonatomic, copy)SumBlock block7;
@property(nonatomic, assign)int num;

@end

@implementation BlockTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self test1];
    //[self test2];
    //[self test4];
    //[self test6];
    
    [self test7];
}

//在block内部改变局部变量的值
-(void)test7 {
    //1.使用局部变量
    //要想在block内部使用局部变量，需要在局部变量前面加上__block
    __block int a = 100;
    int b = 20;
    void (^block)(void) = ^{
        NSLog(@"a = %d, b = %d", a,b);
        a = 200;
    };
    block();
    NSLog(@"after a = %d, b = %d", a,b);
    
    //2.使用全局变量
    self.num = 10;
    double (^block1) (void) = ^{
        self.num = 20;
        double t = self.num * 3.14;
        return t;
    };
    //使用block1
    double r = block1();
    NSLog(@"self.num = %d, r = %.2f", self.num, r);
    
}

//调用test5: block作为函数返回值
-(void)test6 {
    //有返回值，无参数的block作为函数返回值
    NSString* (^block)(void) = [self test5_1];
    NSLog(@"%@", block());
    
    //有返回值，有参数的block作为函数返回值
    NSString * (^block2)(NSString * name) = [self test5_2:@"小花花"];
    NSString * bReturn = block2(@"小点点");
    NSLog(@"最终的值： %@", bReturn);
}

//有返回值，无参数的block作为函数返回值
-(NSString* (^)(void))test5_1 {
    NSString * (^block)(void) = ^ NSString* {
        return @"我们都是好孩子";
    };
    return block;
}

//有返回值，有参数的block作为函数返回值
-(NSString* (^)(NSString* name))test5_2: (NSString *)testName {
    NSString * (^block)(NSString * name) = ^ NSString* (NSString* name) {
        return [NSString stringWithFormat:@"block的参数：%@",name];
    };
    NSLog(@"函数的参数： %@",testName);
    return block;
}

//调用test3系列：block作为参数
-(void)test4 {
    //有参数，有返回值的block作为参数
    [self test3:^NSString *(NSString *name) {
        NSLog(@"name = %@", name);
        return @"哇哈哈哈哈";
    }];
    //有参数，无返回值的block作为参数
    [self test3_1:^(NSString *name) {
        NSLog(@"我是block的参数，name = %@", name);
    }];
    //无参数，有返回值的block作为参数
    [self test3_2:^int{
        return 10;
    }];
    //函数也有返回值，block也有返回值
    NSArray * arr = [self test3_3:^NSArray *(NSArray *array) {
        //过滤重元素
        NSMutableArray * tempArray = [NSMutableArray array];
        BOOL flag = NO;
        for (NSNumber * num in array) {
            for (NSNumber * temp in tempArray) {
                if (num == temp) {
                    flag = YES;
                }
            }
            if (flag == NO) {
                [tempArray addObject:num];
            }
            flag = NO;
        }
        return tempArray;
    }];
    NSLog(@"测试的array： %@", arr);
    
    //应用实例
    [self loadDataSuccess:^(NSDictionary *json, int code) {
        NSLog(@"请求成功，%@", json);
    } fail:^(NSString *msg) {
        NSLog(@"%@", msg);
    }];
}

//block作为函数参数-1
//有参数，有返回值的block作为参数
-(void)test3:(NSString* (^)(NSString * name))block {
    NSString * newName = NSStringFromSelector(_cmd);
    NSLog(@"%@", block(newName));
}
//block作为函数参数-2
//有参数，无返回值的block作为参数
-(void)test3_1: (void (^)(NSString * name))block {
    NSString * myName = @"丹顶鹤";
    block(myName);
}

/**
 block作为函数参数-3
 无参数，有返回值的block作为参数
 */
-(void)test3_2: (int (^)(void))blcok {
    NSLog(@"我是test3_2");
    int a = blcok();
    NSLog(@"我是block的返回值哟， a = %d", a);
}

/**
block作为函数参数-5
函数也有返回值
*/
-(NSArray *)test3_3: (NSArray* (^)(NSArray* array))block {
    NSArray * myArray = @[@1,@2,@5,@8,@5,@7,@9,@7,@2,@1];
    return block(myArray);
}

/**
 block作为函数参数-4
 实际应用：模拟网络请求
 */
-(void)loadDataSuccess: (SuccessBlock)success fail:(FailBlock)fail {
    NSDictionary * json = @{@"num":@1,
                            @"name":@"小明",
                            @"age":@18,
                            @"phone":@"12345678922",
                            @"email":@"6666666@163.com"};
    int code = 200;
    if (code == 200) {
        success(json, code);
    } else {
        fail(@"请求失败了");
    }
}

//block作为全局变量
-(void)test2 {
    self.block7 = ^ NSInteger (NSInteger a, NSInteger b) {
        NSInteger sum = 0;
        for (NSInteger i = a; i < b + 1; i++) {
            sum = sum + i;
        }
        NSLog(@"从 %ld 到 %ld 的和为 %ld", a, b, sum);
        return sum;
    };
    
    if (self.block7) {
        //调用
        self.block7(0, 100);
        self.block7(0, 50);
    }
}

//block作为局部变量
-(void)test1 {
   /**
    返回值类型 （^Block名称）(参数列表) = ^ 返回值类型 （参数列表）{
       实现代码
    }
     */
    void (^block) (void) = ^ {
        NSLog(@"返回值为空，参数为空的block");
    };
    //使用block
    block();
    
    NSString * (^block1) (void) = ^{
        NSString * temp = @"返回值为字符串，参数为空的block";
        return temp;
    };
    //使用
    NSLog(@"%@", block1());
    
    NSInteger (^block2) (NSInteger) = ^ NSInteger (NSInteger a){
        NSInteger t = a * 10;
        return t;
    };
    NSInteger test2 = block2(3);
    NSLog(@"test2: %ld", (long)test2);
    
    //求两个数的和
    NSInteger (^block3) (NSInteger, NSInteger) = ^ NSInteger (NSInteger a, NSInteger b) {
        return a + b;
    };
    NSInteger test3 = block3(2, 7);
    NSLog(@"test3: %ld", test3);
    
    //求两个数的乘积
    double (^block4) (double, double) = ^double (double a, double b) {
        return a * b;
    };
    NSLog(@"test4: %.2f", block4(2.3, 4.7));
    
    //求两个数的加减乘除运算
    double (^block5) (double, double, NSString*) = ^ double (double a, double b, NSString* mark){
        
        if ([mark isEqualToString:@"+"]) {
            return a + b;
        } else if ([mark isEqualToString:@"-"]) {
            return a - b;
        } else if ([mark isEqualToString:@"*"]) {
            return a * b;
        } else if ([mark isEqualToString:@"/"]) {
            if (b == 0) {
                return -1;
            }
            return a / b;
        } else {
            return -1;
        }
    };
    
    NSLog(@"test5: %f", block5(4.0, 6.5, @"+"));
    NSLog(@"test6: %f", block5(7.8, 6.5, @"-"));
    NSLog(@"test7: %f", block5(2.4, 6.5, @"*"));
    NSLog(@"test8: %f", block5(4.8, 2.4, @"/"));
    
    //block赋值
    double (^block6) (double, double) = block4;
    //调用
    NSLog(@"test9: %.2f", block6(2.1, 3.8));
}

- (void)dealloc
{
    NSLog(@"%@销毁了",NSStringFromClass(self.class));
}

@end

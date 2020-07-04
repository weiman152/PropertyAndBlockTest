//
//  ViewController.m
//  Test
//
//  Created by wenhuanhuan on 2020/6/17.
//  Copyright © 2020 weiman. All rights reserved.
//

#import "ViewController.h"
#import "BlockAController.h"
#import "BlockCController.h"
#import "LastPageViewController.h"
#import "MemoryController.h"
#import "BlockDController.h"

@interface ViewController ()

@property(atomic,strong)NSString * name;

@property(nonatomic, strong)NSString * sA;
@property(nonatomic, weak)NSString * wA;
@property(nonatomic, copy)NSString * cA;
@property(nonatomic, retain)NSString * rA;

@property(nonatomic, strong)NSArray * sArr;
@property(nonatomic, weak)NSArray * wArr;
@property(nonatomic, copy)NSArray * cArr;
@property(nonatomic, retain)NSArray * rArr;

@property(nonatomic, weak)NSSet * wSet;
@property(nonatomic, assign)NSSet * aSet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test_p];
//    [self test_a];
    
}

//__Block问题探究
- (IBAction)blockDTest:(id)sender {
    BlockDController * dVC = [BlockDController instance];
    [self.navigationController pushViewController:dVC animated:YES];
}


//内存探究
- (IBAction)memoryTest:(id)sender {
    MemoryController * mVC = [MemoryController instance];
    [self.navigationController pushViewController:mVC animated:YES];
}

- (IBAction)circleTest:(id)sender {
    LastPageViewController *lastVC = [LastPageViewController instance];
    [self.navigationController pushViewController:lastVC animated:YES];
}

//传递事件
- (IBAction)eventTest:(id)sender {
    BlockCController * cVC = [BlockCController instance];
    [self.navigationController pushViewController:cVC animated:YES];
}

//传递值
- (IBAction)blockTransferValue:(id)sender {
    
    BlockAController * aVC = [BlockAController instance];
    [self.navigationController pushViewController:aVC animated:YES];
}

-(void)test_a {
    @autoreleasepool {
        NSSet * set = [NSSet setWithObjects:@"1", @"2", @"3", nil];
        [self printWithObj:set mark:@"set"];//retainCount: 1
        self.wSet = set;
        [self printWithObj:set mark:@"set weak"];//retainCount: 1
        self.aSet = set;
        [self printWithObj:set mark:@"set assign"];//retainCount: 1
           
        set = [NSSet setWithObjects:@"6", @"8", @"5", nil];
        [self printWithObj:set mark:@"set change"];
    }
   
    NSLog(@"self.wSet = %p  %@", self.wSet, self.wSet);
    //由于set已经释放了，self.aSet变成了野指针，访问野指针崩溃
    //NSLog(@"self.aSet = %p  %@", self.aSet, self.aSet);
}

-(void)test_p {
    
    NSLog(@"-------非集合，不可变类型---NSString------------\n");
    /**
    对于NSString类型,苹果做了优化，retainCount值为-1
    */
    NSString * sA1 = @"小莉莉";
    [self printWithObj:sA1 mark:@"NSString test1"];
    NSString * sA2 = [[NSString alloc]init];
    [self printWithObj:sA2 mark:@"NSString test2"];
    printf("\n\n");
    
    //使用如下方法创建的NSString对象，retainCount值为1
    NSString * str = [[NSString alloc] initWithUTF8String:"小红花"];
    [self printWithObj:str mark:@"NSString test3"];//retainCount = 1
    self.sA = str;
    [self printWithObj:str mark:@"NSString test4"];//retainCount = 2
    self.wA = str;
    [self printWithObj:str mark:@"NSString test5"];//retainCount = 2
    self.cA = str;
    [self printWithObj:str mark:@"NSString test6"];//retainCount = 3
    self.cA = @"copy";
    [self printWithObj:str mark:@"NSString test7"];//retainCount = 2
    self.rA = str;
    [self printWithObj:str mark:@"NSString test8"];//retainCount = 3
    
    
    printf("\n\n");
    NSLog(@"-------非集合，可变类型---NSMutableString------------\n");
    NSMutableString * mStr = [[NSMutableString alloc]initWithString:@"可变字符串"];
    [self printWithObj:mStr mark:@"NSMutableString test1"];//retainCount = 1
    self.sA = mStr;
    [self printWithObj:mStr mark:@"NSMutableString test2"];//retainCount = 2
    self.wA = mStr;
    [self printWithObj:mStr mark:@"NSMutableString test3"];//retainCount = 2
    self.cA = mStr;
    [self printWithObj:mStr mark:@"NSMutableString test4"];//retainCount = 2
    self.rA = mStr;
    [self printWithObj:mStr mark:@"NSMutableString test5"];//retainCount = 3
    [self printWithObj:self.sA mark:@"sA"];
    [self printWithObj:self.cA mark:@"cA"];
    
    printf("\n\n");
    NSLog(@"-------集合，不可变类型---NSArray------------\n");
    NSArray * arr = @[@1,@2];
    [self printWithObj:arr mark:@"NSArray test1"];//retainCount = 1
    self.sArr = arr;
    [self printWithObj:arr mark:@"NSArray test2"];//retainCount = 2
    self.wArr = arr;
    [self printWithObj:arr mark:@"NSArray test3"];//retainCount = 2
    self.cArr = arr;
    [self printWithObj:arr mark:@"NSArray test4"];//retainCount = 3
    self.cArr = @[@5, @6];
    [self printWithObj:arr mark:@"NSArray test4"];//retainCount = 2
    self.rArr = arr;
    [self printWithObj:arr mark:@"NSArray test5"];//retainCount = 3
    
    printf("\n\n");
    NSLog(@"-------集合，可变类型---NSMutableArray------------\n");
    NSMutableArray * mArr = [NSMutableArray arrayWithObjects:@"a",@"b", nil];
    [self printWithObj:mArr mark:@"NSMutableArray test1"];//retainCount = 1
    self.sArr = mArr;
    [self printWithObj:mArr mark:@"NSMutableArray test1"];//retainCount = 2
    self.wArr = mArr;
    [self printWithObj:mArr mark:@"NSMutableArray test1"];//retainCount = 2
    self.cArr = mArr;
    [self printWithObj:mArr mark:@"NSMutableArray test1"];//retainCount = 2
    self.cArr = @[@"iii"];
    [self printWithObj:mArr mark:@"NSMutableArray test1"];//retainCount = 2
    self.rArr = mArr;
    [self printWithObj:mArr mark:@"NSMutableArray test1"];//retainCount = 3
}

-(void)printWithObj: (id)obj mark: (NSString *)str {
    NSLog(@"%@ 值：%@， 地址： %p, retainCount: %ld", str, obj, obj, (unsigned long)[obj retainCount]);
}

-(void)test_atomic {
    self.name = @"hello";
    
    NSBlockOperation *blockA = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"blockA- %@",[NSThread currentThread]);
        NSLog(@"blockA name = %@", self.name);
    }];
    NSBlockOperation *blockB = [NSBlockOperation blockOperationWithBlock:^{
          
        NSLog(@"blockB- %@",[NSThread currentThread]);
        self.name = @"小橘子";
       }];
    NSBlockOperation *blockC = [NSBlockOperation blockOperationWithBlock:^{
          
         NSLog(@"-blockC-%@",[NSThread currentThread]);
         self.name = @"小土豆";
       }];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 3;

    [queue addOperation:blockA];
    [queue addOperation:blockB];
    [queue addOperation:blockC];
}


@end

//
//  main.c
//  BlockDTest
//
//  Created by wenhuanhuan on 2020/7/4.
//  Copyright © 2020 weiman. All rights reserved.
//

#include <stdio.h>

int test1(int a);
int test2(int *a);
int test3(int &a);
void myTest(void);
void blockTest(void);

int main(int argc, const char * argv[]) {
    
    blockTest();
    
    return 0;
}

void blockTest(void) {
    
    __block int age = 100;
    void (^myBlock)(void) = ^{
        age = 200;
        printf("age = %d\n", age);
    };
    myBlock();
}

void myTest(void) {
    int num1 = 10;
    printf("传递前：num1地址： %p\n", &num1);
    int r1 = test1(num1);
    printf("r1 = %d num1 = %d\n\n", r1, num1);
    
    int num2 = 10;
    printf("传递前：num2地址： %p\n", &num2);
    int r2 = test2(&num2);
    printf("r2 = %d num2 = %d\n\n", r2, num2);
    
    int num3 = 10;
    printf("传递前：num3地址： %p\n", &num3);
    int r3 = test3(num3);
    printf("r3 = %d num3 = %d\n\n", r3, num3);
}

//值传递
int test1(int a) {
    printf("test1 参数地址a = %p\n", &a);
    a = 20;
    return a;
}

//地址传递
int test2(int *a) {
    printf("test2 参数地址a = %p, *a = %p\n", &a, &(*a));
    *a = 20;
    return *a;
}

//引用传递
int test3(int &a) {
    printf("test3 参数地址a = %p\n", &a);
    a = 20;
    return a;
}

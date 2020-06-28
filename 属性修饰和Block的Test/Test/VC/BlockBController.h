//
//  BlockBController.h
//  Test
//
//  Created by wenhuanhuan on 2020/6/28.
//  Copyright © 2020 weiman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BlockBControllerDelegate <NSObject>
//代理传值
-(void)delegateB: (NSString *)name;
@end

typedef void (^BlockType)(NSString * name);

@interface BlockBController : BaseViewController

@property(nonatomic, weak)id<BlockBControllerDelegate>delegate;

@property(nonatomic, copy)BlockType block1;

@end

NS_ASSUME_NONNULL_END

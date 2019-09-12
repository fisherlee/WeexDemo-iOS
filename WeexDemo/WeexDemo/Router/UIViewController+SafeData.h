//
//  UIViewController+SafeData.h
//  WeexDemo
//
//  Created by lee on 2019/6/25.
//  Copyright © 2019 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SafeData)

- (id)safe_valueForKey:(nonnull NSString *)key;
- (id)safe_valueForClass:(nonnull Class)class;

@end

NS_ASSUME_NONNULL_END

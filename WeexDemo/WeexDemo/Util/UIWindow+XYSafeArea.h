//
//  UIWindow+XYSafeArea.h
//  AliyunPlayer
//
//  Created by lee on 2019/6/19.
//  Copyright © 2019 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (XYSafeArea)

- (UIEdgeInsets)xy_layoutInsets;
- (CGFloat)xy_navigationHeight;

@end

NS_ASSUME_NONNULL_END

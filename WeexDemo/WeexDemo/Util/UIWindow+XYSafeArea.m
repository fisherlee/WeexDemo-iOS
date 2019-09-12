//
//  UIWindow+XYSafeArea.m
//  AliyunPlayer
//
//  Created by lee on 2019/6/19.
//  Copyright © 2019 lee. All rights reserved.
//

#import "UIWindow+XYSafeArea.h"

@implementation UIWindow (XYSafeArea)

- (UIEdgeInsets)xy_layoutInsets
{
	if (@available(iOS 11.0, *)) {
		UIEdgeInsets safeAI = self.safeAreaInsets;
		if (safeAI.bottom > 0) {
			return safeAI;
		}
		UIEdgeInsetsMake(20, 0, 0, 0);
	}
	return UIEdgeInsetsMake(20, 0, 0, 0);
}

- (CGFloat)xy_navigationHeight
{
	return self.xy_layoutInsets.top + 44;
}

@end

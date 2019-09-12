//
//  UIViewController+SafeData.m
//  WeexDemo
//
//  Created by lee on 2019/6/25.
//  Copyright © 2019 lee. All rights reserved.
//

#import "UIViewController+SafeData.h"
#import <objc/runtime.h>

@implementation UIViewController (SafeData)

- (id)safe_valueForKey:(nonnull NSString *)key
{
	unsigned int p_count = 0;
	objc_property_t  *properties = class_copyPropertyList(self.class, &p_count);
	if (p_count > 0) {
		for (int i=0; i<p_count; i++) {
			objc_property_t item = properties[i];
			NSString *str_name = [NSString stringWithUTF8String:property_getName(item)];
			if ([key isEqualToString:str_name]) {
				return [self valueForKey:key];
			}
		}
	}
	return nil;
}

- (id)safe_valueForClass:(nonnull Class)class
{
	NSString *key = NSStringFromClass(class);
	unsigned int p_count = 0;
	objc_property_t  *properties = class_copyPropertyList(self.class, &p_count);
	if (p_count > 0) {
		for (int i=0; i<p_count; i++) {
			objc_property_t item = properties[i];
			NSString *str_name = [NSString stringWithUTF8String:property_getName(item)];
			if ([key isEqualToString:str_name]) {
				return [self valueForKey:key];
			}
		}
	}
	return nil;
}


@end



//
//  StoryboardRouter.m
//  VPlayer
//
//  Created by liwei on 2018/5/25.
//  Copyright © 2018年 liwei. All rights reserved.
//

#import "VPRouter.h"
#import <objc/runtime.h>

@implementation VPRouter

+ (VPRouter *)shareInstance
{
    static VPRouter *router = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[VPRouter alloc] init];
    });
    return router;
}


/**
 target: 目标UIViewController
 storyboard:@[storyboardName,storyboardId]
 type: 0=push; 1=present; 2=UIViewController加入UINavigation push
 */
- (void)router_storyboardTarget:(NSString *)target storyboard:(NSArray *)storyboard type:(NSInteger)type params:(NSDictionary *)params
{
	UIViewController *source = self;
	if (source == nil) {return;}
	
	Class target_class = NSClassFromString(target);
	if (target_class == nil) {return;}
	
	UIViewController *target_vc = (UIViewController *)target_class;
	if (target_vc == nil) {return;}
	
	if ([storyboard count] == 1) {
		NSString *sbId = storyboard[0];
		target_vc = [source.storyboard instantiateViewControllerWithIdentifier:sbId];
	}
	else if ([storyboard count] == 2) {
		NSString *sbId = storyboard[1];
		UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboard[0] bundle:nil];
		target_vc = [sb instantiateViewControllerWithIdentifier:sbId];
	}
	else {
		return;
	}
	
	if (params && params.count > 0) {
		unsigned int p_count = 0;
		objc_property_t  *properties = class_copyPropertyList(target_class, &p_count);
		if (p_count > 0) {
			for (int i=0; i<p_count; i++) {
				objc_property_t item = properties[i];
				NSString *str_name = [NSString stringWithUTF8String:property_getName(item)];
				if (params[str_name]) {
					[target_vc setValue:params[str_name] forKey:str_name];
				}
			}
		}
	}
	
	if (type == 0) {
		id nav_class = [source parentViewController];
		if (![nav_class isKindOfClass:[UINavigationController class]]) {
			return;
		}
		UINavigationController *nav = (UINavigationController *)nav_class;
		[nav pushViewController:target_vc animated:YES];
	}
	else if (type == 1) {
		[source presentViewController:target_vc animated:YES completion:nil];
	}
	else if (type == 2) {
		UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:target_vc];
		[source presentViewController:nav animated:YES completion:nil];
	}
	else if (type == 3) {
		[source presentViewController:target_vc animated:YES completion:nil];
	}
}

/**
[S:Self|ID:SS]

 **/
- (void)goToStoryboardTarget:(NSString *)target source:(id)source storyboard:(NSArray *)storyboard params:(NSDictionary *)params
{
	if (![source isKindOfClass:[UIViewController class]]) {
		return;
	}
	
    Class target_class = NSClassFromString(target);
    if (target_class == nil) {
        return;
    }
    Class target_super_class= [target_class superclass];
    NSString *target_super = NSStringFromClass(target_super_class);
    if (![target_super isEqualToString:@"UIViewController"]) {
        return;
    }
    UIViewController *vc = (UIViewController *)target_class;
    if (vc == nil) {
        return;
    }
    if ([storyboard count] != 2) {
        return;
    }
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboard[0] bundle:nil];
    NSString *sbId = storyboard[1];
    vc = [sb instantiateViewControllerWithIdentifier:sbId];
	if (vc == nil) {
		return;
	}
	
	if (params) {
		unsigned int count = 0;
		objc_property_t *proterty_list= class_copyPropertyList([vc class], &count);
		for (int i=0; i<count; i++) {
			objc_property_t item = proterty_list[i];
			NSString *property_name = [NSString stringWithUTF8String:property_getName(item)];
			NSLog(@"property_name: %@", property_name);
			if (params[property_name]) {
				[vc setValue:params[property_name] forKey:property_name];
			}
		}
		free(proterty_list);
	}
    
    id nav_class = [source parentViewController];
    if (![nav_class isKindOfClass:[UINavigationController class]]) {
		UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
		[(UIViewController *)source presentViewController:navController animated:YES completion:nil];
	}else {
		UINavigationController *nav = (UINavigationController *)nav_class;
		[nav pushViewController:vc animated:YES];
	}
}

@end

//
//  WXEventModule.m
//  VPlayer
//
//  Created by lee on 2019/4/19.
//  Copyright © 2019 liwei. All rights reserved.
//

#import "WXEventModule.h"

#import "AppHeader.h"

@implementation WXEventModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(dismissWeexView: callback:))
WX_EXPORT_METHOD(@selector(addContent: callback:))
WX_EXPORT_METHOD(@selector(showParams: callback:))
WX_EXPORT_METHOD(@selector(openData: callback:))
WX_EXPORT_METHOD(@selector(openTCData: callback:))
WX_EXPORT_METHOD(@selector(openViewData:))
WX_EXPORT_METHOD(@selector(openPageViewData:))

+ (void)load
{
	NSLog(@"----- %s", __FUNCTION__);
}

- (void)dismissWeexView:(id)obj callback:(WXKeepAliveCallback)callback
{
	if (callback) {
		[[self visibleViewController] dismissViewControllerAnimated:YES completion:nil];
	}
}

- (void)addContent:(id)param callback:(WXKeepAliveCallback)callback
{
	if (callback) {
		BOOL login = [[[NSUserDefaults standardUserDefaults] objectForKey:@"login_state"] boolValue];
		if (login) {
			UIView *view = [self visibleViewController].view;
			[view makeToast:@"哈哈哈😄"];
		}else {
			[[VPRouter shareInstance] goToStoryboardTarget:@"LoginViewController"
													source:[self visibleViewController]
												storyboard:@[@"Main", @"LoginStoryboardId"]
													params:nil];

		}
	
//		NSString *jsonStr = [self needLoginJson];
//		callback(jsonStr, NO);
	}
}

- (void)showParams:(id)param callback:(WXKeepAliveCallback)callback
{
	if (!param) {
		return;
	}
	NSLog(@"inputParam: %@", param);
//	PageViewModel *model = [[PageViewModel alloc] init];
//	model.vcTitle = param[@"title"]==nil?@"":param[@"title"];
//	model.urlString = param[@"url"]==nil?@"":param[@"url"];
//	[[VPRouter shareInstance] goToStoryboardTarget:@"ThirdViewController"
//											source:[self visibleViewController]
//										storyboard:@[@"Main", @"kThirdStoryboardId"]
//											params:@{@"page_model": model}];
	if (callback) {
		//Module 支持返回值给 JavaScript 中的回调，回调的类型是 WXModuleKeepAliveCallback。
		//回调的参数可以是 String 或者 Map。
		//该 block 第一个参数为回调给 JavaScript 的数据，第二参数是一个 BOOL 值，表示该回调执行完成之后是否要被清除。
		//JavaScript 每次调用都会产生一个回调，但是对于单独一次调用，是否要在完成该调用之后清除掉回调函数 id 就由这个选项控制，如非特殊场景，建议传 NO。

		callback(@"showParams:(id)param callback:(WXKeepAliveCallback)callback", NO);
	}
}

- (void)openTCData:(id)data callback:(WXKeepAliveCallback)callback
{
	NSString *jsonStr = [self tcDataListJson];
	callback(jsonStr, NO);
}

- (void)openData:(id)data callback:(WXKeepAliveCallback)callback
{
	BOOL login = [[[NSUserDefaults standardUserDefaults] objectForKey:@"login_state"] boolValue];
	if (login) {
		NSString *jsonStr = [self dataJson];
		callback(jsonStr, NO);
	}else {
		NSString *jsonStr = [self needLoginJson];
		callback(jsonStr, NO);
	}
	callback(@{@"n_title":@"native push", @"n_url":@"www.google.com"}, NO);
}

- (void)openViewData:(WXKeepAliveCallback)callback
{
	NSString *jsonStr = [self dataJson];
	callback(jsonStr, NO);
}

- (void)openPageViewData:(WXKeepAliveCallback)callback
{
	NSString *jsonStr = [self pageJson];
	callback(jsonStr, NO);
}

- (UIViewController *)visibleViewController {
	UIViewController *resultVC;
	resultVC = [self _visibleViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
	while (resultVC.presentedViewController) {
		resultVC = [self _visibleViewController:resultVC.presentedViewController];
	}
	return resultVC;
}

- (UIViewController *)_visibleViewController:(UIViewController *)vc {
	if ([vc isKindOfClass:[UINavigationController class]]) {
		return [self _visibleViewController:[(UINavigationController *)vc visibleViewController]];
	} else if ([vc isKindOfClass:[UITabBarController class]]) {
		return [self _visibleViewController:[(UITabBarController *)vc selectedViewController]];
	} else {
		return vc;
	}
	return nil;
}

#pragma mark - test json data

- (NSString *)tcDataListJson
{
	return [self stringConvertJson:@"mutipleDataList"];
}

- (NSString *)needLoginJson
{
	return [self stringConvertJson:@"needLogin"];
}

- (NSString *)dataJson
{
	return [self stringConvertJson:@"dataConfig"];
}

- (NSString *)pageJson
{
	return [self stringConvertJson:@"page"];
}

- (NSString *)stringConvertJson:(NSString *)json
{
	NSString *path = [[NSBundle mainBundle] pathForResource:json ofType:@"json"];
	if (!path) {
		return @"";
	}
	NSData *data = [NSData dataWithContentsOfFile:path];
	if (!data) {
		return @"";
	}
	NSError *error = nil;
	id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
	if (error) {
		return @"";
	}
	return (NSString *)obj;
}

@end

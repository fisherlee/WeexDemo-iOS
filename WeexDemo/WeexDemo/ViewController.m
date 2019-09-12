//
//  ViewController.m
//  WeexDemo
//
//  Created by lee on 2019/6/25.
//  Copyright © 2019 lee. All rights reserved.
//

#import "ViewController.h"
#import "AppHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)weexPage1Action:(id)sender
{
	PageViewModel *model = [[PageViewModel alloc] init];
	model.vcTitle = @"weex 1";
	model.vcDesc = @"desc weex 1";
	model.urlString = @"https://www.baidu.com";
	[[VPRouter shareInstance] goToStoryboardTarget:@"Weex1ViewController" source:self storyboard:@[@"Main", @"Weex1StoryboardId"] params:@{@"page_model": model}];
}

- (IBAction)netAction:(id)sender
{
	PageViewModel *model = [[PageViewModel alloc] init];
	model.vcTitle = @"weex 1";
	model.vcDesc = @"desc weex 1";
	model.urlString = @"https://www.baidu.com";
	[[VPRouter shareInstance] goToStoryboardTarget:@"NetTextViewController" source:self storyboard:@[@"Main", @"kNetTextStoryboardId"] params:@{@"page_model": model}];
}





@end

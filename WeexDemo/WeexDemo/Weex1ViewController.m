//
//  Weex1ViewController.m
//  WeexDemo
//
//  Created by lee on 2019/6/25.
//  Copyright © 2019 lee. All rights reserved.
//

#import "Weex1ViewController.h"
#import "DemoDefine.h"
#import "AppHeader.h"

@interface Weex1ViewController ()


@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;
@property (nonatomic, strong) PageViewModel *page_model;

@end

@implementation Weex1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1];
	
	[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"login_state"];
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
	self.navigationItem.leftBarButtonItem = backButton;
	
	self.page_model = [self safe_valueForKey:@"page_model"];
	
	NSLog(@"model[%@]-- title: %@ \n desc: %@ \n url: %@", self.page_model, self.page_model.vcTitle, self.page_model.vcDesc, self.page_model.urlString);

}


- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:YES];
	[self weexInstance];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:YES];
}

- (void)backAction
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)weexInstance
{
	CGFloat safeTop = [UIApplication sharedApplication].keyWindow.xy_navigationHeight;
	CGFloat safeBottom = [UIApplication sharedApplication].keyWindow.xy_layoutInsets.bottom;
	[_instance destroyInstance];
	_instance = [[WXSDKInstance alloc] init];
	_instance.viewController = self;
	_instance.frame = CGRectMake(0, safeTop, self.view.bounds.size.width, self.view.bounds.size.height-safeTop);
	__weak typeof(self) weakSelf = self;
	_instance.onCreate = ^(UIView *view) {
		[weakSelf.weexView removeFromSuperview];
		weakSelf.weexView = view;
		[weakSelf.view addSubview:weakSelf.weexView];
	};
	_instance.onFailed = ^(NSError *error) {
		//process failure, you could open an h5 web page instead or just show the error.
	};
	_instance.renderFinish = ^ (UIView *view) {
		//process renderFinish
	};
	
	NSURL *URL = [NSURL URLWithString:BUNDLE_URL];
	NSString *randomURL = [NSString stringWithFormat:@"%@%@random=%d",URL.absoluteString,URL.query?@"&":@"?",arc4random()];
	
	[_instance renderWithURL:[NSURL URLWithString:randomURL] options:@{@"bundleUrl":URL.absoluteString} data:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

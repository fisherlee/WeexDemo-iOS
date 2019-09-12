//
//  LoginViewController.m
//  WeexDemo
//
//  Created by lee on 2019/6/28.
//  Copyright © 2019 lee. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loginAction:(id)sender
{
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"login_state"];
	
	[self.navigationController popViewControllerAnimated:YES];
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

//
//  NetTextViewController.m
//  WeexDemo
//
//  Created by lee on 2019/7/8.
//  Copyright © 2019 lee. All rights reserved.
//

#import "NetTextViewController.h"
#import "AppHeader.h"

static NSString * const base_url = @"https://accpbet.sporttery.cn";

static NSString * const url_path = @"/igw/v1.0/?m=getGatherConfig&c=appConfig&d=app&useCookie=1&channel=ios_appstore&vid=1941000&platform=2";

static NSString * const content_value = @"8Y3lcfjeMgJub82tQMJWaONs4R+fzYhjQRGOXii9G4nvP6YYPx6P6rKrKnrYwmWbwKZOKFZv9MZQUzAKOnmib9JAAyAlvGNOX+Y6r5eVQ3bZPnxTv1wdY5YWvgNLq2CxNF1kjOS8WZYcllEGt2H532sskbr+tlIaniBGPw3G2VSPdVOwDNcWZP0SnQgNmB/NiCIRlip5vw+VS6/vu2ga+IrZW6f5HeYPFHnOluhVwaH3KEdDsbMoe4GFjb7V7Hk3HgITkO4EkcYp1o6+0UMyW4w19zUxi9jUW/YKSqsg5NOrdM6i+C0yZhzuHphMTeg97zGWHYA53LPN5QNt+UoGsrH60bN2BkorNpisuVPgGyLcUbJbXj+Ux8hszyJxpBVM6mokZ1kmPoR/zsCiBBTAB/2xQUQ8I1Hs8v1kWBop9dx+YWCDtKcHe48d+Uj0ny33TMY+weVAKqpWzWo+yV3aSm+a/r4IK9kwGWqZef4tZVRPUCZHfvnxx06by1jRqtIfhRymVvzZKGjSQC2NRBERE7A8DQR1Pq4LlFKan4TfkN+QKkkRzSK1TcFrNSWKF1eb5elmxqVWmtTENmogxoUwPq+Gj9aZvY3dcbjKPPjQ/PEQmjh+q2IdaDYo6PJy+/jrZZ5JxMmz1RMeDLiWmMBxQJ1Tc5N6SwXqbunuvKn2Xd/h/F0etcZge2APxeR4wy4YQmRXaIGIs5FawEJgdETmKura9RPTJ5ftpOv+hex8CA7FCJfK6Lvqw79dANrH2Vov260DIxSyw028mxp+LDM5qrxHoAblTgNRRFwznDWogMt9/JsFmkvdCZKgXDmkiEJ8RpSZ6H0/+YimhwcixiE4upy2wTdabvMUx0SR7+JUgrxC4sF47cxrur25NBzmpxoLvfkMS+IyN84a0K+IXV6IsnEEFDybhOZc/k549AMLJlJeeAsTfqBGtPbe1FQjB2RQhRuSfS2pOCXz+9bwVMLZo0RP59YbAcV2MwukqB+Xu4w0egq/a7xpcTF0L/6GglchELU9ynoxsAOvqkfMacnIeFkFbRYZu9kV+g5WCF2f9BYNGskkxZTmewvmsBFa6Jf8yExDa7OLceG5NQX6RfWOEmUGMgxD+OatZK0/zxLBGg2I0+xXi4fttSKP/gyWrUfLk4uR+YIVMv6gtnZuInvz0tha79Y8YP/JMVKTVl8TsN18DX4rSJP5/ELENJ9xDnvakIzKbtppdp79t6uI87vWVLC1LzuMdAFCzoAI91uYsTR6BiEyrMqnzEJOohIw0I4ltiVI2DRkmALRq3npZ5rZrEc4mluXF7AdhIrx31GLIA6CUu0eigDd7Cnhkqb/VpAb7bYuWgR7oH/wGRqe1lahHc8IMA3gTno4Dp0tjiMaYGjpRM8QesOgIIFyg7VncBSsk66KvpDWlnqwga87SVJ7sPs0SUmViU9crSHF17jfo/jSdLQK7/dM80UmgPPYYDMziEYkxPQWrsnk0kYHF54YxrJVCW2NZTSot/NyH7472tGw9kXCKY5XXJfpmqJDGfJx6FsrpQ9agZStOe1JLrMrumh47WbwHrs4wHvTGzYy2S8Yf0zdAi/9UaosoUlJSU22hUJqbUJI3XS4rxFC5FOjYtTirSMO6yE0SMDpeUO+nUwrN7jV7awxvSvv1wWkkMz+GxJktaKMaEpoShrbxAN378G6tz+/qnidQh9B6hcHL72mkZpD+eBdC2QKy5YDpkOjASuejR3LYFe+1OQc5LO9GpArIzjg+1z0H9Qc2l5hKp4VBJEOfzR6BPTuVQCEw5iocd4RJwtD5dCp4Tq9Mot+rr+Lk2r4m1wMrgQr+NcwKfz5IvaAHNfSwXloPn9tJEfVIcgnXP/9xXfOYMvugcSKp5pcjVPUPVeU9Gz+VUtQalxHBXPVhJ+OqwxVN946a87l";

@interface NetTextViewController ()

@property (nonatomic, weak) IBOutlet UIBarButtonItem *closeButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *refreshButton;
@property (nonatomic, weak) IBOutlet UITextView *contentTextView;

@end

@implementation NetTextViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	_contentTextView.layer.borderWidth = 1;
	_contentTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
	_contentTextView.layer.cornerRadius = 3;
}

- (IBAction)closeButtonAction:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)refreshButtonAction:(id)sender
{
	[self wd_net];
}

#pragma mark - net

- (void)wd_net
{
	NSURL *baseUrl = [NSURL URLWithString:[self baseUrl]];
	AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
	sessionManager.requestSerializer.timeoutInterval = 30;
	sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
	sessionManager.securityPolicy.validatesDomainName = NO;
	sessionManager.securityPolicy.allowInvalidCertificates = YES;
	//返回格式 JSON
	sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
	//设置返回C的ontent-type
	sessionManager.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/x-json",@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
	
	__weak typeof(self) weakSelf = self;
	[sessionManager POST:[self urlPath]
			  parameters:[self paramDict]
				progress:^(NSProgress * _Nonnull uploadProgress) {
					
				}
				 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
					 NSLog(@"success %@", responseObject);
					 NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
					 NSString *jsonStr = @"数据解析失败";
					 if (jsonData) {
						 jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
					 }
					 jsonStr = [NSString stringWithFormat:@"url:\n`%@` \n response:\n`%@`", url_path, jsonStr];
					 weakSelf.contentTextView.text = jsonStr;
				 }
				 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
					 NSLog(@"failure %@", error);
					 weakSelf.contentTextView.text = error.description;
				 }];
}

#pragma mark - private

- (NSString *)baseUrl
{
	return base_url;
}

- (NSString *)urlPath
{
	
	return url_path;
}

- (NSDictionary *)paramDict
{
	return @{@"content": content_value};
}


@end

//
//  StoryboardRouter.h
//  VPlayer
//
//  Created by liwei on 2018/5/25.
//  Copyright © 2018年 liwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VPRouter : NSObject

+ (VPRouter *)shareInstance;
- (void)goToStoryboardTarget:(NSString *)target source:(id)source storyboard:(NSArray *)storyboard params:(NSDictionary *)params;


@end

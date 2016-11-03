//
//  AppDelegate.m
//  bradley
//
//  Created by bradleyjohnson on 16/8/25.
//  Copyright © 2016年 bradleyjohnson. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  当其他APP通过应用跳转打开该APP时调用
 *
 *  @param app     应用对象
 *  @param url     跳转打开该APP的url
 *  @param options 选项
 *
 *  @return 是否允许打开该APP
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    
    NSLog(@"URL : %@",url);
    
    NSString * urlschemes = [[url.absoluteString componentsSeparatedByString:@"//"][1] componentsSeparatedByString:@"?"][0];
    
    NSLog(@"URL Schemes : %@",urlschemes);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 延时3s模拟处理后回调指定的 URL Schemes并传递结果
        
        if ([[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] integerValue] == 10) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://?resultcode=6000&errormessage=paysuccess",urlschemes]] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:^(BOOL success) {
                
                NSString * successStr = success?@"跳转成功":@"跳转失败";
                
                NSLog(@"%@",successStr);
                
            }];
        } else {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"bradley://"]]) {
                
                NSLog(@"跳转成功");
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://?resultcode=6000&errormessage=paysuccess",urlschemes]]];
                
            }else{
                NSLog(@"跳转失败");
                NSLog(@"未安装应用!");
            }
        }
        
    });

    return YES;
}


@end

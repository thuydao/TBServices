//
//  TDReachability.m
//  FrameWork
//
//  Created by Dao Duy Thuy on 5/20/14.
//  Copyright (c) 2014 TD. All rights reserved.
//

#import "TDReachability.h"
#import "WBErrorNoticeView.h"

@implementation TDReachability

+ (id)shared
{
    static TDReachability *share = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (!share) {
            share = [[TDReachability alloc] init];
            
            Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
            
            reach.reachableBlock = ^(Reachability * reachability)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //connected
                    NSLog(@"Notification Says Reachable");
                    if (reachability.isReachableViaWWAN) {
                        NSLog(@"\n wan");
                    }
                    
                    if (reachability.isReachableViaWiFi) {
                        NSLog(@"\n wifi");
                    }
                });
            };
            
            reach.unreachableBlock = ^(Reachability * reachability)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //disable
                    UIWindow *mainWindow = [UIApplication sharedApplication].windows[0];
                    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInView:mainWindow title:@"Network Error" message:@"Check your network connection."];
                    [notice show];
                });
            };
            [reach startNotifier];
        }
    });
    
    return share;
}


+ (BOOL)connectedToNetwork
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

@end

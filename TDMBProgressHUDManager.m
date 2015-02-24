//
//  TDMBProgressHUDManager.m
//  SCP490
//
//  Created by thuydd on 1/21/15.
//  Copyright (c) 2015 QSoft. All rights reserved.
//

#import "TDMBProgressHUDManager.h"


@implementation TDMBProgressHUDManager

+ (instancetype)sharedInstance {
    static TDMBProgressHUDManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TDMBProgressHUDManager alloc] init];
        sharedInstance.countProgress = 0;
    });
    return sharedInstance;
}

/// + 1 into coutProgress. When count == 1, show loading
+ (void)showLoading {
    [TDMBProgressHUDManager sharedInstance].countProgress += 1;
    if ([TDMBProgressHUDManager sharedInstance].countProgress == 1) {
        [MBProgressHUD showHUDAddedTo:[SCAppDelegate shareAppDelegate].window animated:YES];
    }
}

/// - 1 into coutProgress. When count == 0, hide loading
+ (void)hideLoading {
    [TDMBProgressHUDManager sharedInstance].countProgress -= 1;
    if ( [TDMBProgressHUDManager sharedInstance].countProgress < 0)  [TDMBProgressHUDManager sharedInstance].countProgress  = 0;
    if ([TDMBProgressHUDManager sharedInstance].countProgress == 0) {
        [MBProgressHUD hideAllHUDsForView:[SCAppDelegate shareAppDelegate].window animated:YES];
    }
}


@end

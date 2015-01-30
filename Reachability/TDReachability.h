//
//  TDReachability.h
//  FrameWork
//
//  Created by Dao Duy Thuy on 5/20/14.
//  Copyright (c) 2014 TD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface TDReachability : NSObject

+ (id)shared;
+ (BOOL)connectedToNetwork;

@end

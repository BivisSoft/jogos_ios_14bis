//
//  Runner.m
//  bis
//

#import "Runner.h"

@implementation Runner

#pragma mark Singleton

static Runner *sharedRunner = nil;
+ (Runner *)sharedRunner
{
    if (!sharedRunner) {
        sharedRunner = [[Runner alloc] init];
    }
    return sharedRunner;
}

@end

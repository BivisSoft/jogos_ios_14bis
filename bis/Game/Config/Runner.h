//
//  Runner.h
//  bis
//

#import <Foundation/Foundation.h>

@interface Runner : NSObject

@property (nonatomic, assign, getter = isGamePaused) BOOL gamePaused;

+ (Runner *)sharedRunner;

@end

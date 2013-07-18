//
//  PauseScreen.h
//  bis
//

#import "CCLayer.h"

@protocol PauseScreenDelegate;

@interface PauseScreen : CCLayer

@property (nonatomic, assign) id<PauseScreenDelegate>delegate;

+ (PauseScreen *)pauseScreen;

@end


@protocol PauseScreenDelegate <NSObject>

- (void)pauseScreenWillResumeGame:(PauseScreen *)pauseScreen;
- (void)pauseScreenWillQuitGame:(PauseScreen *)pauseScreen;

@end

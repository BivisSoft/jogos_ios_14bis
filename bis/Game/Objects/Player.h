//
//  Player.h
//  bis
//

#import "Shoot.h"
#import "Accelerometer.h"

@protocol PlayerDelegate;

@interface Player : CCSprite

@property (nonatomic, assign) id<PlayerDelegate>delegate;

@property (nonatomic, assign) float positionX;
@property (nonatomic, assign) float positionY;

+ (Player *)player;

- (void)monitorAccelerometer;

- (void)moveLeft;
- (void)moveRight;
- (void)shoot;

- (void)explode;

@end


@protocol PlayerDelegate <NSObject>

- (void)playerDidCreateShoot:(Shoot *)shoot;

@end

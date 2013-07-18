//
//  Shoot.h
//  bis
//

#import "CCSprite.h"

@protocol ShootDelegate;

@interface Shoot : CCSprite

@property (nonatomic, assign) id<ShootDelegate>delegate;

@property (nonatomic, assign) float positionX;
@property (nonatomic, assign) float positionY;

+ (Shoot *)shootWithPositionX:(float)positionX andPositionY:(float)positionY;

- (void)start;
- (void)explode;

@end


@protocol ShootDelegate <NSObject>

- (void)shootWillBeRemoved:(Shoot *)shoot;

@end

//
//  Meteor.h
//  bis
//

#import "CCSprite.h"

@protocol MeteorDelegate;

@interface Meteor : CCSprite

@property (nonatomic, assign) id<MeteorDelegate>delegate;

@property (nonatomic, assign) float positionX;
@property (nonatomic, assign) float positionY;

+ (Meteor *)meteorWithImage:(NSString *)image;

- (void)start;
- (void)gotShot;

@end


@protocol MeteorDelegate <NSObject>

- (void)meteorWillBeRemoved:(Meteor *)meteor;

@end

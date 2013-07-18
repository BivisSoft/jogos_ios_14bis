//
//  MeteorsEngine.h
//  bis
//

#import "Meteor.h"

@protocol MeteorsEngineDelegate;

@interface MeteorsEngine : CCLayer

@property (nonatomic, assign) id<MeteorsEngineDelegate>delegate;

+ (MeteorsEngine *)meteorEngine;

@end


@protocol MeteorsEngineDelegate <NSObject>

- (void)meteorsEngineDidCreateMeteor:(Meteor *)meteor;

@end

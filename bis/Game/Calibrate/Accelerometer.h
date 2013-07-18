//
//  Accelerometer.h
//  bis
//

#import <CoreMotion/CoreMotion.h>

@interface Accelerometer : NSObject

@property (nonatomic, retain) CMMotionManager *motionManager;

@property (nonatomic, assign) float currentAccelerationX;
@property (nonatomic, assign) float currentAccelerationY;

@property (nonatomic, assign) int calibrated;
@property (nonatomic, assign) float calibratedAccelerationX;
@property (nonatomic, assign) float calibratedAccelerationY;

+ (Accelerometer *)sharedAccelerometer;

- (void)startAccelerometerUpdates;
- (void)stopAccelerometerUpdates;

@end

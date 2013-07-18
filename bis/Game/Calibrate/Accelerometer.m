//
//  Accelerometer.m
//  bis
//

#import "Accelerometer.h"

#define kCALIBRATIONCOUNT 30

@implementation Accelerometer

#pragma mark Singleton

static Accelerometer *sharedAccelerometer = nil;
+ (Accelerometer *)sharedAccelerometer
{
    if (!sharedAccelerometer) {
        sharedAccelerometer = [[Accelerometer alloc] init];
    }
    return sharedAccelerometer;
}


#pragma mark Inicialização

- (id)init
{
    self = [super init];
    if (self) {
        self.motionManager = [[[CMMotionManager alloc] init] autorelease];
        self.motionManager.accelerometerUpdateInterval = 0.01f; // 100Hz
    }
    return self;
}


#pragma mark Monitoramento do Acelerômetro

- (void)startAccelerometerUpdates
{
    // Verifica se o dispositivo possui acesso ao Acelerômetro e o inicia
    if ([self.motionManager isAccelerometerAvailable]) {
        // Zera as propriedades
        self.currentAccelerationX = 0.0f;
        self.currentAccelerationY = 0.0f;
        self.calibrated = 0;
        self.calibratedAccelerationX = 0.0f;
        self.calibratedAccelerationY = 0.0f;
        
        // Inicia atualizações do acelerômetro
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            
            if (self.calibrated < kCALIBRATIONCOUNT) {
                // Soma posições do acelerômetro
                self.calibratedAccelerationX += accelerometerData.acceleration.x;
                self.calibratedAccelerationY += accelerometerData.acceleration.y;
                
                self.calibrated++;
                if (self.calibrated == kCALIBRATIONCOUNT) {
                    // Calcula a média das calibrações
                    self.calibratedAccelerationX /= kCALIBRATIONCOUNT;
                    self.calibratedAccelerationY /= kCALIBRATIONCOUNT;
                }
            } else {
                // Atualiza aceleração atual
                self.currentAccelerationX = accelerometerData.acceleration.x - self.calibratedAccelerationX;
                self.currentAccelerationY = accelerometerData.acceleration.y - self.calibratedAccelerationY;
            }
        }];
    }
}

- (void)stopAccelerometerUpdates
{
    // Quando os dados do Acelerômetro não são mais necessários, deve-se parar as atualizações
    if ([self.motionManager isAccelerometerActive]) {
        [self.motionManager stopAccelerometerUpdates];
    }
}


#pragma mark Gerenciamento de Memória

- (void)dealloc
{
    [_motionManager release];
    
    [super dealloc];
}

@end

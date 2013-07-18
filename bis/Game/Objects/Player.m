//
//  Player.m
//  bis
//

#import "Player.h"

#define kNOISE 0.15f

@implementation Player

#pragma mark Construtor

+ (Player *)player
{
    Player *player = [Player spriteWithFile:kNAVE];

    // Posiciona o Player recém criado
    player.positionX = SCREEN_WIDTH() / 2.0f;
    player.positionY = 120.0f;
    player.position = ccp(player.positionX, player.positionY);
    
    return player;
}


#pragma mark Acelerômetro

- (void)monitorAccelerometer
{
    // Inicia a Atualização do Acelerômetro
    [[Accelerometer sharedAccelerometer] startAccelerometerUpdates];

    // Inicia a Animação / Movimentação do Player
    [self scheduleUpdate];
}

- (void)update:(float)dt
{
    // Checa se o jogo está em execução
    if ([Runner sharedRunner].isGamePaused == NO) {
        if ([[Accelerometer sharedAccelerometer] currentAccelerationX] < -kNOISE) {
            self.positionX--;
        }
        if ([[Accelerometer sharedAccelerometer] currentAccelerationX] > kNOISE) {
            self.positionX++;
        }
        if ([[Accelerometer sharedAccelerometer] currentAccelerationY] < -kNOISE) {
            self.positionY--;
        }
        if ([[Accelerometer sharedAccelerometer] currentAccelerationY] > kNOISE) {
            self.positionY++;
        }

        // Checa limites da tela
        if (self.positionX < 30.0f) {
            self.positionX = 30.0f;
        }
        if (self.positionX > SCREEN_WIDTH() - 30.0f) {
            self.positionX = SCREEN_WIDTH() - 30.0f;
        }
        if (self.positionY < 30.0f) {
            self.positionY = 30.0f;
        }
        if (self.positionY > SCREEN_HEIGHT() - 30.0f) {
            self.positionY = SCREEN_HEIGHT() - 30.0f;
        }
        
        // Configura posicão do Avião
        self.position = ccp(self.positionX, self.positionY);
    }
}


#pragma mark Funcionamento do Objeto

- (void)moveLeft
{
    // Checa se o jogo está em execução
    if ([Runner sharedRunner].isGamePaused == NO) {
        // Move o Player para a Esquerda
        if (self.positionX > 30.0f) {
            self.positionX -= 10.0f;
        }
        self.position = ccp(self.positionX, self.positionY);
    }
}

- (void)moveRight
{
    // Checa se o jogo está em execução
    if ([Runner sharedRunner].isGamePaused == NO) {
        // Move o Player para a Direita
        if (self.positionX < SCREEN_WIDTH() - 30.0f) {
            self.positionX += 10.0f;
        }
        self.position = ccp(self.positionX, self.positionY);
    }
}

- (void)shoot
{
    // Checa se o jogo está em execução
    if ([Runner sharedRunner].isGamePaused == NO) {
        // Atira
        if ([self.delegate respondsToSelector:@selector(playerDidCreateShoot:)]) {
            [self.delegate playerDidCreateShoot:[Shoot shootWithPositionX:self.positionX andPositionY:self.positionY]];
        }
    }
}

- (void)explode
{
    // Para de atualizar o Acelerômetro
    [[Accelerometer sharedAccelerometer] stopAccelerometerUpdates];
    
    // Som ao explodir
    [[SimpleAudioEngine sharedEngine] playEffect:@"over.wav"];
    
    // Pausa a música de fundo
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];

    // Para o agendamento
    [self unscheduleUpdate];
    
    // Cria efeitos
    float dt = 0.2f;
    CCScaleBy *a1 = [CCScaleBy actionWithDuration:dt scale:2.0f];
    CCFadeOut *a2 = [CCFadeOut actionWithDuration:dt];
    CCSpawn *s1 = [CCSpawn actionWithArray:[NSArray arrayWithObjects:a1, a2, nil]];
    
    // Executa efeito
    [self runAction:s1];
}

@end

//
//  Meteor.m
//  bis
//

#import "Meteor.h"

@implementation Meteor

#pragma mark Construtor

+ (Meteor *)meteorWithImage:(NSString *)image
{
    Meteor *meteor = [Meteor spriteWithFile:image];
    
    // Posiciona o Meteoro recém criado
    meteor.positionX = arc4random_uniform(SCREEN_WIDTH());
    meteor.positionY = SCREEN_HEIGHT();
    meteor.position = ccp(meteor.positionX, meteor.positionY);

    return meteor;
}


#pragma mark Funcionamento do Objeto

- (void)start
{
    // Inicia a Animação / Movimentação do Meteoro
    [self scheduleUpdate];
}

- (void)update:(float)dt
{
    // Checa se o jogo está em execução
    if ([Runner sharedRunner].isGamePaused == NO) {
        // Move o Meteoro para baixo
        self.positionY -= 1.0f;
        self.position = ccp(self.positionX, self.positionY);
    }
}

- (void)gotShot
{
    // Som ao ser atingido
    [[SimpleAudioEngine sharedEngine] playEffect:@"bang.wav"];

    // Para o agendamento
    [self unscheduleUpdate];
    
    // Cria efeitos
    float dt = 0.2f;
    CCScaleBy *a1 = [CCScaleBy actionWithDuration:dt scale:0.5f];
    CCFadeOut *a2 = [CCFadeOut actionWithDuration:dt];
    CCSpawn *s1 = [CCSpawn actionWithArray:[NSArray arrayWithObjects:a1, a2, nil]];
    
    // Método a ser executado após efeito
    CCCallFunc *c1 = [CCCallFunc actionWithTarget:self selector:@selector(removeMe:)];
    
    // Executa efeito
    [self runAction:[CCSequence actionWithArray:[NSArray arrayWithObjects:s1, c1, nil]]];

    // Notifica Delegate
    if ([self.delegate respondsToSelector:@selector(meteorWillBeRemoved:)]) {
        [self.delegate meteorWillBeRemoved:self];
    }
}

- (void)removeMe:(id)sender
{
    // Quando o Meteoro é removido, limpa a memória utilizada pelo mesmo
    [self removeFromParentAndCleanup:YES];
}

@end

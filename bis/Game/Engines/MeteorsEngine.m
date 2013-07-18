//
//  MeteorsEngine.m
//  bis
//

#import "MeteorsEngine.h"

@implementation MeteorsEngine

#pragma mark Construtor

+ (MeteorsEngine *)meteorEngine
{
    return [[[MeteorsEngine alloc] init] autorelease];
}


#pragma mark Inicialização

- (id)init
{
    self = [super init];
    if (self) {
        // Agenda a execução do método meteorsEngine:
        [self schedule:@selector(meteorsEngine:) interval:(1.0f / 10.0f)];
    }
    return self;
}


#pragma mark Criação de Meteoros

- (void)meteorsEngine:(float)dt
{
    // Checa se o jogo está em execução
    if ([Runner sharedRunner].isGamePaused == NO) {
        // Sorte: 1 em 30 gera um novo meteoro!
        if(arc4random_uniform(30) == 0) {
            if ([self.delegate respondsToSelector:@selector(meteorsEngineDidCreateMeteor:)]) {
                [self.delegate meteorsEngineDidCreateMeteor:[Meteor meteorWithImage:kMETEOR]];
            }
        }
    }
}

@end

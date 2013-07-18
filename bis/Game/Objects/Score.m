//
//  Score.m
//  bis
//

#import "Score.h"

@implementation Score

#pragma mark Construtor

+ (Score *)score
{
    return [[[Score alloc] init] autorelease];
}


#pragma mark Inicialização

- (id)init
{
    self = [super init];
    if (self) {
        // Inicializa a pontuação com o valor "0"
        self.score = 0;

        // Posiciona o Placar recém criado
        self.position = ccp(SCREEN_WIDTH() - 50.0f, SCREEN_HEIGHT() - 50.0f);

        // Adiciona o Player na tela, como um texto para o jogador
        self.text = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%d", self.score] fntFile:@"UniSansSemiBold_Numbers_240.fnt"];
        self.text.scale = (float)(240.0f / 240.0f);
        [self addChild:self.text];
    }
    return self;
}


#pragma mark Funcionamento do Objeto

- (void)increase
{
    // Aumenta a pontuação e atualiza o Placar
    self.score++;
    self.text.string = [NSString stringWithFormat:@"%d", self.score];
}


#pragma mark Gerenciamento de Memória

- (void)dealloc
{
    [_text release];
    
    [super dealloc];
}

@end

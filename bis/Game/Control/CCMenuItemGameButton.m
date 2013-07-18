//
//  CCMenuItemGameButton.m
//  bis
//

#import "CCMenuItemGameButton.h"

@implementation CCMenuItemGameButton

- (void)selected
{
    // Quando está "selected", aciona o "activate" para disparar o botão antes de o jogador tirar o dedo da tela
    [super activate];
}

- (void)activate
{
    // Não chama mais o super "activate" aqui, já que este foi acionado no método "selected"
    // [super activate];
}

@end

//
//  DeviceSettings.h
//  bis
//

@interface DeviceSettings : NSObject

// Macro que retorna a largura da tela do jogador
#define SCREEN_WIDTH() \
    [CCDirector sharedDirector].winSize.width

// Macro que retorna a altura da tela do jogador
#define SCREEN_HEIGHT() \
    [CCDirector sharedDirector].winSize.height

// Macro que retorna o tamanho (largura e altura) da tela do jogador
#define WIN_SIZE() \
    [CCDirector sharedDirector].winSize

@end

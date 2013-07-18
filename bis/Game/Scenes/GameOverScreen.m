//
//  GameOverScreen.m
//  bis
//

#import "GameOverScreen.h"

@implementation GameOverScreen

#pragma mark Construtor

// Helper class method that creates a Scene with the GameOverScreen as the only child.
+ (CCScene *)scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
    GameOverScreen *layer = [GameOverScreen node];
	
	// add layer as a child to scene
	[scene addChild:layer];
	
	// return the scene
	return scene;
}


#pragma mark Inicialização

- (id)init
{
    self = [super init];
    if (self) {
        // Imagem de Background
        CCSprite *background = [CCSprite spriteWithFile:kBACKGROUND];
        background.position = ccp(SCREEN_WIDTH() / 2.0f, SCREEN_HEIGHT() / 2.0f);
        [self addChild:background];
        
        // Som
        [[SimpleAudioEngine sharedEngine] playEffect:@"finalend.wav"];
        
        // Imagem
        CCSprite *title = [CCSprite spriteWithFile:kGAMEOVER];
        title.position = ccp(SCREEN_WIDTH() / 2.0f, SCREEN_HEIGHT() - 130.0f);
        [self addChild:title];
        
        // Cria o botão para reiniciar o jogo
        CCMenuItemSprite *beginButton = [CCMenuItemSprite
                                         itemWithNormalSprite:[CCSprite spriteWithFile:kPLAY]
                                         selectedSprite:[CCSprite spriteWithFile:kPLAY]
                                         target:self
                                         selector:@selector(restartGame:)];
        
        // Define a posição do botão
        beginButton.position = ccp(0.0f, 0.0f);
        
        // Cria o menu que terá o botão
        CCMenu *menu = [CCMenu menuWithItems:beginButton, nil];
        [self addChild:menu];
    }
    return self;
}


#pragma mark Ações do Jogador

- (void)restartGame:(id)sender
{
    // Pausa a música de fundo
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    
    // Transfere o Jogador para a TitleScreen
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[TitleScreen scene]]];
}

@end

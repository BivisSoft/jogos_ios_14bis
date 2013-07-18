//
//  TitleScreen.m
//  bis
//

#import "TitleScreen.h"

@implementation TitleScreen

#pragma mark Construtor

// Helper class method that creates a Scene with the TitleScreen as the only child.
+ (CCScene *)scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
    TitleScreen *layer = [TitleScreen node];
	
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
        // Imagem de Background (sem Macros)
        // CCSprite *background = [CCSprite spriteWithFile:@"background.png"];
        // background.position = ccp([CCDirector sharedDirector].winSize.width / 2.0f,
        //                           [CCDirector sharedDirector].winSize.height / 2.0f);
        // [self addChild:background];

        // Imagem de Background
        CCSprite *background = [CCSprite spriteWithFile:kBACKGROUND];
        background.position = ccp(SCREEN_WIDTH() / 2.0f, SCREEN_HEIGHT() / 2.0f);
        [self addChild:background];
        
        // Imagem de Logo
        CCSprite *title = [CCSprite spriteWithFile:kLOGO];
        title.position = ccp(SCREEN_WIDTH() / 2.0f, SCREEN_HEIGHT() - 130.0f);
        [self addChild:title];
        
        // Cria os botões
        CCMenuItemSprite *playButton = [CCMenuItemSprite
                                        itemWithNormalSprite:[CCSprite spriteWithFile:kPLAY]
                                        selectedSprite:[CCSprite spriteWithFile:kPLAY]
                                        target:self
                                        selector:@selector(playGame:)];
        CCMenuItemSprite *highscoreButton = [CCMenuItemSprite
                                             itemWithNormalSprite:[CCSprite spriteWithFile:kHIGHSCORE]
                                             selectedSprite:[CCSprite spriteWithFile:kHIGHSCORE]
                                             target:self
                                             selector:@selector(viewHighscore:)];
        CCMenuItemSprite *helpButton = [CCMenuItemSprite
                                        itemWithNormalSprite:[CCSprite spriteWithFile:kHELP]
                                        selectedSprite:[CCSprite spriteWithFile:kHELP]
                                        target:self
                                        selector:@selector(viewHelp:)];
        CCMenuItemSprite *soundButton = [CCMenuItemSprite
                                         itemWithNormalSprite:[CCSprite spriteWithFile:kSOUND]
                                         selectedSprite:[CCSprite spriteWithFile:kSOUND]
                                         target:self
                                         selector:@selector(toggleSound:)];
        
        // Define as posições dos botões
        playButton.position = ccp(0.0f, 0.0f);
        highscoreButton.position = ccp(0.0f, -50.0f);
        helpButton.position = ccp(0.0f, -100.0f);
        soundButton.position = ccp((SCREEN_WIDTH() / -2.0f) + 70.0f,
                                   (SCREEN_HEIGHT() / -2.0f) + 70.0f);

        // Cria o menu que terá os botões
        CCMenu *menu = [CCMenu menuWithItems:playButton, highscoreButton, helpButton, soundButton, nil];
        [self addChild:menu];
    }
    return self;
}


#pragma mark Ações do Jogador

- (void)playGame:(id)sender
{
    NSLog(@"Botão selecionado: Play");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene scene]]];
}

- (void)viewHighscore:(id)sender
{
    NSLog(@"Botão selecionado: Highscore");
}

- (void)viewHelp:(id)sender
{
    NSLog(@"Botão selecionado: Help");
}

- (void)toggleSound:(id)sender
{
    NSLog(@"Botão selecionado: Som");
}

@end

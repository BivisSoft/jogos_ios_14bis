//
//  PauseScreen.m
//  bis
//

#import "PauseScreen.h"

@implementation PauseScreen

#pragma mark Construtor

+ (PauseScreen *)pauseScreen
{
    return [[[PauseScreen alloc] init] autorelease];
}


#pragma mark Inicialização

- (id)init
{
    self = [super init];
    if (self) {
        // Cor de Background
        CCLayerColor *background = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 175) width:SCREEN_WIDTH() height:SCREEN_HEIGHT()];
        [self addChild:background];
        
        // Imagem de Logo
        CCSprite *title = [CCSprite spriteWithFile:kLOGO];
        title.position = ccp(SCREEN_WIDTH() / 2.0f, SCREEN_HEIGHT() - 130.0f);
        [self addChild:title];
        
        // Cria os botões
        CCMenuItemSprite *resumeButton = [CCMenuItemSprite
                                          itemWithNormalSprite:[CCSprite spriteWithFile:kPLAY]
                                          selectedSprite:[CCSprite spriteWithFile:kPLAY]
                                          target:self
                                          selector:@selector(resumeGame:)];
        CCMenuItemSprite *quitButton = [CCMenuItemSprite
                                        itemWithNormalSprite:[CCSprite spriteWithFile:kEXIT]
                                        selectedSprite:[CCSprite spriteWithFile:kEXIT]
                                        target:self
                                        selector:@selector(quitGame:)];
        
        // Define as posições dos botões
        resumeButton.position = ccp(0.0f, 0.0f);
        quitButton.position = ccp(0.0f, -100.0f);
        
        // Cria o menu que terá os botões
        CCMenu *menu = [CCMenu menuWithItems:resumeButton, quitButton, nil];
        [self addChild:menu];
    }
    return self;
}


#pragma mark Ações do Jogadore

- (void)resumeGame:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(pauseScreenWillResumeGame:)]) {
        [self.delegate pauseScreenWillResumeGame:self];
        [self removeFromParentAndCleanup:YES];
    }
}

- (void)quitGame:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(pauseScreenWillQuitGame:)]) {
        [self.delegate pauseScreenWillQuitGame:self];
    }
}

@end

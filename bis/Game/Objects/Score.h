//
//  Score.h
//  bis
//

#import "CCLayer.h"

@interface Score : CCLayer

@property (nonatomic, assign) int score;
@property (nonatomic, retain) CCLabelBMFont *text;

+ (Score *)score;

- (void)increase;

@end

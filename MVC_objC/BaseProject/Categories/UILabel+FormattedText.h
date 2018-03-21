

#import <UIKit/UIKit.h>

@interface UILabel (FormattedText){
    
}

//Bold for SubString
- (void) boldSubstring: (NSString*) substring;
- (void) boldSubstring: (NSString*) substring withSize:(CGFloat)size;


- (void)colorSubString: (NSString *)subString withColor:(UIColor *)color;
- (void)underLineTextSubString:(NSString *)subString;

//Strike Throught
- (void)strikeThroughtText;

@end

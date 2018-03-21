

#import "UILabel+FormattedText.h"
#import <CoreText/CoreText.h>
#import "AllCommon.h"


@implementation UILabel (FormattedText)

//*****Use Bold with Range
- (void) boldRange: (NSRange) range {
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedText setAttributes:@{NSFontAttributeName:AppFont_MainFontMediumWithSize(self.font.pointSize)} range:range];
    
    self.attributedText = attributedText;
}
- (void) boldSubstring: (NSString*) substring {
    NSRange range = [self.text rangeOfString:substring];
    [self boldRange:range];
}

//BoldRange and new Size
- (void) boldRange: (NSRange) range  size:(CGFloat)size{
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedText setAttributes:@{NSFontAttributeName:AppFont_MainFontBoldWithSize(size)} range:range];
    
    self.attributedText = attributedText;
}

- (void) boldSubstring: (NSString*) substring withSize:(CGFloat)size{
    NSRange range = [self.text rangeOfString:substring];
    [self boldRange:range size:size];
}


- (void)colorRange: (NSRange) range withColor: (UIColor *)color{
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedText addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    self.attributedText = attributedText;
}

- (void)colorSubString: (NSString *)subString withColor:(UIColor *)color{
    NSRange range = [self.text rangeOfString:subString];
    [self colorRange:range withColor:color];
}
//Underline with substring
- (void)underLineTextSubString:(NSString *)subString{

    NSRange range = [self.text rangeOfString:subString];
    if (![self respondsToSelector:@selector(setAttributedText:)]) {
        return;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        [attributedText addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                               value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                               range:range];
    }else{
        [attributedText addAttribute:NSUnderlineStyleAttributeName
                               value:[NSNumber numberWithInt:1]
                               range:range];
    }
    
    
    self.attributedText = attributedText;
}

//Strike through text
- (void)strikeThroughtText{    
    NSAttributedString * title = [[NSAttributedString alloc] initWithString:self.text
                                        attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
    [self setAttributedText:title];
}
@end

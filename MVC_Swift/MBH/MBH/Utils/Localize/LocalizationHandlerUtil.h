#import <Foundation/Foundation.h>

@interface LocalizationHandlerUtil : NSObject

+ (LocalizationHandlerUtil *)shareInstance;

- (NSString *)localizedString:(NSString *)key comment:(NSString *)comment;
- (void)setLanguageIdentifier:(NSString*)indentifier;
+ (NSString *)currentLanguage;
+ (BOOL)isKorean;

- (NSString *)userLanguage;
@end

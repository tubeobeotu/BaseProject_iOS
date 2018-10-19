#import "LocalizationHandlerUtil.h"
#import "BundleLocalization.h"
@interface LocalizationHandlerUtil() {
    NSString *lanuageIdentifier;
}
@end

@implementation LocalizationHandlerUtil

static LocalizationHandlerUtil * singleton = nil;
- (NSString *)userLanguage
{
    return lanuageIdentifier;
}
+ (LocalizationHandlerUtil *)shareInstance
{
    static LocalizationHandlerUtil *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [self new];
        [share setLanguageIdentifier:[[NSUserDefaults standardUserDefaults] stringForKey:@"languageKey"]];
    });
    return share;
}

- (void)setLanguageIdentifier:(NSString*)indentifier {
    if([indentifier isEqualToString:@""] || indentifier == nil)
    {
        indentifier = @"vi";
    }
    lanuageIdentifier = indentifier;
    [[BundleLocalization sharedInstance] setLanguage:lanuageIdentifier];
    [[NSUserDefaults standardUserDefaults] setValue:indentifier forKey:@"languageKey"];
}

- (NSString *)localizedString:(NSString *)key comment:(NSString *)comment
{
    NSBundle *bunder;
    NSString *defaultLanguage;
    if (lanuageIdentifier == nil) {
        defaultLanguage = @"vi";
    }
    else {
        defaultLanguage = lanuageIdentifier;
    }
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:defaultLanguage ofType:@"lproj"];
    bunder = [NSBundle bundleWithPath:bundlePath];
    // default localized string loading
    NSString * localizedString = [bunder localizedStringForKey:key value:key table:nil];
    
    // if (value == key) and comment is not nil -> returns comment
    if([localizedString isEqualToString:key] && comment !=nil)
        return comment;
    
    return localizedString;
}
+ (NSString *)currentLanguage
{
    return [[[NSLocale preferredLanguages] firstObject] componentsSeparatedByString:@"-"].firstObject;
}
+ (BOOL)isKorean
{
    if ([[[LocalizationHandlerUtil currentLanguage] lowercaseString] isEqualToString:@"kr"]) {
        return YES;
    }
    return NO;
}
@end

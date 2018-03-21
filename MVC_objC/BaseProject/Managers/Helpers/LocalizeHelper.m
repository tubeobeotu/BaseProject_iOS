

#import "LocalizeHelper.h"

static LocalizeHelper* SingleLocalSystem = nil;

static NSBundle* myBundle = nil;


@implementation LocalizeHelper


//-------------------------------------------------------------
// allways return the same singleton
//-------------------------------------------------------------
+ (LocalizeHelper*) sharedLocalSystem {
    // lazy instantiation
    if (SingleLocalSystem == nil) {
        SingleLocalSystem = [[LocalizeHelper alloc] init];
    }
    return SingleLocalSystem;
}


//-------------------------------------------------------------
// initiating
//-------------------------------------------------------------
- (id) init {
    self = [super init];
    if (self) {
        // use systems main bundle as default bundle
        myBundle = [NSBundle mainBundle];
    }
    return self;
}


//-------------------------------------------------------------
// translate a string
//-------------------------------------------------------------
// you can use this macro:
// LocalizedString(@"Text");
- (NSString*) localizedStringForKey:(NSString*) key {
    // this is almost exactly what is done when calling the macro NSLocalizedString(@"Text",@"comment")
    // the difference is: here we do not use the systems main bundle, but a bundle
    // we selected manually before (see "setLanguage")
    return [myBundle localizedStringForKey:key value:@"" table:nil];
    
}


//-------------------------------------------------------------
// set a new language
//-------------------------------------------------------------
// you can use this macro:
// LocalizationSetLanguage(@"Vietnam") or LocalizationSetLanguage(@"vi");
- (void) setLanguage:(NSString*) lang {
    
    // path to this languages bundle
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj" ];
    if (path == nil) {
        // there is no bundle for that language
        // use main bundle instead
        myBundle = [NSBundle mainBundle];
    } else {
        
        // use this bundle as my bundle from now on:
        myBundle = [NSBundle bundleWithPath:path];
        
        // to be absolutely shure (this is probably unnecessary):
        if (myBundle == nil) {
            myBundle = [NSBundle mainBundle];
        }
    }
}

#pragma mark - Use Current Language
/*
- (NSString *)currentLanguage{
    NSString *_curLan = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([_curLan containsString:@"en"]) {
        return KSYS_APP_LANG_EN;
    }else if([_curLan isEqualToString:@"vi"]){
        return KSYS_APP_LANG_DEFAULT;
    }
    return KSYS_APP_LANG_DEFAULT;
}
 */
@end


#import <Foundation/Foundation.h>

@interface NSDictionary (NSDictionary)

- (void)setValueString:(NSString *)strValue nullValue:(NSString *)nullValue forKey:(NSString *)key;
- (NSString *)getValueStringFromKey:(NSString *)key;

@end

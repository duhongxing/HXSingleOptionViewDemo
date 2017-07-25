

#import <Foundation/Foundation.h>
@interface NSString (NSString_Hashing)

- (NSString *)MD5Hash;

//获取token
+ (NSString *)getTokenWithString:(NSString *)myString;

@end

//
//  NSMutableDictionary+Category.h
//  iOS-Category
//
//  Created by 庄BB的MacBook on 16/7/29.
//  Copyright © 2016年 BBFC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Category)
- (void)safeSetObject:(id)aObj forKey:(id<NSCopying>)aKey;

- (id)safeObjectForKey:(id<NSCopying>)aKey;
@end

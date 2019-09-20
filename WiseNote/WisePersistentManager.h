//
//  WisePersistentManager.h
//  WiseNote
//
//  Created by 胡俊峰 on 9/9/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WisePersistentManager : NSObject

+ (id)getNote;

+ (BOOL)saveNote:(NSArray *)array;

+ (BOOL)saveNoteWithDictionary:(NSDictionary *)dictionary;


+ (BOOL)deleteNoteWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

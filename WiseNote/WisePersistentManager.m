//
//  WisePersistentManager.m
//  WiseNote
//
//  Created by 胡俊峰 on 9/9/19.
//  Copyright © 2019 WiseApp. All rights reserved.
//

#import "WisePersistentManager.h"

@implementation WisePersistentManager

+ (id)getNote{
    NSArray *docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirPath = docsDir[0];
    NSString *filePath = [dirPath stringByAppendingPathComponent:@"note"];
    
    NSLog(@"path:%@", filePath);
    
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL fileExist = [manager fileExistsAtPath:filePath];
    
    @try {
//        NSException *e = [NSException exceptionWithName:@"error" reason:nil userInfo:nil];
//        @throw e;
        if (fileExist) {
            NSArray *notes = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
            return notes;
        } else {
            NSArray *notes = [[NSArray alloc] init];
            return notes;
        }
    } @catch (NSException *exception) {
        return nil;
    } @finally {
        // do nothing
    }
    
    
    
    
}


+ (BOOL)saveNote:(NSArray *)array{
    NSArray *docsDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirPath = docsDir[0];
    NSString *filePath = [dirPath stringByAppendingPathComponent:@"note"];
    
    
    @try {
        BOOL savedSuccess = [NSKeyedArchiver archiveRootObject:array toFile:filePath];
        return savedSuccess;
    } @catch (NSException *exception) {
        return NO;
    } @finally {
        //do nothing
    }
    
    
    
}



+ (BOOL)saveNoteWithDictionary:(NSDictionary *)dictionary{
    
    id notes = [self getNote];
    
    NSNumber *timestamp = [dictionary objectForKey:@"timestamp"];
    if (notes != nil) {
        
        NSMutableArray *newNotes = [NSMutableArray arrayWithArray:notes];
        NSInteger replaceIndex = newNotes.count + 1;
        for (NSInteger i = 0; i < newNotes.count; i++) {
            NSNumber *oldTimestamp = [newNotes[i] objectForKey:@"timestamp"];
            if (oldTimestamp == timestamp) {
                replaceIndex = i;
                break;
            }
        }
        if (replaceIndex < newNotes.count) {
            newNotes[replaceIndex] = dictionary;
        } else {
            [newNotes addObject:dictionary];
        }
        
        return [self saveNote:newNotes];
    }
    
    return NO;
    
}


+ (BOOL)deleteNoteWithDictionary:(NSDictionary *)dictionary{

    id notes = [self getNote];
    if (notes != nil) {
        NSMutableArray *newNotes = [NSMutableArray arrayWithArray:notes];
        [newNotes removeObject:dictionary];
        return [self saveNote:newNotes];
    }
    return NO;
    
}

@end

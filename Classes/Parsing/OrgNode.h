//
//  OrgNode.h
//  OrgParser
//
//  Created by Nathan Fair on 11/5/14.
//  Copyright (c) 2014 Nathan Fair. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, elementType) {
    headlineType,
    plainListType,
    propertyDrawerType,
    tableType
};

@interface OrgNode : NSObject

@property (nonatomic, retain) NSNumber *begin;
@property (nonatomic, retain) NSNumber *end;
@property (nonatomic, retain) NSNumber *contentsBegining;
@property (nonatomic, retain) NSNumber *contentsEnd;
@property (nonatomic) elementType type;


@end

//
//  HeaderNode.h
//  OrgParser
//
//  Created by Nathan Fair on 11/7/14.
//  Copyright (c) 2014 Nathan Fair. All rights reserved.
//

#import "OrgNode.h"

@interface HeaderNode : OrgNode

@property (nonatomic, retain) NSString *rawValue;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *altTitle;

@property (nonatomic, retain) NSString *preBlank;
// contentsBegin from parent class
// contentsEnd from parent class
@property (nonatomic, retain) NSNumber *level;
@property (nonatomic, retain) NSString *priority;
@property (nonatomic, retain) NSMutableArray *tags;
@property (nonatomic, retain) NSString *todoKeyWord;
@property (nonatomic, retain) NSString *todoType;
@property (nonatomic, retain) NSDate *scheduled;
@property (nonatomic, retain) NSDate *deadline;
@property (nonatomic, retain) NSDate *closed;
@property (nonatomic, assign) BOOL quotedp;
@property (nonatomic, assign) BOOL archivedp;
@property (nonatomic, assign) BOOL commentedp;
@property (nonatomic, assign) BOOL footnoteSectionp;

+ (HeaderNode *)createHeaderNode:(NSRange)range From:(NSString*)body TodoStates:(NSString*)todStates;

- (BOOL)isEqual:(id)other;
- (BOOL)isEqualToHeaderNode:(HeaderNode *)headerNode;
-(NSUInteger)hash;
@end

//
//  HeaderNode.m
//  OrgParser
//
//  Created by Nathan Fair on 11/7/14.
//  Copyright (c) 2014 Nathan Fair. All rights reserved.
//

#import "HeaderNode.h"
#import "RegexKitLite.h"

@implementation HeaderNode

@synthesize rawValue;
@synthesize title;
@synthesize altTitle;

@synthesize preBlank;
// contentsBegin from parent class
// contentsEnd from parent class
@synthesize level;
@synthesize priority;
@synthesize tags;
@synthesize todoKeyWord;
@synthesize todoType;
@synthesize scheduled;
@synthesize deadline;
@synthesize closed;
@synthesize quotedp;
@synthesize archivedp;
@synthesize commentedp;
@synthesize footnoteSectionp;

+ (HeaderNode *)createHeaderNode:(NSRange)range From:(NSString*)body TodoStates:(NSString*)todStates{
    // this function like all of its kind assumes that start is at the beginning index of the element
    // org-complex-heading-regexp
    
    NSString * line = [body substringWithRange:range];
    // \x3f is used instead of the ? character twice because '??(' parses to '[' I could find no documentation for this
    // behavior
    // \w\d was used as a substitute for [:alnum:] though I'm not sure that this is safe
    NSString * regex = @"^(\\*+)(?: +(TODO|IN-PROGRESS|WAITING|DONE|CANCELLED))?(?: +(\\[#.\\]))?(?: +(.*?))\x3f\x3f(?:[ 	]+(:[\\d\\w_@#%:]+:))?[ 	]*$";
    NSArray *splitHeadlineArray = [line captureComponentsMatchedByRegex:regex];
    HeaderNode * node = [[HeaderNode alloc] init];
    for (NSString * object in splitHeadlineArray) {
        // do something with object
        NSLog(@"out '%@'", object);
    }
    if ([splitHeadlineArray count] >= 2 && splitHeadlineArray[1]) {
        NSNumber * num = [NSNumber numberWithInt:[splitHeadlineArray[1] length]];
        [node setLevel:num];
        NSLog(@" star%@", splitHeadlineArray[1]);
    }
    
    if ([splitHeadlineArray count] >= 3 && splitHeadlineArray[2]) {
        [node setTodoKeyWord:[splitHeadlineArray objectAtIndex:2]];
    }
    if ([splitHeadlineArray count] >= 6 && splitHeadlineArray[5]) {
        NSMutableArray * tags = [NSMutableArray arrayWithArray:[splitHeadlineArray[5] componentsSeparatedByString:@":"]];
        [node setTags:tags];
        [tags release];
    }
    if ([splitHeadlineArray count] >= 5 && splitHeadlineArray[4]) {
        [node setRawValue:splitHeadlineArray[4]];
    }
    else {
        [node setRawValue:@""];
    }
    
    return  node;
};

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToHeaderNode:other];
}

- (BOOL)isEqualToHeaderNode:(HeaderNode *)headerNode {
    if (self == headerNode)
        return YES;
    if (![(id)[self rawValue] isEqual:[headerNode rawValue]])
        return NO;
    // this is incomplete but for now
    return YES;
}

-(NSUInteger)hash {
    NSUInteger result = 1;
    NSUInteger prime = 31;
    NSUInteger yesPrime = 1231;
    NSUInteger noPrime = 1237;
    
    // for all hashable values
    // from parent class
    result = prime * result + [[self begin] hash];
    result = prime * result + [[self end] hash];
    result = prime * result + [[self contentsBegining] hash];
    result = prime * result + [[self contentsEnd] hash];
    
    // this class
    result = prime * result + [[self rawValue] hash];
    result = prime * result + [[self title] hash];
    result = prime * result + [[self altTitle] hash];
    result = prime * result + [[self preBlank] hash];
    result = prime * result + [[self level] hash];
    result = prime * result + [[self priority] hash];
    result = prime * result + [[self tags] hash];
    result = prime * result + [[self todoKeyWord] hash];
    result = prime * result + [[self todoType] hash];
    result = prime * result + [[self scheduled] hash];
    result = prime * result + [[self deadline] hash];
    result = prime * result + [[self closed] hash];
    
    // Boolean values (BOOL)
    // result = prime * result + self.isSelected?yesPrime:noPrime;
    result = prime * result + ([self quotedp] ? yesPrime : noPrime);
    result = prime * result + ([self archivedp] ? yesPrime : noPrime);
    result = prime * result + ([self commentedp] ? yesPrime : noPrime);
    result = prime * result + ([self footnoteSectionp] ? yesPrime : noPrime);
    
    // Add primitive variables (int)
    //    result = prime * result + self.primitiveVariable;
        
    return result;
}

@end

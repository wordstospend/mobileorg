//
//  HeaderNodeTest.m
//  MobileOrg
//
//  Created by Nathan Fair on 11/16/14.
//
//

#import <GHUnitIOS/GHUnit.h>
#import "HeaderNode.h"

@interface HeaderNodeTest : GHTestCase {

}

@end

@implementation HeaderNodeTest

- (BOOL)shouldRunOnMainThread {
    // By default NO, but if you have a UI test or test dependent on running on the main thread return YES
    return NO;
}

- (void)setUpClass {
    // Run at start of all tests in the class
}

- (void)tearDownClass {
    // Run at end of all tests in the class
}

- (void)setUp {
    // Run before each test method
}

- (void)tearDown {
    // Run after each test method
}

- (void)testHeaderNodeCreationWithTodo {
    HeaderNode * testNode = [[HeaderNode alloc] init ];
    [testNode setTodoKeyWord:@"TODO"];
    [testNode setLevel:[NSNumber numberWithInt:1]];
    [testNode setRawValue:@"the test headline"];
    NSString * testHeadline = @"* TODO the test headline";
    HeaderNode * createdNode = [HeaderNode createHeaderNode:NSMakeRange(0, testHeadline.length) From:testHeadline TodoStates:@""];
    HeaderNode * createdSameNode = [HeaderNode createHeaderNode:NSMakeRange(0, testHeadline.length) From:testHeadline TodoStates:@""];
    GHAssertEqualObjects(createdNode, createdSameNode, @"yeah ok so this");
    GHAssertEqualObjects(testNode, testNode, @"well at least nodes are equal to them selves");
    GHAssertEqualObjects(createdNode, createdNode, @"well at created node are equal to themselves");
    //GHAssertEqualObjects(testNode, createdNode, @"Node with TODO created properly", nil);
    GHAssertEqualObjects([testNode rawValue], [createdNode rawValue], @"raw values are the same");
    GHAssertEqualObjects([testNode level], [createdNode level], @"level values are equal");
    GHAssertEqualObjects([testNode todoKeyWord], [createdNode todoKeyWord], @"todo keyword is equal");
    
}

@end

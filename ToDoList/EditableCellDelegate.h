//
//  EditableCellDelegate.h
//  ToDoList
//
//  Created by Kevin Lee on 10/14/13.
//  Copyright (c) 2013 Kevin Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EditableCell;

@protocol EditableCellDelegate <NSObject>
- (void)updateEditableDataForCell:(EditableCell*)cell withText:(NSString *)text;
- (void)offsetScrollToCell:(EditableCell*)cell;
@end
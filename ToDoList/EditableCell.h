//
//  EditableCell.h
//  ToDoList
//
//  Created by Kevin Lee on 10/13/13.
//  Copyright (c) 2013 Kevin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditableCellDelegate.h"

@interface EditableCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtCellString;

@property (nonatomic, weak) id <EditableCellDelegate> cellDelegate;
@end

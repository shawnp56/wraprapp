//
//  multiselecthandle.m
//  iJoomer
//
//  Created by Tailored Solutions on 30/04/12.
//  Copyright 2013 Tailored Solutions. All rights reserved.
//

#import "MultiselectHandler.h"
#import "Option.h"

@implementation MultiselectHandler

@synthesize options;

- (void)viewDidLoad {
	
	
	[super viewDidLoad];

}
 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 	return [options count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	Option *option = [options objectAtIndex:indexPath.row];
	[cell.textLabel setText:option.name];
	if(!option.isSelected) {
		[cell setAccessoryType:UITableViewCellAccessoryNone];
		
	} else {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableViewController cellForRowAtIndexPath:indexPath];
	Option *option = [options objectAtIndex:indexPath.row];
	if(option.isSelected) {
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	
	} else {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
		
		
	}
	option.isSelected = !(option.isSelected);
	
	[tableViewController deselectRowAtIndexPath:indexPath animated:YES];
}

@end

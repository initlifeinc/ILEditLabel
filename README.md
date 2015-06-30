# ILEditLabel
ILEditLabel is label support copy&edit for ios. It's easy to use.

## How to use
You can easy to use by open project to read the files in source.

### Enable Copying

* create edit label just as normal label

	```    
	self.editLabel = [[ILEditLabel alloc] initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40 , 30)];
	```
* enable copy feature.

	```
	[self.editLabel setCopyingEnabled:YES];
	```

* custom backgroundcolor when trigger copy.

	```
	self.editLabel.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.93 alpha:1];
	self.editLabel.copyingBackgroundColor = [UIColor grayColor];
	```
	



### Enable Edit 
* enable copy feature so that you can click label to edit text

	```
	[self.editLabel setEditEnabled:!self.editLabel.editEnabled];
	```
	

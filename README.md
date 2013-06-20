SRLocation
==========

Get the user's location very easily

Example
==========

```
SRLocation *location = [[SRLocation alloc] init];
   [_location startGetLocationWithComplete:^(CLLocation *location) {
        // complete to update the location
    } failed:^(NSError *error) {
        
    }];
```
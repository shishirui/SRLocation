SRLocation
==========

Get the user's location very easily on iOS Devices.

Features
----------

- Get the user's location with graceful block style program.
- Fix the wrong location return by GPS in China.

Example
----------

```
SRLocation *location = [[SRLocation alloc] init];
[location startGetLocationWithComplete:^(CLLocation *location) {
    // complete to update the location
} failed:^(NSError *error) {
        
}];
```
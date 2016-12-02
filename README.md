# ScreenshotCreator

Create app screenshots programmatically on Playground with Swift and Xcode.

## Example

```
var config = ScreenshotConfig()
config.backgroundColor = UIColor.brown
config.titles = [
    "phone1" : "Hello, world!"
]

let creator = ScreenshotCreator(config: config)
creator.preview()

creator.save()
```

### Output

![](/phone1.png)


### Console

```
$ open /path/to/Documents/ScreenshotCreator
```

## Acknowledgements

- http://facebook.design/devices

## License

My code is licensed under the MIT license.  
**Each asset has its own license!**

## See Also

[tnantoka/IconCreator](https://github.com/tnantoka/IconCreator)

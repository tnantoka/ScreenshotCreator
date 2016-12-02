//: Playground - noun: a place where people can play

import UIKit

var config = ScreenshotConfig()
config.backgroundColor = UIColor.brown
config.titles = [
    "phone1" : "Hello, world!"
]

let creator = ScreenshotCreator(config: config)
creator.preview()

creator.save()

//: Playground - noun: a place where people can play

import UIKit

let creator = ScreenshotCreator()

var config = ScreenshotConfig()
config.backgroundColor = UIColor.brown
config.titles = [
    "phone1" : "タイトル"
]

creator.preview(config: config)

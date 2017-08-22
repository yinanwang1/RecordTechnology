//
//  TypeCasting.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2016/10/26.
//  Copyright © 2016年 InSigma HengTian Softwar Ltd. All rights reserved.
//

import Foundation


class TypeCasting {
    
    func testMediaItem() {
        var movieCount = 0
        var songCount = 0
        
        for item in library {
            if item is Movie {
                movieCount += 1
            } else if item is Song {
                songCount += 1
            }
        }
        
        print("Media library contains \(movieCount) movies and \(songCount) songs")
        
        for item in library {
            if let movie = item as? Movie {
                print("Movies: \(movie.name), dir. \(movie.director)")
            } else if let song = item as? Song {
                print("Song: '\(song.name)', by \(song.artist)")
            }
        }
    }
    
    
    func testAnyObject() {
//        for object in someObjects {
//            let movie = object as! Movie
//            
//            print("Movie: '\(movie.name)', dir. \(movie.director)")
//        }
        
        for movie in someObjects as! [Movie] {
            print("Movie: '\(movie.name)', dir. \(movie.director)")
        }
    }
    
    func testAny() {
        var things = [Any]()
        
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.1415)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        things.append({(name: String) -> String in "Hello, \(name)"})
        
        for thing in things {
            switch thing {
            case 0 as Int:
                print("\(thing) zero as an Int")
                
            case 0 as Double:
                print("\(thing) zero as a Double")
                
            case let someInt as Int:
                print("an integer value of \(someInt)")
                
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
                
            case is Double:
                print("some other double value that I don't want to print")
                
            case let someString as String:
                print("a string value of \"\(someString)\"")
                
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
                
            case let movie as Movie:
                print("a movie called '\(movie.name)', dir. \(movie.director)")
                
            case let stringConverter as (String) -> String:
                print(stringConverter("Michael"))
                
            default:
                print("something else")
            }
        }
    }
    
}


class MediaItem {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    
    init(name:String, director: String) {
        self.director = director
        
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    
    init(name: String, artist: String) {
        self.artist = artist
        
        super.init(name: name)
    }
}


let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "CItizen Kane", director: "Orson Welles"),
    Song(name: "The one And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley"),
]

let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott"),
]
















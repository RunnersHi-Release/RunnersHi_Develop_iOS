//
//  RunPlace.swift
//  Runners_Hi
//
//  Created by 김민희 on 2020/10/06.
//  Copyright © 2020 김민희. All rights reserved.
//

import Foundation

struct RunPlace {
    var rank: Int
    var profile: Int
    var nick: String
    var level: Int
    var win: Int
    var lose: Int
    
    init(rank: Int, profile: Int, nick: String, level: Int, win: Int, lose:Int) {
        self.rank = rank
        self.profile = profile
        self.nick = nick
        self.level = level
        self.win = win
        self.lose = lose
    }
    }
    

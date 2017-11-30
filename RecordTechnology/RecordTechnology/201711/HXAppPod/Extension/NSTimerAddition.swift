//
//  NSTimerAddition.swift
//  RecordTechnology
//
//  Created by ArthurWang on 2017/11/30.
//  Copyright © 2017年 Monkey King. All rights reserved.
//

import Foundation

extension Timer {
    @objc func pauseTimer() -> Void {
        if !(self.isValid) {
            return;
        }

        self.fireDate = NSDate.distantFuture;
    }

    @objc func resumeTimer() -> Void {
        if !(self.isValid) {
            return;
        }

        self.fireDate = Date();
    }

    @objc func resumeTimerAfterTimeInterval(interval: TimeInterval) -> Void {
        if !(self.isValid) {
            return;
        }

        self.fireDate = NSDate.init(timeIntervalSinceNow: interval) as Date;
    }
}



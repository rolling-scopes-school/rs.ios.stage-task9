//
//  Util.swift
//  RSSchool_T9
//
//  Created by Uladzislau Volchyk on 24.07.21.
//

import Foundation

func unzip<T, U, S: Sequence>(sequence: S) -> ([T], [U]) where S.Element == (T, U) {
    var t = Array<T>()
    var u = Array<U>()
    for (a, b) in sequence {
        t.append(a)
        u.append(b)
    }
    return (t, u)
}

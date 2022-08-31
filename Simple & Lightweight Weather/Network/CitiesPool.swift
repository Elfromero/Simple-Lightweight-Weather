//
//  CitiesPool.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 30.08.2022.
//

import Foundation

enum CitiesPool: String, CaseIterable {
    case London
    case TelAviv
    case NewYork
    case Brussels
    case Barcelona
    case Paris
    case Tokyo
    case Beijing
    case Sydney
    case BuenosAires
    case Miami
    case Vancouver
    case Moscow
    case Bangkok
    case Johannesburg
    case Tunis
    case Manila
    
    var id: Int {
        switch self {
        case .London:       return 2643743
        case .TelAviv:      return 293396
        case .NewYork:      return 5128581
        case .Brussels:     return 2800866
        case .Barcelona:    return 3128760
        case .Paris:        return 2988507
        case .Tokyo:        return 1850147
        case .Beijing:      return 1816670
        case .Sydney:       return 2147714
        case .BuenosAires:  return 3432043
        case .Miami:        return 4164138
        case .Vancouver:    return 6173331
        case .Moscow:       return 524901
        case .Bangkok:      return 1609350
        case .Johannesburg: return 993800
        case .Tunis:        return 2464470
        case .Manila:       return 1701668
        }
    }
}

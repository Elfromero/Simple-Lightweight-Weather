//
//  StoryboardInstantiable.swift
//  Simple & Lightweight Weather
//
//  Created by Roman Radchuk on 30.08.2022.
//

import UIKit

protocol StoryboardInstantiable: NSObjectProtocol {
    
    /// Default implementation should be used only when controller name == storyboard name
    static func instantiateViewController<ViewController>() -> ViewController
}

extension StoryboardInstantiable where Self: UIViewController {
    
    static func instantiateViewController<ViewController>() -> ViewController {
        let fileName = String(describing: self)
        if Bundle.main.path(forResource: fileName, ofType: "storyboardc") == nil {
            fatalError("Path for \(fileName) not found!")
        }
        
        let storyboard = UIStoryboard(name: fileName, bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: fileName) as? ViewController else {
            fatalError("\(fileName) view controller could not be found!")
        }
        return controller
    }
}

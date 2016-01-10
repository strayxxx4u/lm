// implement a menu with custom commands in UICollectionView

import UIKit

extension UIResponder {
    
    var responderChain: AnySequence<UIResponder> {
        var responder: UIResponder? = self
        return AnySequence { () -> AnyGenerator<UIResponder> in
            return anyGenerator {
                responder = responder?.nextResponder()
                return responder
            }
            
        }
    }
    
    func findResponder<Result>() -> Result? {
        for responder in responderChain {
            if let result = responder as? Result {
                return result
            }
        }
        return nil
    }
    
}

extension UICollectionViewCell {
    
    func respondingViewControllerAndIndexPath<ViewController: UICollectionViewController>() -> (ViewController, NSIndexPath)? {
        guard let vc: ViewController = findResponder(), indexPath = vc.collectionView?.indexPathForCell(self) else {
            return nil
        }
        return (vc, indexPath)
    }
    
}

// *****

enum MyCellMenuCommand: String {
    case Custom = "custom:"
    
    var title: String {
        switch self {
        case .Custom:
            return "Custom"
        }
    }
    
    static var all: [MyCellMenuCommand] {
        return [.Custom]
    }
    
    static var allSelectors: [Selector] {
        return all.map { Selector($0.rawValue) }
    }
    
    static var allMenuItems: [UIMenuItem] {
        return all.map { UIMenuItem(title:$0.title, action:Selector($0.rawValue)) }
    }
    
}

// ****

final class MyCollectionViewCell: UICollectionViewCell {
    
    func custom(sender: AnyObject?) {
        if let (controller, indexPath): (MyCollectionViewController, NSIndexPath) = respondingViewControllerAndIndexPath() {
            controller.custom(indexPath)
        }
    }
    
}

// *****

final class MyCollectionViewController: UICollectionViewController {

    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        UIMenuController.sharedMenuController().menuItems = MyCellMenuCommand.allMenuItems
        UIMenuController.sharedMenuController().update()
        return true
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return MyCellMenuCommand.allSelectors.contains(action)
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    }
    
    func custom(indexPath: NSIndexPath) {
        // implement your custom function here
    }

}

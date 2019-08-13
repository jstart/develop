//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
@testable import DevelopPlayground

class PlaygroundViewController: UIViewController {
    
    static func vc(views: [UIView]) -> PlaygroundViewController {
        let pvc = PlaygroundViewController()
        let stack = UIStackView(translates: false)
        stack.axis = .vertical
        
        for view in views {
            stack.addArrangedSubview(view)
        }
        
        pvc.view.addSubview(stack)
        stack.constrain((.top, 0), (.bottom, 0), (.leading, 0), (.trailing, 0), toItem: pvc.view)

        return pvc
    }

}

let label = UILabel()
label.text = "Hello World!"
label.textColor = .black

let btn = ButtonStyler.button(text: "Test")

let view = UIView(frame: btn.frame)
view.backgroundColor = .lightGray

let pvc = PlaygroundViewController.vc(views: [label, btn, view])
pvc.view.addSubview(btn)
btn.constrain((.top, 0), (.leading, 0), (.width, 50), (.height, 50), toItem: pvc.view)

PlaygroundPage.current.liveView = pvc

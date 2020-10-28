//
//  ViewController.swift
//  SnackBar
//
//  Created by Ngo Dang tan on 10/27/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for x in 0..<2 {
            let button = UIButton(frame: CGRect(x: 20, y: 130 + (CGFloat(x) * 55) + (CGFloat(x) * 10), width: view.frame.size.width - 40, height: 55))
            button.tag = x + 1
            button.backgroundColor = .systemBlue
            button.setTitle("Show Snackbar \(x+1)", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            view.addSubview(button)
        }
    }
    
    @objc private func didTapButton(_ sender: UIButton){
        
        let viewModel: SnackbarViewModel
        if sender.tag == 1 {
            //first button
            viewModel = SnackbarViewModel(type: .info, text: "Hello World", image: UIImage(systemName: "bell"))
        }else{
            //second button
            viewModel = SnackbarViewModel(type: .action(handler: {[weak self] in
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            
            }), text: "Show Alert", image: nil)
        }
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width/1.5, height: 60)
        let snackbar = SnackbarView(viewModel: viewModel,frame:frame)
        showSnackBar(snackBar: snackbar)
    }
    
    private func showAlert(){
        let alert = UIAlertController(title: "It works", message: "You tap the action", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }

    public func showSnackBar(snackBar: SnackbarView){
        let width = view.frame.size.width/1.5
        snackBar.frame = CGRect(x: (view.frame.size.width-width)/2, y: view.frame.size.height, width: width, height: 60)
        view.addSubview(snackBar)
        UIView.animate(withDuration: 0.5, animations: {
            snackBar.frame = CGRect(x: (self.view.frame.size.width-width)/2, y: self.view.frame.size.height-100, width: width, height: 60)
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+4, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        snackBar.frame = CGRect(x: (self.view.frame.size.width-width)/2, y: self.view.frame.size.height, width: width, height: 60)
                    },completion: { finished in
                        if finished {
                            snackBar.removeFromSuperview()
                        }
                        
                    })
                })
            }
        })
    }

}


//
//  SnackbarView.swift
//  SnackBar
//
//  Created by Ngo Dang tan on 10/27/20.
//

import UIKit

class SnackbarView: UIView {
    
    let viewModel: SnackbarViewModel
    private var handler: Handler?
    private let label: UILabel = {
       let label = UILabel()
        label.textColor = .systemBackground
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(viewModel: SnackbarViewModel,frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        addSubview(label)
        
        if viewModel.image != nil {
            addSubview(imageView)
        }
        
        backgroundColor = .label
        
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        
        configure()
    }
    
    private func configure(){
        label.text = viewModel.text
        imageView.image = viewModel.image
        
        switch viewModel.type {
        case .action(let handler):
            self.handler = handler
            
            isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSnackBar))
            gesture.numberOfTouchesRequired = 1
            gesture.numberOfTapsRequired = 1
            addGestureRecognizer(gesture)
            
        case .info: break
       
        }
    }
    
    @objc private func didTapSnackBar(){
        handler?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        if viewModel.image != nil {
            imageView.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.height-10)
            label.frame = CGRect(x: imageView.frame.size.width, y: 0, width: frame.size.width - imageView.frame.size.width-5, height: frame.size.height)
        }else{
            label.frame = bounds
        }
    }
    

    
    


}

//
//  SnackBarViewModel.swift
//  SnackBar
//
//  Created by Ngo Dang tan on 10/27/20.
//

import Foundation
import UIKit
typealias Handler = (() -> Void)

enum SnackbarViewType {
    case info
    case action(handler: Handler)
}

struct SnackbarViewModel {
    let type: SnackbarViewType
    let text:String
    let image:UIImage?
}

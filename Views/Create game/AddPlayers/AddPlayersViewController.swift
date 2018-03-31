//
//  AddPlayersViewController.swift
//  Views
//
//  Created by Богдан Маншилин on 31/03/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import Core_UI
import ViewModels

public protocol AddPlayersViewControlling: ProgressedStep {}

final class AddPlayersViewController: UIView, AddPlayersViewControlling {
    var viewModel: AddPlayersViewModelling
    var io: ProgressedStepIO
    var view: UIView! {
        return self
    }
    
    init(viewModel: AddPlayersViewModelling, io: ProgressedStepIO) {
        self.viewModel = viewModel
        self.io = io
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

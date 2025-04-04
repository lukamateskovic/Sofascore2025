//
//  BasketballViewController.swift
//  Sofascore
//
//  Created by Luka Matešković on 26.03.2025..
//

import UIKit
import SnapKit

class BasketballViewController: UIViewController {
    
    private var basketballView: UILabel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        styleViews()
        setupConstraints()
    }
    
    private func createViews() {
        view.addSubview(basketballView)
    }
    
    private func styleViews() {
        basketballView.text = "Nema trenutnih utakmica"
        basketballView.textAlignment = .center
        basketballView.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    private func setupConstraints() {
        basketballView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
}

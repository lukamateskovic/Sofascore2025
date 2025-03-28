//
//  BasketballViewController.swift
//  Sofascore
//
//  Created by Luka Matešković on 26.03.2025..
//

import UIKit
import SnapKit

class BasketballViewController: UIViewController {
    
    private var basketballView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        setupConstraints()
    }
    
    private func createViews() {
        basketballView = UILabel()
        basketballView.text = "Nema trenutnih utakmica"
        basketballView.textAlignment = .center
        basketballView.font = .systemFont(ofSize: 16, weight: .bold)
        view.addSubview(basketballView)
    }
    
    private func setupConstraints() {
        basketballView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}

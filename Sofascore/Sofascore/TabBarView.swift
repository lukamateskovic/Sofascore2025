import UIKit
import SnapKit
import SofaAcademic

protocol TabBarViewDelegate: AnyObject {
    func didSelectTab(index: Int)
}

final class TabBarView: BaseView {
    private let stackView: UIStackView = .init()
    private let indicator: UIView = .init()
    private var buttons: [TabButton] = []
    weak var delegate: TabBarViewDelegate?
    
    override func addViews() {
        addSubview(stackView)
        addSubview(indicator)
    }
    
    override func styleViews() {
        backgroundColor = .systemBlue
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        indicator.backgroundColor = .white
        indicator.layer.cornerRadius = 2
    }
    
    override func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        indicator.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(3)
            $0.width.equalTo(100)
        }
    }
    
    func configure(tabs: [String], initialSelectedIndex: Int = 0) {
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        tabs.forEach { title in
            let button = TabButton(title: title)
            button.onTap = { [weak self] in
                guard let self = self else { return }
                let index = self.buttons.firstIndex(of: button)!
                self.selectTab(at: index)
            }
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
        
        selectTab(at: initialSelectedIndex)
    }
    
    private func selectTab(at index: Int) {
        guard index < buttons.count else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.indicator.snp.remakeConstraints {
                $0.bottom.equalToSuperview()
                $0.height.equalTo(3)
                $0.width.equalTo(100)
                $0.centerX.equalTo(self.buttons[index])
            }
            self.layoutIfNeeded()
        }
        
        delegate?.didSelectTab(index: index)
    }
}

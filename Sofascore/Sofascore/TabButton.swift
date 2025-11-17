import UIKit
import SnapKit
import SofaAcademic

final class TabButton: BaseView {
    private let titleLabel: UILabel = .init()
    private let button: UIButton = .init()
    var onTap: (() -> Void)?
    
    init(title: String) {
        super.init()
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addViews() {
        addSubview(titleLabel)
        addSubview(button)
    }
    
    override func styleViews() {
        titleLabel.font = .roboto(size: 16)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        button.backgroundColor = .clear
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupGestureRecognizers() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        onTap?()
    }
}

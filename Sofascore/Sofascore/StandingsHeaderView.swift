import UIKit
import SnapKit
import SofaAcademic

final class StandingsHeaderView: BaseView {
    private var labels: [UILabel] = []
    private let containerView = UIView()
    
    override func addViews() {
        addSubview(containerView)
    }
    
    override func styleViews() {
        backgroundColor = .white
    }
    
    override func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(48)
        }
    }
    
    func configure(titles: [String], sport: SportSlug) {
        labels.forEach { $0.removeFromSuperview() }
        labels.removeAll()
        
        for title in titles {
            let label = UILabel()
            label.text = title
            label.font = .roboto(size: 14)
            label.textColor = .gray
            label.textAlignment = .center
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
            containerView.addSubview(label)
            labels.append(label)
        }
        
        labels[1].textAlignment = .left
        
        switch sport {
        case .football:
            setupFootballConstraints()
        case .basketball:
            setupBasketballConstraints()
        case .americanFootball:
            setupAmericanFootballConstraints()
        }
    }
    
    private func setupFootballConstraints() {
        guard labels.count >= 8 else { return }
        labels[0].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(8)
        }
        labels[1].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[0].snp.trailing).offset(16)
            $0.width.equalTo(104)
        }
        labels[2].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[1].snp.trailing).offset(8)
            $0.width.equalTo(24)
        }
        labels[3].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[2].snp.trailing).offset(8)
            $0.width.equalTo(24)
        }
        labels[4].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[3].snp.trailing).offset(8)
            $0.width.equalTo(24)
        }
        labels[5].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[4].snp.trailing).offset(8)
            $0.width.equalTo(24)
        }
        labels[6].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[5].snp.trailing).offset(8)
            $0.width.equalTo(40)
        }
        labels[7].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[6].snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    private func setupBasketballConstraints() {
        guard labels.count >= 9 else { return }
        labels[0].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(8)
        }
        labels[1].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[0].snp.trailing).offset(16)
            $0.width.equalTo(80)
        }
        labels[2].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[1].snp.trailing).offset(8)
            $0.width.equalTo(24)
        }
        labels[3].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[2].snp.trailing).offset(4)
            $0.width.equalTo(24)
        }
        labels[4].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[3].snp.trailing).offset(4)
            $0.width.equalTo(24)
        }
        labels[5].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[4].snp.trailing).offset(4)
            $0.width.equalTo(32)
        }
        labels[6].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[5].snp.trailing).offset(4)
            $0.width.equalTo(24)
        }
        labels[7].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[6].snp.trailing).offset(4)
            $0.width.equalTo(32)
        }
        labels[8].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[7].snp.trailing).offset(4)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    private func setupAmericanFootballConstraints() {
        guard labels.count >= 7 else { return }
        labels[0].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(8)
        }
        labels[1].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[0].snp.trailing).offset(16)
            $0.width.equalTo(104)
        }
        labels[2].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[1].snp.trailing).offset(40)
            $0.width.equalTo(24)
        }
        labels[3].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[2].snp.trailing).offset(8)
            $0.width.equalTo(24)
        }
        labels[4].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[3].snp.trailing).offset(8)
            $0.width.equalTo(24)
        }
        labels[5].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[4].snp.trailing).offset(8)
            $0.width.equalTo(24)
        }
        labels[6].snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(labels[5].snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
}

import UIKit
import SnapKit
import SofaAcademic

final class VenueView: BaseView {
    private let titleLabel: UILabel = .init()
    private let stadiumRow: UIStackView = .init()
    private let stadiumLeft: UILabel = .init()
    private let stadiumRight: UILabel = .init()
    private let capacityRow: UIStackView = .init()
    private let capacityLabelLeft: UILabel = .init()
    private let capacityLabelRight: UILabel = .init()
    
    override func addViews() {
        addSubview(titleLabel)
        addSubview(stadiumRow)
        addSubview(capacityRow)
        stadiumRow.addArrangedSubview(stadiumLeft)
        stadiumRow.addArrangedSubview(stadiumRight)
        capacityRow.addArrangedSubview(capacityLabelLeft)
        capacityRow.addArrangedSubview(capacityLabelRight)
    }
    override func styleViews() {
        titleLabel.text = "Venue"
        titleLabel.font = .roboto(size: 16, weight: .bold)
        titleLabel.textAlignment = .center
        stadiumRow.axis = .horizontal
        stadiumRow.distribution = .equalSpacing
        stadiumLeft.font = .roboto(size: 15)
        stadiumLeft.textColor = .gray
        stadiumLeft.text = "Stadium"
        stadiumRight.font = .roboto(size: 15, weight: .medium)
        capacityRow.axis = .horizontal
        capacityRow.distribution = .equalSpacing
        capacityLabelLeft.font = .roboto(size: 14)
        capacityLabelLeft.textColor = .gray
        capacityLabelLeft.text = "Capacity"
        capacityLabelRight.font = .roboto(size: 15, weight: .medium)
    }
    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        stadiumRow.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        capacityRow.snp.makeConstraints {
            $0.top.equalTo(stadiumRow.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    func configure(venue: TeamVenue?) {
        stadiumRight.text = venue?.name ?? "-"
        if let cap = venue?.capacity {
            capacityLabelRight.text = String(cap)
        } else {
            capacityLabelRight.text = nil
        }
    }
}


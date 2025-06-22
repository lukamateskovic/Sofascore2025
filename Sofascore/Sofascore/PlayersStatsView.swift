import UIKit
import SnapKit
import SofaAcademic

final class PlayersStatsView: BaseView {

    private let totalStack: UIStackView = .init()
    private let totalIconImageView: UIImageView = .init()
    private let totalNumberLabel: UILabel = .init()
    private let totalDescriptionLabel: UILabel = .init()

    private let foreignStack: UIStackView = .init()
    private let foreignIconImageView: UIImageView = .init()
    private let foreignNumberLabel: UILabel = .init()
    private let foreignDescriptionLabel: UILabel = .init()

    private let mainStack: UIStackView = .init()
    
    override func addViews() {
        addSubview(mainStack)

        totalStack.addArrangedSubview(totalIconImageView)
        totalStack.addArrangedSubview(totalNumberLabel)
        totalStack.addArrangedSubview(totalDescriptionLabel)
        
        foreignStack.addArrangedSubview(foreignIconImageView)
        foreignStack.addArrangedSubview(foreignNumberLabel)
        foreignStack.addArrangedSubview(foreignDescriptionLabel)
        
        mainStack.addArrangedSubview(totalStack)
        mainStack.addArrangedSubview(foreignStack)
    }
    
    override func styleViews() {

        mainStack.axis = .horizontal
        mainStack.distribution = .fillEqually
        mainStack.spacing = 24
        mainStack.alignment = .top
        
        totalStack.axis = .vertical
        totalStack.alignment = .center
        totalStack.spacing = 8
        
        totalIconImageView.image = UIImage(systemName: "person.3.fill")
        totalIconImageView.tintColor = .systemBlue
        totalIconImageView.contentMode = .scaleAspectFit
        
        totalNumberLabel.font = .roboto(size: 14, weight: .bold)
        totalNumberLabel.textColor = .systemBlue
        totalNumberLabel.textAlignment = .center
        
        totalDescriptionLabel.text = "Total Players"
        totalDescriptionLabel.font = .roboto(size: 12)
        totalDescriptionLabel.textColor = .systemGray
        totalDescriptionLabel.textAlignment = .center
        
        foreignStack.axis = .vertical
        foreignStack.alignment = .center
        foreignStack.spacing = 8
        
        foreignIconImageView.image = UIImage(named: "Pie Chart")
        foreignIconImageView.tintColor = .systemBlue
        foreignIconImageView.contentMode = .scaleAspectFit
        
        foreignNumberLabel.font = .roboto(size: 14, weight: .bold)
        foreignNumberLabel.textColor = .systemBlue
        foreignNumberLabel.textAlignment = .center
        
        foreignDescriptionLabel.text = "Foreign Players"
        foreignDescriptionLabel.font = .roboto(size: 12)
        foreignDescriptionLabel.textColor = .systemGray
        foreignDescriptionLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        totalIconImageView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(60)
        }
        
        totalNumberLabel.snp.makeConstraints {
            $0.top.equalTo(totalIconImageView.snp.bottom).offset(8)
        }
        
        totalDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(totalNumberLabel.snp.bottom).offset(8)
        }
        
        foreignIconImageView.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        foreignNumberLabel.snp.makeConstraints {
            $0.top.equalTo(foreignIconImageView.snp.bottom).offset(8)
        }
        
        foreignDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(foreignNumberLabel.snp.bottom).offset(8)
        }
    }
    
    func configure(total: Int, foreign: Int) {
        totalNumberLabel.text = "\(total)"
        foreignNumberLabel.text = "\(foreign)"
    }
}


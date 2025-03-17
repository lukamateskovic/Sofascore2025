import UIKit
import SnapKit
import SofaAcademic

final class LeagueView: BaseView {
    
    var logoImageView: UIImageView!
    var countryLabel: UILabel!
    var pointer: UIImageView!
    var leagueLabel: UILabel!
    
    override func addViews() {
        logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logoImageView)
                
        countryLabel = UILabel()
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(countryLabel)
                
        pointer = UIImageView()
        pointer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pointer)
                
        leagueLabel = UILabel()
        leagueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leagueLabel)
    }
    
    override func styleViews() {
        logoImageView.contentMode = .scaleAspectFit
        
        countryLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        countryLabel.textColor = .black
        
        pointer.contentMode = .scaleAspectFit
        
        leagueLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        leagueLabel.textColor = .gray
    }
    
    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(32)
        }
        
        countryLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(logoImageView.snp.trailing).offset(32)
            $0.width.equalTo(40)
            $0.height.equalTo(16)
        }
        
        pointer.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(countryLabel.snp.trailing).offset(7)
            $0.width.equalTo(10)
            $0.height.equalTo(10)
        }
        
        leagueLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(pointer.snp.trailing).offset(7)
            $0.width.equalTo(91)
            $0.height.equalTo(16)
            $0.trailing.equalToSuperview().inset(129)
        }
    }
    
    

}


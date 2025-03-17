import UIKit
import SnapKit
import SofaAcademic

final class LeagueView: BaseView {
    
    private var logoImageView: UIImageView!
    private var countryLabel: UILabel!
    private var pointer: UIImageView!
    private var leagueLabel: UILabel!
    
    override func addViews() {
        logoImageView = UIImageView()
        addSubview(logoImageView)
        countryLabel = UILabel()
        addSubview(countryLabel)
        pointer = UIImageView()
        addSubview(pointer)
        leagueLabel = UILabel()
        addSubview(leagueLabel)
    }
    
    override func styleViews() {
        logoImageView.contentMode = .scaleAspectFit
        
        countryLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        countryLabel.textColor = .black
        
        pointer.contentMode = .scaleAspectFit
        
        leagueLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
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
            $0.width.equalTo(36)
            $0.height.equalTo(16)
        }
        
        pointer.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(countryLabel.snp.trailing).offset(0)
            $0.width.height.equalTo(24)
        }
        
        leagueLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(logoImageView.snp.trailing).offset(0)
            $0.width.equalTo(91)
            $0.height.equalTo(16)
            $0.trailing.equalToSuperview().inset(129)
        }
    }
    
    

}

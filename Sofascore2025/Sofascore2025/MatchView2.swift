import UIKit
import SofaAcademic
import SnapKit

class MatchView2: BaseView {

    private let homeLogoImageView = UIImageView()
    private let awayLogoImageView = UIImageView()
    private let timestampLabel = UILabel()

    override func addViews() {
        addSubview(homeLogoImageView)
        addSubview(awayLogoImageView)
        addSubview(timestampLabel)
    }

    override func styleViews() {
        timestampLabel.font = Fonts.subtitleFont
        timestampLabel.textColor = Colors.secondaryTextColor

        homeLogoImageView.contentMode = .scaleAspectFit
        awayLogoImageView.contentMode = .scaleAspectFit
    }

    override func setupConstraints() {
        homeLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        awayLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            homeLogoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            homeLogoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            homeLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            homeLogoImageView.heightAnchor.constraint(equalToConstant: 40),

            awayLogoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            awayLogoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            awayLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            awayLogoImageView.heightAnchor.constraint(equalToConstant: 40),

            timestampLabel.topAnchor.constraint(equalTo: homeLogoImageView.bottomAnchor, constant: 8),
            timestampLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            timestampLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }

    func configure(with event: Event) {
        if let urlStringHome = event.homeTeam.logoUrl,
           let urlHome = URL(string: urlStringHome) {
            // Load image (use SDWebImage or similar library in real projects)
            homeLogoImageView.load(urlHome)
        }
        
        if let urlStringAway = event.awayTeam.logoUrl,
           let urlAway = URL(string: urlStringAway) {
            awayLogoImageView.load(urlAway)
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, dd MMM yyyy"
        
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        timestampLabel.text = dateFormatter.string(from: date)
    }
}

import UIKit
import SnapKit

class beViewController: UIViewController {
    
    private var customView: UIView!
    private var customView1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        createView()
        layoutView()
        
    }
    
    private func createView() {
        customView = makeUIImageView()
        view.addSubview(customView)
        customView1 = makeUILabel()
        view.addSubview(customView1)
    }
    
    private func layoutView() {
        customView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        customView1.snp.makeConstraints {
            $0.size.equalTo(customView)
            $0.leading.equalTo(customView.snp.trailing).offset(30)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func makeUILabel() -> UILabel {
        let label = UILabel()
        label.text = "Hello, World!"
        label.textColor = .black
        label.font = .systemFont(ofSize: 36, weight: .bold)
        return label
    }
    
    private let imageURL = URL(string: "https://img.sofascore.com/api/v1/unique-tournament/8/image")!
    
    private func makeUIImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "luka")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func makeUIButton() -> UIButton {
        let button = UIButton(type: .system)
        return button
    }
}

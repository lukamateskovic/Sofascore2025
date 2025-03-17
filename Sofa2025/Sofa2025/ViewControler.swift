import UIKit
import SnapKit

class bViewController: UIViewController {
    
    private var blueView: UIView!
    private var redView: UIView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        view.backgroundColor = .white
        createViews()
        layoutScenario1()
        
        }
    
    private func createViews() {
        
        blueView = UIView()
        blueView.backgroundColor = .blue
        view.addSubview(blueView)
        
        redView = UIView()
        redView.backgroundColor = .red
        view.addSubview(redView)
    }
    
    private func layoutScenario1() {
        blueView.snp.makeConstraints{
            $0.height.equalTo(100)
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        redView.snp.makeConstraints{
            $0.size.equalTo(blueView)
            $0.leading.equalTo(blueView.snp.trailing).offset(30)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
    }
}

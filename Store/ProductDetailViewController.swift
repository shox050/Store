//
//  DetailViewController.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit
import MessageUI

protocol ProductDetailController {
    func configure(with configuration: ProductDetailConfiguration)
}

class ProductDetailViewController: UIViewController {
    
    private let constants = Constants()
    private var detailViewModel: DetailViewModel!
    
    @IBOutlet private weak var lName: UILabel!
    @IBOutlet private weak var lDescription: UILabel!
    @IBOutlet private weak var lCost: UILabel!
    
    @IBAction private func createPdf(_ sender: UIBarButtonItem) {
        detailViewModel.renderPdf { [weak self] attachment in
            self?.sendMail(with: attachment)
        }
    }
    @IBAction private func actionBuy(_ sender: UIButton) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) { [weak self] in
            DispatchQueue.main.sync {
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lName.text = detailViewModel.name
        lDescription.text = detailViewModel.description
        lCost.text = String(detailViewModel.cost)
    }
}

extension ProductDetailViewController: ProductDetailController {
    func configure(with configuration: ProductDetailConfiguration) {
        
        detailViewModel = DetailViewModel(configuration.product)
    }
}


extension ProductDetailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension ProductDetailViewController {
    func sendMail(with attachment: Data) {
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setMessageBody("Hello world!", isHTML: false)
        
        mail.addAttachmentData(attachment, mimeType: Constants.MimeType.pdf, fileName: Constants.Identifier.attachmentName)
        present(mail, animated: true)
    }
}

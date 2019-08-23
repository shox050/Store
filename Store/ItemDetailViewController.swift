//
//  DetailViewController.swift
//  Store
//
//  Created by Vladimir on 20/08/2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit
import MessageUI

protocol ItemDetailController {
    func configure(with configuration: DetailConfiguration)
}

class DetailViewController: UIViewController {
    
    private var detailViewModel: DetailViewModel!
    
    @IBOutlet private weak var lName: UILabel!
    @IBOutlet private weak var lDescription: UILabel!
    @IBOutlet private weak var lCost: UILabel!
    
    @IBAction private func createPdf(_ sender: UIBarButtonItem) {
        detailViewModel.renderPdf { [weak self] in
            self? .sendMail()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lName.text = detailViewModel.name
        lDescription.text = detailViewModel.description
        lCost.text = String(detailViewModel.cost)
    }
}

extension DetailViewController: ItemDetailController {
    func configure(with configuration: DetailConfiguration) {
        
        detailViewModel = DetailViewModel(configuration.item)
    }
}


extension DetailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension DetailViewController {
    func sendMail() {
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setMessageBody("Hello world!", isHTML: false)
        
        let url = URL(string: "file:///Users/vladimir/Documents/myFile.pdf")!
        var data: Data?
        
        do {
            let data2 = try Data(contentsOf: url)
            print("Data2 ", data2)
            data = data2
        } catch let error {
            print("Error contentsOf url ", error.localizedDescription)
        }
        
        if let data = data {
            mail.addAttachmentData(data, mimeType: "application/pdf", fileName: "myFile.pdf")
            present(mail, animated: true)
        } else {
            print("Data nil")
        }
    }
}

//
//  AnswerAttachmentViewController.swift
//  DTAdmin
//
//  Created by ITA student on 11/15/17.
//  Copyright © 2017 if-ios-077. All rights reserved.
//

import UIKit

class AnswerAttachmentViewController: ParentViewController {

    @IBOutlet weak var answerTextLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var answerAttachmentImageView: UIImageView!
    
    var answerId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("Answer detail",
                                                      comment: "Title for AnswerAttachmentViewController")
        
        showAnswerRecord()
    }
    
    private func showAnswerRecord() {
        startActivity()
        guard let id = answerId else { return }
        DataManager.shared.getEntity(byId: id, typeEntity: .answer) {(answerRecord, errorMessage) in
            self.stopActivity()
            if errorMessage == nil {
                guard let answer = answerRecord as? AnswerStructure else { return }
                self.answerTextLabel.text = answer.answerText
                if answer.attachment.count > 0 {
                    self.answerAttachmentImageView.image = UIImage.decode(fromBase64: answer.attachment)
                } else {
                    self.answerAttachmentImageView.image = UIImage(named: "Image")
                }
            } else {
                self.showWarningMsg(errorMessage?.message ?? NSLocalizedString("Incorect type data",
                                                                      comment: "Message for user about incorect data"))
            }
        }
    }

}

// MARK: - UIScrollViewDelegate
extension AnswerAttachmentViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.answerAttachmentImageView
    }

}

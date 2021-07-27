//
//  Protocola.swift
//  MoodNotes
//
//  Created by Utkarsh Dixit on 27/7/21.
//

import Foundation

protocol ModalTransitionListener {
    func popoverDismissed(mood: String)
}

class ModalTransitionMediator {
    /* Singleton */
    class var instance: ModalTransitionMediator {
        struct Static {
            static let instance: ModalTransitionMediator = ModalTransitionMediator()
        }
        return Static.instance
    }

private var listener: ModalTransitionListener?

private init() {

}

func setListener(listener: ModalTransitionListener) {
    self.listener = listener
}

    func sendPopoverDismissed(modelChanged: Bool, newMood: String) {
    listener?.popoverDismissed(mood: newMood)
}
}

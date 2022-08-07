//
//  ChatViewModel.swift
//  Rapptr iOS Test
//
//  Created by Michael  Bruin on 8/4/22.
//

import Foundation

class ChatViewModel {
    let chat: Variable<[Message]> = Variable([])
    let error: Variable<Error?> = Variable(nil)

    private let service: ChatClient

    init(service: ChatClient) {
        self.service = service
    }

    func fetchData() {
        service.fetchChatData { [weak self] result in
            switch result {
            case .success(let chatResponse):
                self?.chat.value = chatResponse.data
            case .failure(let error):
                self?.error.value = error
            }
        }
    }
}

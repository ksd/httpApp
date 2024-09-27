//
//  StateController.swift
//  httpApp
//
//  Created by ksd on 18/09/2024.
//

import SwiftUI

@Observable
class StateController {
    var users: [User] = []
    var images: [UIImage] = []
    
    init(){
        guard let randomUserURL = URL(string: "https://randomuser.me/api/?nat=DK&results=100") else { return }
        fetchUsers(from: randomUserURL)
    }
    
    private func fetchUsers(from url: URL) {
        Task(priority: .low) {
            guard let rawUserData = await NetworkService.getData(from: url) else { return }
            let decoder = JSONDecoder()
            do {
                let jsonResult = try decoder.decode(RandomUserResult.self, from: rawUserData)
                Task {@MainActor in
                    self.users = jsonResult.results
                    try await withThrowingTaskGroup(of: UIImage.self) { taskGroup in
                        for user in self.users {
                            taskGroup.addTask {
                                return await self.fetchImage(from: user.picture.large)
                            }
                        }
                        var localImages: [UIImage] = []
                        for try await data in taskGroup {
                            localImages.append(data)
                        }
                        self.images = localImages
                    }
                }
            } catch {
                fatalError("Konverteringen gik ikke så godt!: \(error.localizedDescription)")
            }
        }
    }
    
     func fetchImage(from url: URL) async -> UIImage {
        let downloadTask = Task(priority: .background) { () -> UIImage in
            guard let rawData = await NetworkService.getData(from: url) else {
                return UIImage()
            }
            return UIImage(data: rawData)!
        }
        let result = await downloadTask.result
        return result.get()
    }

}

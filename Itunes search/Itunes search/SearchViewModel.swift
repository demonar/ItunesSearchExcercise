//
//  SearchViewModel.swift
//  Itunes search
//
//  Created by Alejandro Moya on 09/08/2018.
//  Copyright © 2018 Alejandro Moya. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
class SearchViewModel: BaseViewModel {
    var filter = SearchType.music
    var searchText = ""
    
    override func retrieveData(complete: @escaping () -> Void) {
        var requestConfig = ListRequestConfig()
        requestConfig.searchText = self.searchText
        requestConfig.filter = self.filter
        Alamofire.request(Networking.search(requestConfig)).validate().responseArray(keyPath: "results") { [weak self](response: DataResponse<[SearchElement]>) in
            guard let this = self else { return }
            this.results = response.value ?? []
            complete()
        }
    }
}

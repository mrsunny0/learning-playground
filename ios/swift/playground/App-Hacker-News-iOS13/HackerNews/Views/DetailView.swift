//
//  DetailView.swift
//  HackerNews
//
//  Created by George Sun on 4/26/20.
//  Copyright © 2020 George Sun. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    let url: String?
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "www.google.com")
    }
}

//
//  Text.swift
//  Pokemon Characters
//
//  Created by Do Linh on 12/26/24.
//

import SwiftUI

extension Text {
    func title() -> some View {
        self.font(Font.custom("BowlbyOne-Regular", size: 30, relativeTo: .title))
            .foregroundStyle(.text)
    }
    
    func logo() -> some View {
        self.font(Font.custom("BowlbyOne-Regular", size: 22, relativeTo: .title))
            .foregroundStyle(.text)
    }
    
    func heading() -> some View {
        self.font(Font.custom("Chivo-Bold", size: 22, relativeTo: .title2))
            .foregroundStyle(.text)
    }
    
    func subheading() -> some View {
        self.font(Font.custom("Chivo-Bold", size: 20, relativeTo: .title3))
            .foregroundStyle(.text)
    }
    
    func regular() -> some View {
        self.font(Font.custom("Chivo-Regular", size: 18, relativeTo: .body))
            .foregroundStyle(.text)
    }
    
    func caption() -> some View {
        self.font(Font.custom("Chivo-Light", size: 16, relativeTo: .caption))
            .foregroundStyle(Color.caption)
    }
}

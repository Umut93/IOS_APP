//
//  FontExtensions.swift
//  HabiCenInspectionApp
//
//  Created by Mikkel Brøgger Jensen on 20/07/2022.
//

import Foundation
import SwiftUI

extension Font {
    enum HabiCen {
        static var caption2: Font {
            Font.custom("ProximaNova-Regular", size: 11, relativeTo: .caption2)
        }

        static var caption2Bold: Font {
            Font.custom("ProximaNova-Semibold", size: 11, relativeTo: .caption2)
        }

        static var caption: Font {
            Font.custom("ProximaNova-Regular", size: 12, relativeTo: .caption)
        }

        static var captionBold: Font {
            Font.custom("ProximaNova-Semibold", size: 12, relativeTo: .caption)
        }

        static var footnote: Font {
            Font.custom("ProximaNova-Regular", size: 13, relativeTo: .footnote)
        }

        static var footnoteBold: Font {
            Font.custom("ProximaNova-Semibold", size: 13, relativeTo: .footnote)
        }

        static var subheadline: Font {
            Font.custom("Satoshi-Regular", size: 15, relativeTo: .subheadline)
        }

        static var subheadlineBold: Font {
            Font.custom("Satoshi-Bold", size: 15, relativeTo: .subheadline)
        }

        static var callout: Font {
            Font.custom("ProximaNova-Regular", size: 16, relativeTo: .callout)
        }

        static var calloutBold: Font {
            Font.custom("ProximaNova-Semibold", size: 16, relativeTo: .callout)
        }

        static var body: Font {
            Font.custom("ProximaNova-Regular", size: 17, relativeTo: .body)
        }

        static var bodyBold: Font {
            Font.custom("ProximaNova-Bold", size: 17, relativeTo: .body)
        }

        static var headline: Font {
            Font.custom("Satoshi-Medium", size: 17, relativeTo: .headline)
        }

        static var headlineBold: Font {
            Font.custom("Satoshi-Bold", size: 17, relativeTo: .headline)
        }

        static var title3: Font {
            Font.custom("Satoshi-Regular", size: 20, relativeTo: .title3)
        }

        static var title3Bold: Font {
            Font.custom("Satoshi-Bold", size: 20, relativeTo: .title3)
        }

        static var title2: Font {
            Font.custom("Satoshi-Regular", size: 22, relativeTo: .title2)
        }

        static var title2Bold: Font {
            Font.custom("Satoshi-Bold", size: 22, relativeTo: .title2)
        }

        static var title: Font {
            Font.custom("Satoshi-Regular", size: 28, relativeTo: .title)
        }

        static var titleBold: Font {
            Font.custom("Satoshi-Bold", size: 28, relativeTo: .title)
        }

        static var largeTitle: Font {
            Font.custom("Satoshi-Regular", size: 34, relativeTo: .largeTitle)
        }

        static var largeTitleBold: Font {
            Font.custom("Satoshi-Bold", size: 34, relativeTo: .largeTitle)
        }
    }

    static var Awesome: Font {
        Font.custom("FontAwesome6Pro-Light", size: 17)
    }
}

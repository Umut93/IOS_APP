# Introduction 
This is HabiCen Inspection SwiftUI App.

# Design Choices
The Authentication in this app is based on a guide from Microsoft
some changes have been made to allign the code more with the newer swiftUI

Guide: https://docs.microsoft.com/en-us/azure/active-directory/develop/tutorial-v2-ios

# Getting Started
Intended structure
- HabiCenInspectionApp
    - models
        - data models
    - resources
        - resources like assets & localisation
    - stores
        - data repositories
    - tools
        - reusable tools and overrides
    - views
        - views and view-models
- HabiCenInspectionAppTests
    - TODO: Fill intended use
- HabiCenInspectionAppUITests
    - TODO: Fill intended use

Change the baseURL in APIClient.Swift func createURL
to you own windows machine localhost ip

TODO: Replace bundle identifier when using "Unik" domain...
- Temporary: unik.poc-login-b2c-swift
- Permanent: dk.unik.habicen.inspection
Replaced so builds would not be affected when doing the final builds on another "account"...

# Considerations
The built-in dependency injection in swift leaves much to be desired,
so many apps have used a library called Resolver. The person who created 
Resolver has created a new DI Library based on SwiftUI called Factory: https://github.com/hmlongco/Factory
We should, together with Appa talk about the possiblity to use this or another library
to make our code testable

# Build and Test
Just Works™️

# Contribute
Team Rock It

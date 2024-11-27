# AllRecipes
Fetch-AllRecipes-Demo
### Steps to Run the App
1.	Ensure you have Xcode 16 or later installed on your Mac.
2.	Open the project in Xcode by double-clicking the .xcodeproj file or using File > Open in Xcode.
3.	Select a target simulator or connect a physical device running iOS 17.0 or later.
4.	Press Cmd + R or click the “Run” button in Xcode to build and launch the app.
5.	On launch, the app will load data from the main endpoint.
6.	To switch endpoints and view different results, tap the trailing button in the navigation bar and select from the three demo endpoints.
7.	Refresh the recipe list by performing a pull-to-refresh gesture or tapping the refresh button.

Note: This project has no external dependencies, so it should build and run without additional setup.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
1.	Unit Testing - I prioritized unit testing to address a gap in my previous development experience. Approximately half of my time was spent learning how to write tests, adapting my code to be more testable, and applying these new skills.
2.	Image Caching - I refactored image caching logic from a previous implementation that relied on DispatchQueue locks and was not testable. This iteration is more modular, testable, and leverages FileManager for better structure.
3.	Networking Layer - Despite only needing two types of GET requests, I implemented a reusable network manager to allow the app to hypothetically scale. I developed this component with the assistance of ChatGPT.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent approximately two workdays on this project. While the instructions suggested most developers complete it in 4–5 hours, there was no explicit time limit. Within the first two hours, I had downloaded and displayed the recipe data. Additional time was spent refining features, adding tests, and enhancing the backend components.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
1.	Backend vs. Frontend - I prioritized backend functionality over frontend design. While apps often follow an established design language or are guided by designers, I focused on building a simple, modular backend to handle potential scaling without third-party libraries.
2.	Endpoint Switching - I did not implement environment schemes for switching endpoints. Instead, I used a button in the navigation bar for faster testing during development.
3.	Image Caching Memory Usage - The three-tiered caching system (in-memory dictionary, FileManager, and network fetch) works efficiently for small images but could cause excessive RAM usage over time with thousands of recipes. Additionally, large images cached in the detail view could lead to higher memory consumption. With more time, I would implement a more optimized slow-fetch mechanism for large images.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The unit testing is the weakest area due to my limited prior experience. These are the first unit tests I have written, and they were implemented after watching two WWDC 2024 sessions and conducting 1.5 hours of additional research. While functional, I am confident there is room for improvement as I continue to learn more about XCTest/Swift Testing and best practices.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
No external libraries or dependencies were used in this project. While a third-party image caching library could have saved time, implementing my own solution provided an opportunity to write tests and refine my understanding of caching mechanisms.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I spent extra time on this project to focus on learning and implementing unit tests for the first time, refining a scalable networking layer, and building a modular image caching system. While functional, the caching approach may require further optimization for memory usage with larger datasets. I avoided third-party libraries to ensure the app is self-contained and maintainable.



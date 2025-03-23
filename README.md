# Assignment 3: Offline Capabilities with Local Storage
# 1. Project Setup
I started by creating a Flutter project and added the necessary dependencies in pubspec.yaml.

Dependencies Added:

provider: State management to manage and share the state of the app.

sqflite: For local database support to store product data offline.

cached_network_image: To cache images locally for offline use.

connectivity_plus: To check internet connectivity status.
# 2. State Management with ProviderI used the Provider package for managing state across the app. Here's a breakdown:

ProductProvider: This class is responsible for managing the loading state and the list of products. It interacts with the API and the database to fetch the product data.

Consumer Widget: In the UI, the Consumer widget listens to the ProductProvider to rebuild the UI whenever the product list is updated.
# 3. Fetching Data from API
I used the ApiService class to fetch data from an external API (FakeStore API) and then store it in the SQLite database. This service checks if the app is online and fetches new data from the API; otherwise, it retrieves the data from the local database.
# 4. Local Storage with SQLite (sqflite)
To persist product data for offline use, we used the sqflite package. The data fetched from the API is stored in a local SQLite database and can be retrieved later even when the user is offline.
# 5. Image Caching for Offline Support
I used the CachedNetworkImage widget to cache images locally. The images are stored on the device the first time they are loaded, and then they are served from the cache when the app is offline.
# 7. App Initialization & Database Handling
The database is initialized during the app startup, and the products are preloaded from the local database if offline, or fetched from the API if online.
# 8. Handling Connectivity
I check the internet connectivity using the connectivity_plus package and show the appropriate data based on whether the app is online or offline.
# Features
fatches data from (https://fakestoreapi.com/products)

# The Apk File
https://drive.google.com/file/d/1a85piEeO4si3Z0JbqwLC_seiIiC56jHj/view?usp=sharing

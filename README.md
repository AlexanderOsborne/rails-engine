# README

# Rails Engine

### About this App

This API allows the user to query endpoints to retrieve information related to Merchants, Items, and Sales.

## Versions

- Ruby 2.5.3

- Rails 5.2.4.3

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]


<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#schema">Schema</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Application

Endpoints and example queries are listed below.

Merchants:
Example JSON response for the Merchant resource:
```
{
  "data": [
    {
      "id": "1",
        "type": "merchant",
        "attributes": {
          "name": "Mike's Awesome Store",
        }
    },
{
```
- get all merchants, allows for pagination
  ```
  GET /api/v1/merchants?per_page=50&page=2
  ```
- get one merchant
```
GET /api/v1/merchant/:id
```
- get all items for a given merchant ID
```
GET /api/v1/merchants/:id/items 
```


Items:
Example of JSON response for Item resource.
```
{
  "data": {
    "id": "1",
    "type": "item",
    "attributes": {
      "name": "Super Widget",
      "description": "A most excellent widget of the finest crafting",
      "unit_price": 109.99
    }
  }
}
```
- get all items, allows for pagination
```
- GET /api/v1/items?per_page=50&page=2
```
- get one item
```
GET /api/v1/item/:id
```
- create an item
```
POST /api/v1/items
```
- edit an item
```
PUT /api/v1/items/:id
```
- delete an item
```
POST /api/v1/items
```
- get the merchant data for a given item ID
```
GET /api/v1/items/:id/merchant
```

NonCrud Endpoints
- Find merchant based on partial search
```
GET /api/v1/merchants/find
```
- Find all Items based on partial search
```
GET /api/v1/items/find_all
```
- Find top merchants by revenue
```
GET /api/v1/revenue/merchants
```
- Find total revenue for a given merchant
```
GET /api/v1/revenue/merchants/:id
```
- find potential(unshipped) revenue by largest invoice
```
GET /api/v1/revenue/unshipped
```
- find merhants with largest potential(unshipped) revenue
```
GET /api/v1/revenue/merchant_unshipped
```

### Built With

* [Ruby on Rails](https://rubyonrails.org/)
* [RSpec](https://github.com/rspec/rspec-rails)
* [JSONAPI](https://github.com/jsonapi-serializer/jsonapi-serializer)



See the [open issues](https://github.com/AlexanderOsborne/rails-engine/issues) for a list of proposed features (and known issues).



<!-- GETTING STARTED -->
## Getting Started

### Installation

2. Fork and Clone the repo
   ```
   git clone [https://github.com/AlexanderOsborne/rails-engine]
   ```
3. Install gems
     -- For list of Gems see [here](https://github.com/AlexanderOsborne/rails-engine/blob/main/Gemfile)
   ```
   bundle install
   ```
4. Setup the database: 
   ```
   rails db:setup
   ```

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Project Link: [https://github.com/AlexanderOsborne/rails-engine](https://github.com/AlexanderOsborne/rails-engine)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Img Shields](https://shields.io)
* [MIT Open Source License](https://opensource.org/licenses/MIT)
* [GitHub Pages](https://pages.github.com)






<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/viewingparty/viewing_party.svg?style=for-the-badge
[contributors-url]: https://github.com/viewingparty/viewing_party/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/viewingparty/viewing_party.svg?style=for-the-badge
[forks-url]: https://github.com/viewingparty/viewing_party/network/members
[stars-shield]: https://img.shields.io/github/stars/viewingparty/viewing_party.svg?style=for-the-badge
[stars-url]: https://github.com/viewingparty/viewing_party/stargazers
[issues-shield]: https://img.shields.io/github/issues/viewingparty/viewing_party.svg?style=for-the-badge
[issues-url]: https://github.com/viewingparty/viewing_party/issues
[product-screenshot]: images/screenshot.png


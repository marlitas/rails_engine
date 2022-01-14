<!-- PROJECT INFO -->
<h1 align="center">
  <br>
  Rails Engine
  <br>
</h1>

<h4 align="center">RESTful API for a fictitious e-commerce site that provides business analytics for frontend consumption.</h4>

<p align="center">
  <a href="https://github.com/marlitas/rails_engine/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/marlitas/rails_engine?style=for-the-badge" alt="contributors_badge">
  </a>
  <a href="https://github.com/marlitas/rails_engine/network/members">
    <img src="https://img.shields.io/github/forks/marlitas/rails_engine?style=for-the-badge" alt="forks_badge">
  </a>
  <a href="https://github.com/marlitas/rails_engine/stargazers">
    <img src="https://img.shields.io/github/stars/marlitas/rails_engine?style=for-the-badge" alt="stars_badge">
  </a>
  <a href="https://github.com/marlitas/rails_engine/issues">
    <img src="https://img.shields.io/github/issues/marlitas/rails_engine?style=for-the-badge" alt="issues_badge">
  
  
<!-- CONTENTS -->
<p align="center">
  <a href="#about-the-project">About The Project</a> •
  <a href="#tools-used">Tools Used</a> •
  <a href="#set-up">Set Up</a> •
  <a href="#installation">Installation</a> •
  <a href="#how-to-use">How To Use</a> •
  <a href="#database-schema">Database Schema</a> •
  <a href="#contributing">Contributing</a> •
  <a href="#acknowledgements">Acknowledgements</a>
</p>



## About The Project

Rails Engine was built to practice RESTful API development for a front end consumption. The API uses Active Record and SQL to create business analytics and expose select data and information for a front end team. 

### Learning Goals

* Building and testing a RESTful API
* Active Record/SQL queries
* Serializing data to follow proper JSON contracts
* CRUD functionality



## Tools Used

| Development | Testing       | Gems            |
|   :----:    |    :----:     |    :----:       |
| Ruby 2.7.2  | RSpec         | Pry             |
| Rails 5.2.5 | SimpleCov     | ShouldaMatchers |
| JSON        | FactoryBot    | Faraday         |
| Atom        | Faker         | FastJSON        |
| Git/Github  |       |      |
| Heroku      |          |                 |



## Set Up

1. To clone and run this application, you'll need Ruby 2.7.2 and Rails 2.5.3. Using [rbenv](https://github.com/rbenv/rbenv) you can install Ruby 2.7.2 (if you don't have it already) with:
```sh
rbenv install 2.7.2
```
2. With rbenv you can set up your Ruby version for a directory and all subdirectories within it. Change into a directory that will eventually contain this repo and then run:
```sh
rbenv local 2.7.2
```
You can check that your Ruby version is correct with `ruby -v`

3. Once you have verified your Ruby version is 2.7.2, check if you have Rails. From the command line:
```sh
rails -v
```
4. If you get a message saying rails is not installed or you do not have version 5.2.5, run
```sh
gem install rails --version 5.2.5
```
5. You may need to quit and restart your terminal session to see these changes show up



## Installation

1. Fork this repo
2. Clone your new repo
   ```sh
   git clone https://github.com/#{your_github_username}/rails_engine.git
   ```
3. Install gems
   ```sh
   bundle install
   ``` 
4. Setup the database
    ```sh
   rails db:create
   rails db:migrate
   ```


## How To Use

Rails Engine can be used to access fictitious e-commerce data and calculations. 



### Endpoint Documentation
Request:
`GET /api/v1/merchants?per_page=50&page=2`

Response:
```json
{
  "data": [
    {
      "id": "1",
        "type": "merchant",
        "attributes": {
          "name": "Store 1",
        }
    },
    {
      "id": "2",
      "type": "merchant",
      "attributes": {
        "name": "Store 2",
      }
    },
    {
      "id": "3",
      "type": "merchant",
      "attributes": {
        "name": "Store 3",
      }
    }
  ]
}
```

Request:
`GET /api/v1/<resource>/:id`

Response:
```json
{
  "data": {
    "id": "1",
    "type": "item",
    "attributes": {
      "name": "Bouncy Ball",
      "description": "A really bouncy ball",
      "unit_price": 109.99
    }
  }
}
```
    
Request:
`POST /api/v1/items`
    
 ```json
 {
  "name": "value1",
  "description": "value2",
  "unit_price": 100.99,
  "merchant_id": 14
 }
 ```

Response:
```json
{
  "data": {
    "id": "16",
    "type": "item",
    "attributes": {
      "name": "Widget",
      "description": "High quality widget",
      "unit_price": 100.99,
      "merchant_id": 14
    }
  }
}
```


## Contributing

👤  **Marla Schulz**
- [GitHub](https://github.com/marlitas)
- [LinkedIn](https://www.linkedin.com/in/marla-a-schulz/)


## Acknowledgements

* [Turing School of Software and Design](https://turing.edu/)
  - Project created for completion towards Backend Engineering Program

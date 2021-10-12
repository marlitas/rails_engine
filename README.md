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
   git clone https://github.com/#{your_github_username}/ArtspirationBE.git
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
5. 



## How To Use

The Artspiration Backend can be used to retrieve user preferences for artwork, as well as make calls to the Artsy API for specific artwork information including: title, artist, image(jpg). The backend can also provide daily recommendations for a piece of art based on past user preferences. Preferences are generated through label and image properties determined by the Google Cloud Vision API. The recommendation engine is built using a combination of collaborative filtering as well as sorting through the saved user preferences.



### Endpoint Documentation
[User Endpoint](https://peaceful-reef-61917.herokuapp.com/api/v1/users/133)
<br>
Request:
`/api/v1/users/:id`

Response:
```json
{
  "data": {
  "id": "133",
  "type": "user",
  "attributes": {
    "name": "Melanie Swaniawski",
    "email": "shameka_goyette@bartell.co"
    }
  }
}
```

[Recommeded Art Endpoint](https://peaceful-reef-61917.herokuapp.com/api/v1/users/133/recommendations)
<br>
Request:
`/api/v1/users/:id/recommendations`

Response:
```json
{
  "data": [
    {
      "id": 168,
      "type": "recommended_art",
      "attributes": {
        "title": "Virgin of the Rocks",
        "image": "https://d32dm0rphc51dk.cloudfront.net/Jv-e1fhDjg61OYhhsMoiQg/{image_version}.jpg",
        "user_id": 133
      }
    }
  ]
}
```

[Rated Art Index Endpoint](https://peaceful-reef-61917.herokuapp.com/api/v1/users/133/rated_arts)
<br>
Request:
`/api/v1/users/:id/rated_arts`

Response:
```json
{
  "data": [
      {
        "id": 175,
        "type": "rated_art",
        "attributes": {
          "title": "La Grande Odalisque",
          "image": "https://d32dm0rphc51dk.cloudfront.net/crVj8GvGliFrpExNfHWl4Q/medium.jpg",
          "liked": true,
          "user_id": 145
        }
      },
      {
        "id": 184,
        "type": "rated_art",
        "attributes": {
          "title": "L'Embarquement pour Cythère (The Embarkation for Cythera)",
          "image": "https://d32dm0rphc51dk.cloudfront.net/Ux_L_UKjxgR-gJ6XZYVgVg/medium.jpg",
          "liked": true,
          "user_id": 145
        }
      }
   ]
}
```

[Rated Art Show Endpoint](https://peaceful-reef-61917.herokuapp.com/api/v1/users/145/rated_arts/174)
<br>
Request:
`/api/v1/users/:id/rated_arts/:art_id`

Response:
```json
{
  "data": {
    "id": 106,
    "type": "rated_art",
    "attributes": {
      "title": "The Tête à Tête",
      "image": "https://d32dm0rphc51dk.cloudfront.net/5KJ7_u7BPqeltkfEnyijIw/medium.jpg",
      "liked": true,
      "user_id": 145
    }
  }
}
```



## Database Schema
![artspiration_be_schema](https://user-images.githubusercontent.com/80797707/134600560-be2d2a0d-290d-4757-b28f-1eb24a929f03.jpg)



## Contributing

👤  **Marla Schulz**
- [GitHub](https://github.com/marlitas)
- [LinkedIn](https://www.linkedin.com/in/marla-a-schulz/)


## Acknowledgements

* [Turing School of Software and Design](https://turing.edu/)
  - Project created for completion towards Backend Engineering Program

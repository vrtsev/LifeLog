Feature: Authorization
  In order to use all features on site
  As guest
  I want to authorize on site

  Background:
    Given I as guest
    And i visit home page

  Scenario: registration on site
    When i click on link 'Регистрация'
    And I fill registration fields with data:
      | name       | email          | password |
      | Site Admin | admin@blog.net | password |
    # And i click on button 'Зарегистрироваться'
    # Then site should redirect to my publications
    # And page should contain text 'Site Admin'
    # And page should contain text 'Подписаться'
    # And page should contain text 'Профиль'
    # And page should contain text 'Нет записей'

  Scenario: visit login page
    When i click on link 'Вход'
    Then site should redirect to login page
    And page should contain header 'Вход в персональный аккаунт LifeLog'
    And page should contain field 'user[email]'
    And page should contain field 'user[password]'
    And page should contain button 'Вход'

  Scenario: login on site
    Given following users:
      | name | email         | visible |
      | John | john@blog.net | true    |
    When i click on link 'Вход'
    And i fill 'user[email]' field with 'John'
    And i fill 'user[password]' field with 'password'
    And i click on button 'Вход'
    # Then site should redirect to my publications
    # And page should contain text 'Site Admin'
    # And page should contain text 'Подписаться'
    # And page should contain text 'Профиль'
    # And page should contain text 'Нет записей'

  Scenario: Logout
    Given following users:
      | name | email         | visible |
      | John | john@blog.net | true    |
    And i sign in as 'john@blog.net'
    # When i visit my publications page
    # And i click on link 'Выйти'
    # Then site should redirect to landing page
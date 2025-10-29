@checkout
Feature: SauceDemo Checkout Flow
  As a logged-in user
  I want to complete a purchase
  So that I can confirm my order

  Background:
    Given I am logged in as "standard_user" with password "secret_sauce"

  Scenario: Successful checkout
    When I add the product "Sauce Labs Bike Light" to the cart
    And I proceed to checkout with first name "John", last name "Doe", and zip "12345"
    Then I should see the order confirmation message "Thank you for your order!"

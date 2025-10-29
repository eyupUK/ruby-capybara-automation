@regression
Feature: SauceDemo Add to Cart
  As a logged-in user
  I want to add products to the cart
  So that I can proceed to checkout

  Background:
    Given I am logged in as "standard_user" with password "secret_sauce"

  Scenario: Add and remove a product
    When I add the product "Sauce Labs Backpack" to the cart
    Then the cart badge should display "1"
    When I remove the product "Sauce Labs Backpack" from the cart
    Then the cart badge should be empty

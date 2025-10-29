@smoke
Feature: SauceDemo Login
  As a SauceDemo user
  I want to log into the site
  So that I can view products

  Background:
    Given I am on the SauceDemo login page

  Scenario Outline: Valid and invalid login attempts
    When I log in with username "<username>" and password "<password>"
    Then I should see "<expected>"

    Examples:
      | username        | password      | expected                         |
      | standard_user   | secret_sauce  | Products                         |
      | locked_out_user | secret_sauce  | Epic sadface: Sorry, this user has been locked out. |

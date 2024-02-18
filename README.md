# Vueling Flight Search Test

This is a simple automated test script for the flight search functionality on the Vueling website. The script is written in Ruby and uses the Selenium WebDriver and Test-Unit for testing.

## Requirements

- Ruby
- Selenium WebDriver
- Test-Unit
- Firefox Browser

## Setup

1. Install Ruby: You can download Ruby from [here](https://www.ruby-lang.org/en/downloads/).
2. Install Selenium WebDriver: Run `gem install selenium-webdriver` in your terminal.
3. Install Test-Unit: Run `gem install test-unit` in your terminal.
4. Install Firefox: You can download Firefox from [here](https://www.mozilla.org/en-US/firefox/new/).

## Running the Test

To run the test, navigate to the directory containing the `vueling_test.rb` file in your terminal and run the following command:

```bash
ruby vueling_test.rb
```

## Test Details

The test performs the following steps:

1. Navigates to the Vueling website.
2. Accepts cookies.
3. Selects 'Madrid' as the origin city.
4. Selects 'Barcelona' as the destination city.
5. Selects a one-way flight for a specified date.
6. Submits the search.
7. Switches to the results window.
8. Asserts that results are present.

The test will pass if there are search results and fail if there are no search results.

## Note

This test script is for demonstration purposes only and may not work if Vueling changes their website structure. Always make sure to respect the terms of service of the website you are testing.

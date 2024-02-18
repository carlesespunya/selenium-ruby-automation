require 'selenium-webdriver'
require 'test-unit'
require 'test/unit/ui/console/testrunner'
require 'date'

class VuelingTest < Test::Unit::TestCase
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @url = "https://www.vueling.com/es"
    @driver.manage.timeouts.implicit_wait = 30
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_flight_search
    navigate_to(@url)
    accept_cookies
    select_origin('Madrid')
    select_destination('Barcelona')
    select_one_way_date('2024-6-1')
    submit_search
    switch_to_results_window
    assert_results_present
  end

  def teardown
    @driver.quit
  end

  private

  def navigate_to(url)
    @driver.get(url)
  end

  def accept_cookies
    @wait.until { @driver.find_element(:id, "onetrust-accept-btn-handler") }.click
    sleep 1
  end

  def select_origin(city)
    @wait.until { @driver.find_element(:css, ".form-input.origin") }.click
    @driver.find_element(:xpath, "//li[@class='liStation' and .//p[contains(text(), '#{city}')]]").click
  end

  def select_destination(city)
    @wait.until { @driver.find_element(:css, ".form-input.destination") }.click
    @driver.find_element(:xpath, "//li[@class='liStation' and .//p[contains(text(), '#{city}')]]").click
  end

  def select_one_way_date(date)
    date_array = date.split('-')
    month_to_date = month_to_date(date)
    date_string = "#{date_array[0]}#{month_to_date + 1}#{date_array[2]}"

    @wait.until { @driver.find_element(:css, ".form-input.dates") }.click
    @driver.find_element(:css, "#oneWayLabel .txt-s").click
    go_to_month(month_to_date)

    @driver.find_element(:id, "calendarDaysTable#{date_string}").click
  end

  def month_to_date(date)
    date_parsed = Date.parse(date)
    today = Date.today

    (date_parsed.year - today.year) * 12 + (date_parsed.month - today.month)
  end

  def go_to_month(month_to_date)
    month_to_date.times do
      @driver.find_element(:css, "#nextButtonCalendar").click
    end
  end

  def submit_search
    @wait.until { @driver.find_element(:id, "btnSubmitHomeSearcher") }.click
  end

  def switch_to_results_window
    @driver.switch_to.window(@driver.window_handles.last)
    @wait.until { @driver.find_element(:css, "#menuTop") }
  end

  def assert_results_present
    trip_selector_items = @driver.find_elements(:css, "#flightCardsContainer .trip-selector_item")
    assert_not_empty(trip_selector_items)
  end
end

# If you want to save the report in a file, you can must uncheck the next line and add "> test_report.txt" at the end of the command
# Test::Unit::UI::Console::TestRunner.run(VuelingTest.suite)

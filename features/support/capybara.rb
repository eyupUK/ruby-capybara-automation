World(Capybara::DSL)
After do |scenario|
  if scenario.failed?
    FileUtils.mkdir_p('reports/screenshots')
    path = "reports/screenshots/#{scenario.__id__}.png"
    save_screenshot(path)
    attach(File.open(path), 'image/png')
  end
end

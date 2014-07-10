class Capybara::Session
  def has_map?
    has_css?('.gm-style')
  end
end
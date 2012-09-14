Before do
  ActiveRecord::Fixtures.reset_cache
  fixtures_folder = File.join(Rails.root, 'test', 'fixtures')
  fixtures = Dir[File.join(fixtures_folder, '*.yml')].map do |f|
    File.basename(f, '.yml')
  end
  ActiveRecord::Fixtures.create_fixtures(fixtures_folder, fixtures)
end

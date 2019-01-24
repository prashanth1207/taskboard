Apipie.configure do |config|
  config.app_name                = 'Taskboard'
  config.app_info                = 'Taskboard to keep track of projects'
  config.api_base_url            = '/taskboard/api/v1/'
  config.doc_base_url            = '/apipie'
  config.translate               = false
  # where is your API defined?
  config.api_controllers_matcher = Rails.root.join('app', 'controllers', '{[!concerns]**}', '*.rb').to_s
end

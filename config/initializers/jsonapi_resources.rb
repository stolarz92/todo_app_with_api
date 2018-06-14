JSONAPI.configure do |config|
  # built in paginators are :none, :offset, :paged
  # config.default_paginator = :offset

  config.default_paginator = :disabled
  config.default_page_size = 20
  config.maximum_page_size = 40

  config.top_level_meta_include_page_count = true
  config.top_level_meta_include_record_count = true
end
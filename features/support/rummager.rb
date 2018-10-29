require "gds_api/test_helpers/rummager"

Before do
  stub_any_rummager_search_to_return_no_results
end

World(GdsApi::TestHelpers::Rummager)

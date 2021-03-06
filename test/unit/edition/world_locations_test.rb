require "test_helper"

class Edition::WorldLocationsTest < ActiveSupport::TestCase
  test "#destroy should also remove the relationship" do
    edition = create(:draft_publication, world_locations: [create(:world_location)])
    relation = edition.edition_world_locations.first
    edition.destroy
    refute EditionWorldLocation.find_by(id: relation.id)
  end
end

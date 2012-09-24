module Edition::MainstreamCategory
  extend ActiveSupport::Concern

  class Trait < Edition::Traits::Trait
    def process_associations_before_save(edition)
      edition.edition_mainstream_categories = @edition.edition_mainstream_categories.map do |emc|
        EditionMainstreamCategory.new(emc.attributes.except(:id))
      end
    end
  end

  included do
    belongs_to :primary_mainstream_category, class_name: "MainstreamCategory"

    has_many :edition_mainstream_categories, dependent: :destroy,
             foreign_key: :edition_id
    has_many :other_mainstream_categories, through: :edition_mainstream_categories,
             source: :mainstream_category

    add_trait Trait
  end

  def mainstream_categories
    [primary_mainstream_category] + other_mainstream_categories
  end
end

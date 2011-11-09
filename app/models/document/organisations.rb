module Document::Organisations
  extend ActiveSupport::Concern

  class Trait < Document::Traits::Trait
    def assign_associations_to(document)
      document.organisations = @document.organisations
    end
  end

  included do
    has_many :document_organisations, foreign_key: :document_id
    has_many :organisations, through: :document_organisations

    add_trait Trait
  end

  module ClassMethods
    def in_organisation(organisation)
      joins(:organisations).where('organisations.id' => organisation)
    end
  end
end
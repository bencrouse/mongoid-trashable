module Mongoid
  class Trash
    include Mongoid::Document
    include Mongoid::Timestamps

    field :trashable_document, type: Hash, default: {}
    belongs_to :trashable, polymorphic: true
    before_save :copy_trashable_document

    def copy_trashable_document
      self.trashable_document = trashable.as_document
    end

    def restore
      restored = trashable_type.constantize.new(trashable_document)
      result = restored.save
      restored.errors.each { |attribute, error| errors.add(attribute, error) }
      result
    end
  end
end

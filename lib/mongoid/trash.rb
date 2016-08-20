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
      new_instance = trashable_type.constantize.new(trashable_document)
      new_instance.save
    end
  end
end

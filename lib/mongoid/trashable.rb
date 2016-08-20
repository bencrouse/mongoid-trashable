require 'mongoid'
require 'mongoid/trash'
require 'mongoid/trashable/version'

module Mongoid
  module Trashable
    extend ActiveSupport::Concern

    included do
      before_destroy :trash
    end

    def delete(*)
      trash # Ensure this is created
      super
    end

    def trash
      @trash ||= Trash.create(trashable: self)
    end
  end
end

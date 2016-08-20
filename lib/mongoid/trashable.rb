require 'mongoid'
require 'mongoid/trash'
require 'mongoid/trashable/version'

module Mongoid
  module Trashable
    extend ActiveSupport::Concern

    included do
      before_destroy :create_trash
    end

    private

    def create_trash
      Trash.create(trashable: self)
    end
  end
end

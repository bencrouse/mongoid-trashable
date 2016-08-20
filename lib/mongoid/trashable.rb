require 'mongoid'
require 'mongoid/trash'
require 'mongoid/trashable/version'

module Mongoid
  module Trashable
    extend ActiveSupport::Concern

    included do
      before_destroy :trash
    end

    # Creates a piece of trash and ignores callbacks
    def delete(*)
      trash # Ensure this is created
      super
    end

    # Does not create a piece of trash and ignore callbacks
    def delete!
      without_trashing { delete }
    end

    def destroy!
      without_trashing { destroy }
    end

    def trash
      @trash ||= Trash.create(trashable: self) unless @_ignore_trash
    end

    def without_trashing
      @_ignore_trash = true
      yield
      @_ignore_trash = false
    end
  end
end

require 'test_helper'

class Mongoid::TrashableTest < Minitest::Test
  class FooModel
    include Mongoid::Document
    include Mongoid::Trashable
    field :name, type: String
  end

  def test_that_it_has_a_version_number
    refute_nil ::Mongoid::Trashable::VERSION
  end

  def test_destroying_a_trashable
    foo = FooModel.create!(name: 'Foo')
    assert(FooModel.unscoped.count == 1)

    foo.destroy
    assert(FooModel.unscoped.count == 0)
    assert(Mongoid::Trash.count == 1)

    trash = Mongoid::Trash.first
    assert(trash.trashable_type == foo.class.name)
    assert(trash.trashable_id == foo.id)
    assert(trash.trashable_document == foo.as_document)
  end

  def test_deleting_a_trashable
    foo = FooModel.create!(name: 'Foo')
    assert(FooModel.unscoped.count == 1)

    foo.delete
    assert(FooModel.unscoped.count == 0)
    assert(Mongoid::Trash.count == 1)

    trash = Mongoid::Trash.first
    assert(trash.trashable_type == foo.class.name)
    assert(trash.trashable_id == foo.id)
    assert(trash.trashable_document == foo.as_document)
  end
end

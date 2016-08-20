require 'test_helper'

class Mongoid::TrashableTest < Minitest::Test
  class FooModel
    include Mongoid::Document
    include Mongoid::Trashable
    field :name, type: String
    validates_uniqueness_of :name
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

  def test_deleting_a_trashable_without_trash
    foo = FooModel.create!(name: 'Foo')
    assert(FooModel.unscoped.count == 1)

    foo.delete!
    assert(FooModel.unscoped.count == 0)
    assert(Mongoid::Trash.count == 0)

    foo = FooModel.create!(name: 'Foo')
    assert(FooModel.unscoped.count == 1)

    foo.destroy!
    assert(FooModel.unscoped.count == 0)
    assert(Mongoid::Trash.count == 0)
  end

  def test_restoring_a_piece_of_trash
    foo = FooModel.create!(name: 'Foo')
    foo.destroy
    assert(FooModel.unscoped.count == 0)

    trash = Mongoid::Trash.first
    trash.restore

    restored_foo = FooModel.find(foo.id)
    assert(restored_foo == foo)
  end

  def test_errors_restoring_a_piece_of_trash
    FooModel.create!(name: 'Foo').destroy
    FooModel.create!(name: 'Foo')
    assert(FooModel.unscoped.count == 1)

    trash = Mongoid::Trash.first
    refute(trash.restore)
    assert(trash.errors.size == 1)
    assert(FooModel.unscoped.count == 1)
  end
end

class Gallery < ActiveRecord::Base
  belongs_to :user, inverse_of: :galleries

  validates :name, presence: true

  scope :owned_by, ->(user) { where(user_id: user.id) }

  def self.default_name
    'General'
  end

  def default?
    user && user.galleries.order(:created_at).first == self
  end

  # empty? is a special method in Rails and overriding it generated
  # validation errors, so we use an alternate name.
  def no_items?
    repo_objects.empty? && curriculum_materials.empty?
  end

  def add_item(type, item_id)
    case type
    when 'repo_object'
      # |= combines lists without creating duplicates
      self.repo_objects |= [item_id]
    when 'curriculum_material'
      # |= combines lists without creating duplicates
      self.curriculum_materials |= [item_id.to_i]
    else
      raise ArgumentError, type.to_s +
                           ' is not a valid item type. Valid types are: repo_object, curriculum_material'
    end
  end

  def remove_item(type, item_id)
    case type
    when 'repo_object'
      # -= will quietly succeed if item_id is not in the array, which is what we want.
      self.repo_objects -= [item_id]
    when 'curriculum_material'
      self.curriculum_materials -= [item_id.to_i]
    else
      raise ArgumentError, type.to_s +
                           ' is not a valid item type. Valid types are: repo_object, curriculum_material'
    end
  end
end

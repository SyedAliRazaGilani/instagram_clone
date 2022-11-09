# frozen_string_literal: true

# comment policy
class CommentPolicy < ApplicationPolicy
  def new?
    user.present?
  end
  
  def create?
    user.present?
  end

  def edit?
    user.present? && user.id == record.user_id
  end

  def update?
    edit?
  end

  def destroy?
    user.present? && ((user.id == record.user_id) || (user.id == record.post.user_id))
  end
end

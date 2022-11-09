# frozen_string_literal: true

# story policy
class StoryPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    new?
  end

  def edit?
    user.present? && user.id == record.user_id
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end

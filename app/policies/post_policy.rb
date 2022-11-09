# frozen_string_literal: true

# post policy
class PostPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    user.present?
  end

  # def show?
  #   true
  # end

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

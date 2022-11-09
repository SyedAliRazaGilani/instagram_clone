# frozen_string_literal: true

# application policy
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  private

  def false_policy
    false
  end
end

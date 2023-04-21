# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present?
        scope.where('user_id != ?', user.id)
      else
        scope.all
      end
    end
  end

  def index?
    true
  end

  def mine?
    user.present?
  end

  def show?
    mine? ? user != product.user : true
  end

  def create?
    mine?
  end

  def update?
    mine? && user == product.user
  end

  def destroy?
    update?
  end

  private

  def product
    record
  end
end

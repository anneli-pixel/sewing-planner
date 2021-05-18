class ShoppingItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    true
  end

  def toggle_bought?
    record.user = user
  end

  def destroy?
    record.user = user
  end
end

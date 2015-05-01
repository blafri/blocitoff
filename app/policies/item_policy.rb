class ItemPolicy < ApplicationPolicy
  def create?
    user.present? && record.user == user
  end

  def new?
    false
  end
  
  def destroy?
    user.present? && record.user == user
  end
end
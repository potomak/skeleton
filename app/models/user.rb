class User < ActiveRecord::Base
  acts_as_authentic do |c|
    # for available options see documentation in: Authlogic::ActsAsAuthentic
    #c.my_config_option = my_value
  end

  attr_accessible :email, :password, :password_confirmation, :openid_identifier

  def active?
    !active_since.nil?
  end

  def activate!
    self.active_since = Time.now
    save!
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    Notifier.deliver_activation_confirmation(self)
  end
end

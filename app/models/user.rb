class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:nickname]

  validates_uniqueness_of :nickname
  validates_presence_of :nickname
  
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy

  #nicknameを利用してログインするようにオーバーライド
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      #認証の条件式を変更する
      where(conditions).where(["nickname = :value", { :value => nickname }]).first
    else
      where(conditions).first
    end
  end



  # No use email
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
end